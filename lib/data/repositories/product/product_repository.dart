import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../main.dart';
import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/loaders/loaders.dart';
import '../../../features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {
      final response = await _db
          .from('products')
          .select('''
          *,
          brand:brands(id, name, image)
        ''')
          .eq('is_featured', true).limit(6);

      final rows = response as List;

      return rows.map((raw) {
        Map<String, dynamic>? brand;
        final rawBrand = raw['brand'];
        if (rawBrand != null) {
          if (rawBrand is List && rawBrand.isNotEmpty) {
            brand = Map<String, dynamic>.from(rawBrand[0] as Map);
          } else if (rawBrand is Map) {
            brand = Map<String, dynamic>.from(rawBrand);
          }
        }

        // Build a cleaned map for ProductModel.fromMap()
        final cleaned = {
          ...Map<String, dynamic>.from(raw as Map),
          'brand': brand,
        };

        return ProductModel.fromMap(cleaned);
      }).toList();
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final response = await _db
          .from('products')
          .select('''
          *,
          brand:brands(id, name, image)
        ''')
          .eq('is_featured', true);

      final rows = response as List;

      return rows.map((raw) {
        // Normalize brand — Supabase sometimes returns a list
        Map<String, dynamic>? brand;
        final rawBrand = raw['brand'];
        if (rawBrand != null) {
          if (rawBrand is List && rawBrand.isNotEmpty) {
            brand = Map<String, dynamic>.from(rawBrand[0] as Map);
          } else if (rawBrand is Map) {
            brand = Map<String, dynamic>.from(rawBrand);
          }
        }

        // Build a cleaned map for ProductModel.fromMap()
        final cleaned = {
          ...Map<String, dynamic>.from(raw as Map),
          'brand': brand,
        };

        return ProductModel.fromMap(cleaned);
      }).toList();
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(PostgrestTransformBuilder<PostgrestList>? query,) async {
    try {
      final response = await query;

      final List<ProductModel> productList =
          (response as List).map((data) => ProductModel.fromMap(data)).toList();

      return productList;
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<List<ProductModel>> fetchFavouriteProducts(List<String> productIds,) async {
    try {
      final response = await _db
          .from('products')
          .select()
          .filter('id', 'in', '(${productIds.join(",")})');


      final List<ProductModel> productList =
      (response as List).map((data) => ProductModel.fromMap(data)).toList();

      return productList;
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }


  Future<List<ProductModel>> fetchProductForBrand({required String brandId, int limit = -1}) async {
    try {
      final response = limit == -1 ? await _db.from('products').select().eq('brand_id', brandId)
      : await _db.from('products').select().eq('brand_id', brandId).limit(limit);

      final products = response.map((raw) => ProductModel.fromMap(raw)).toList();
      return products;

    }on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }


  Future fetchCategoryProducts({required String categoryId, int limit = -1}) async {
    try {
      final response = limit == -1
          ? await _db
          .from('products')
          .select('''
          *,
          brand:brands(id, name, image)
        ''')
          .eq('category_id', categoryId)
          : await _db
          .from('products')
          .select('''
          *,
          brand:brands(id, name, image)
        ''')
          .eq('category_id', categoryId)
          .limit(limit);

      final products = response.map((raw) => ProductModel.fromMap(raw)).toList();
      return products;

    }on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<void> pushDummyData() async {
    try {
      final List<ProductModel> products = [
        ProductModel(
          title: 'Nike Sports Shoe',
          description: 'High-quality green Nike sports shoe.',
          price: 135.00,
          salePrice: 120.00,
          stock: 15,
          sku: 'ABR4568',
          thumbnail: EImages.productImage1,
          productType: 'ProductType.variable',
          isFeatured: true,
          brandId: '9e61a15f-808b-4e79-9ce6-0616bd8f6eed',
          categoryId: '0bb94f9c-086f-4f12-ad17-58ec981268f3',
        ),
        ProductModel(
          title: 'Blue T-shirt',
          description:
              'I mean tear the your T-Shirt and get a new one. life happens one, make it count \u{1F609}',
          price: 35.00,
          salePrice: 30.00,
          stock: 15,
          sku: 'ABR4568',
          thumbnail: EImages.productImage69,
          productType: 'ProductType.single',
          isFeatured: true,
          brandId: '6404402f-f33f-49b2-98b2-0b729f7a721a',
          categoryId: '8327d563-dbd1-4166-8c03-421c21092dd5',
        ),
        ProductModel(
          title: 'Leather brown Jacket',
          description: 'Dress in brown leather jacket. It\'s not demin',
          price: 380.00,
          salePrice: 30.00,
          stock: 15,
          sku: 'ABR4568',
          thumbnail: EImages.productImage64,
          productType: 'ProductType.single',
          isFeatured: false,
          brandId: '6404402f-f33f-49b2-98b2-0b729f7a721a',
          categoryId: '8327d563-dbd1-4166-8c03-421c21092dd5',
        ),
        ProductModel(
          title: 'Iphone 14 Pro',
          description: 'It\'s for you. Apple has never been tasted better.',
          price: 1200.00,
          salePrice: 1200.00,
          stock: 15,
          sku: 'ABR4568',
          thumbnail: EImages.productImage52,
          productType: 'ProductType.single',
          isFeatured: true,
          brandId: '197dc534-0a1a-49d9-a8ca-f8b8041f4567',
          categoryId: '409864a8-016b-4747-9df8-4539c930719a',
        ),

        ProductModel(
          title: '4 Color collar t-shirt dry fit',
          stock: 15,
          price: 135,
          isFeatured: true,
          thumbnail: EImages.productImage60,
          description:
              'This is a Product description for 4 Color collar t-shirt dry fit. There are more things that can be added but its just a demo and nothing else.',
          brandId: '6404402f-f33f-49b2-98b2-0b729f7a721a',
          salePrice: 30,
          sku: 'ABR4568',
          categoryId: '8327d563-dbd1-4166-8c03-421c21092dd5',
          productType: 'ProductType.variable',
        ),
      ];

      // Insert Product
      for (var product in products) {
        final insertedProduct =
            await _db
                .from('products')
                .insert(product.toJson())
                .select()
                .single();

        final productId = insertedProduct['id'] as String;

        // Step 2: Load image from assets
        final byteData = await rootBundle.load(product.thumbnail!);
        final fileBytes = byteData.buffer.asUint8List();

        // Extract filename from asset path (e.g. "icons8-bowling-64.png")
        final fileName = product.thumbnail!.split('/').last;

        // Step 3: Upload to bucket under that category's folder
        final path = 'thumbnails/$productId/$fileName';
        await supabase.storage
            .from('thumbnails')
            .uploadBinary(
              path,
              fileBytes,
              fileOptions: const FileOptions(contentType: 'image/png'),
            );

        // Step 4: Get public URL
        final imageUrl = supabase.storage.from('thumbnails').getPublicUrl(path);

        // Step 5: Update DB row with image URL
        await supabase
            .from('products')
            .update({'thumbnail': imageUrl})
            .eq('id', productId);
      }

      ELoaders.successSnackBar(
        title: 'Product Uploaded',
        message: 'Product, attributes, and variations uploaded successfully!',
      );
    } on PostgrestException catch (e) {
      ELoaders.errorSnackBar(title: 'Database Error', message: e.message);
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      ELoaders.errorSnackBar(
        title: 'Error',
        message: 'Something went wrong. Please try again.',
      );
      throw Exception('Something went wrong. Please try again');
    }
  }
}
