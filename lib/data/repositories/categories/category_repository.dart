import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/shop/models/category_model.dart';
import '../../../main.dart';
import '../../../utlis/loaders/loaders.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.from('categories').select();
      final list =
          (snapshot as List)
              .map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
              .toList();
      return list;
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

  Future<void> pushDummyData() async {
    try {
      final List<CategoryModel> categories = [
        CategoryModel(
          image: EImages.sportIcon,
          name: 'Sports',
          isFeatured: true,
        ),
        CategoryModel(
          image: EImages.furnitureIcon,
          name: 'Furniture',
          isFeatured: true,
        ),
        CategoryModel(
          image: EImages.electronicsIcon,
          name: 'Electronics',
          isFeatured: true,
        ),
        CategoryModel(
          image: EImages.clothIcon,
          name: 'Clothes',
          isFeatured: true,
        ),
        CategoryModel(
          image: EImages.animalIcon,
          name: 'Animals',
          isFeatured: true,
        ),
        CategoryModel(image: EImages.shoeIcon, name: 'Shoes', isFeatured: true),
        CategoryModel(
          image: EImages.cosmeticsIcon,
          name: 'Cosmetics',
          isFeatured: true,
        ),
        CategoryModel(
          image: EImages.jeweleryIcon,
          name: 'Jewelery',
          isFeatured: true,
        ),
      ];

      for (var category in categories) {
        // Step 1: Insert row (image = null initially)
        final inserted =
            await supabase
                .from('categories')
                .insert({
                  'name': category.name,
                  'is_featured': category.isFeatured,
                  'parent_id': null,
                  'image': null,
                })
                .select()
                .single();

        final id = inserted['id'] as String;

        // Step 2: Load image from assets
        final byteData = await rootBundle.load(category.image);
        final fileBytes = byteData.buffer.asUint8List();

        // Extract filename from asset path (e.g. "icons8-bowling-64.png")
        final fileName = category.image.split('/').last;

        // Step 3: Upload to bucket under that category's folder
        final path = 'categories/$id/$fileName';
        await supabase.storage
            .from('categories')
            .uploadBinary(
              path,
              fileBytes,
              fileOptions: const FileOptions(contentType: 'image/png'),
            );

        // Step 4: Get public URL
        final imageUrl = supabase.storage.from('categories').getPublicUrl(path);

        // Step 5: Update DB row with image URL
        await supabase
            .from('categories')
            .update({'image': imageUrl})
            .eq('id', id);
      }
      ELoaders.errorSnackBar(
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
}
