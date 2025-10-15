import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../main.dart';
import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/loaders/loaders.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  Future<List<BrandModel>> fetchAllBrands() async {
    try {
      final snapshot = await _db.from('brands').select();
      final list =
      (snapshot as List)
          .map((e) => BrandModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return list;
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<void> pushDummyData() async {
    try {
      final List<BrandModel> brands = [
        BrandModel(name: 'Nike',
            image: EImages.nikeLogo,
            isFeatured: true,
            categoryId: '0bb94f9c-086f-4f12-ad17-58ec981268f3'),
        BrandModel(name: 'Zara',
            image: EImages.zaraLogo,
            isFeatured: true,
            categoryId: '8327d563-dbd1-4166-8c03-421c21092dd5'),
        BrandModel(name: 'Apple',
            image: EImages.appleLogo,
            isFeatured: true,
            categoryId: '409864a8-016b-4747-9df8-4539c930719a'),
      ];

      for (var brand in brands) {
        // Step 1: Insert row (image = null initially)
        final inserted =
        await supabase
            .from('brands')
            .insert({
          'name': brand.name,
          'is_featured': brand.isFeatured,
          'image': null,
        })
            .select()
            .single();

        final id = inserted['id'] as String;

        // Step 2: Load image from assets
        final byteData = await rootBundle.load(brand.image);
        final fileBytes = byteData.buffer.asUint8List();

        // Extract filename from asset path (e.g. "icons8-bowling-64.png")
        final fileName = brand.image
            .split('/')
            .last;

        // Step 3: Upload to bucket under that category's folder
        final path = 'brands/$id/$fileName';
        await supabase.storage
            .from('brands')
            .uploadBinary(
          path,
          fileBytes,
          fileOptions: const FileOptions(contentType: 'image/png'),
        );

        // Step 4: Get public URL
        final imageUrl = supabase.storage.from('brands').getPublicUrl(path);

        // Step 5: Update DB row with image URL
        await supabase.from('brands').update({'image': imageUrl}).eq('id', id);
      }
      ELoaders.successSnackBar(
        title: 'Uploaded Successfully',
        message: 'Check the Home screen now.',
      );
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<List<BrandModel>> fetchBrandsForCategory(String categoryId) async {
    try {
      final response = await _db.from('brands').select().eq('category_id', categoryId).limit(2);

      final result = (response as List).map((e) => BrandModel.fromMap(e as Map<String, dynamic>)).toList();

      return result;

    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }
}