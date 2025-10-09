import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../main.dart';
import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/loaders/loaders.dart';
import '../../../features/shop/models/product_variation_model.dart';

class ProductVariationRepository extends GetxController {
  static ProductVariationRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  // ... in ProductVariationRepository

  Future<List<ProductVariationModel>> getProductVariations(String productId) async {
    try {
      final response = await _db
          .from('product_variations')
          .select()
          .eq('product_id', productId);

      return (response as List)
          .map((e) => ProductVariationModel.fromMap(e))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception('Database Error fetching variations: ${e.message}');
    } catch (e) {
      throw Exception('Something went wrong fetching variations: $e');
    }
  }

  Future<void> pushDummyData() async {
    try {

      final List<ProductVariationModel> variations  = [
        ProductVariationModel(
          productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
          stock: 34,
          price: 134,
          salePrice: 122.6,
          image: EImages.productImage1,
          attributeValues: {'Color': 'Green', 'Size': 'EU 34'}, ),
        ProductVariationModel(
            productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
            stock: 15,
            price: 132,
            image: EImages.productImage23,
            attributeValues: {'Color': 'Black', 'Size': 'EU 32'}),
        ProductVariationModel(
            productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
            stock: 0,
            price: 234,
            image: EImages.productImage21,
            attributeValues: {'Color': 'Black', 'Size': 'EU 34'}),

        ProductVariationModel(
            productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
            stock: 222,
            price: 232,
            image: EImages.productImage1,
            attributeValues: {'Color': 'Green', 'Size': 'EU 32'}),
        ProductVariationModel(
            productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
            stock: 0,
            price: 334,
            image: EImages.productImage21,
            attributeValues: {'Color': 'Red', 'Size': 'EU 34'}),
        ProductVariationModel(
            productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
            stock: 11,
            price: 332,
            image: EImages.productImage21,
            attributeValues: {'Color': 'Red', 'Size': 'EU 32'}),

        ProductVariationModel(
            productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d',
            stock: 34,
            price: 134,
            salePrice: 122.6,
            image: EImages.productImage60,
            description: 'This is a Product description for 4 Color collar t-shirt dry fit',
            attributeValues: {'Color': 'Red', 'Size': 'EU 34'}),
        ProductVariationModel(
            productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d',
            stock: 15,
            price: 132,
            image: EImages.productImage60,
            attributeValues: {'Color': 'Red', 'Size': 'EU 32'}),
        ProductVariationModel(
            productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d',
            stock: 0,
            price: 234,
            image: EImages.productImage61,
            attributeValues: {'Color': 'Yellow', 'Size': 'EU 34'}),
        ProductVariationModel(
            productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d',
            stock: 222,
            price: 232,
            image: EImages.productImage61,
            attributeValues: {'Color': 'Yellow', 'Size': 'EU 32'}),
        ProductVariationModel(
            productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d',
            stock: 0,
            price: 334,
            image: EImages.productImage62,
            attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),
        ProductVariationModel(
            productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d',
            stock: 11,
            price: 332,
            image: EImages.productImage62,
            attributeValues: {'Color': 'Green', 'Size': 'EU 30'}),
        ProductVariationModel(
            productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d',
            stock: 0,
            price: 334,
            image: EImages.productImage63,
            attributeValues: {'Color': 'Blue', 'Size': 'EU 30'}),
        ProductVariationModel(
            productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d',
            stock: 11,
            price: 332,
            image: EImages.productImage63,
            attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
      ];


      for (var variation in variations) {
        final response = await supabase.from('product_variations').insert(variation.toJson()).select('*');

        if (response.isEmpty) {
          throw Exception('Insertion failed or did not return a row.');
        }
        final insertedRow = response.first;
        final id = insertedRow['id'] as String;

        final byteData = await rootBundle.load(variation.image);
        final fileBytes = byteData.buffer.asUint8List();

        final fileName = variation.image.split('/').last;

        final path = 'product_variations/$id/$fileName';
        await supabase.storage
            .from('product_variations')
            .uploadBinary(
          path,
          fileBytes,
          fileOptions: const FileOptions(contentType: 'image/png'),
        );
        final imageUrl = supabase.storage
            .from('product_variations')
            .getPublicUrl(path);

        await supabase
            .from('product_variations')
            .update({'image': imageUrl})
            .eq('id', id);
      }

      ELoaders.successSnackBar(
        title: 'Uploaded Successfully',
        message: 'Product variations uploaded successfully!',
      );
    }
    // ... Error handling remains the same ...
    on PostgrestException catch (e) {
      ELoaders.errorSnackBar(title: 'Database Error', message: e.message);
      throw Exception('Database Error: ${e.message}');
    }
    // Note: AuthException likely needs an import if it's a Supabase/custom class
    // on AuthException catch (e) {
    //   ELoaders.errorSnackBar(title: 'Auth Error', message: e.message);
    //   throw AuthException(e.message);
    // }
    catch (e) {
      ELoaders.errorSnackBar(
        title: 'Error',
        message: 'Something went wrong. Details: ${e.toString()}',
      );
      // Added e.toString() to the thrown exception for better debugging
      throw Exception('Something went wrong. Details: ${e.toString()}');
    }
  }
}
