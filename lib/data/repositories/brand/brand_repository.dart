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

  Future<void> pushDummyData() async {
    try {
      final List<BrandModel> brands = [
        BrandModel(name: 'Nike', image: EImages.nikeLogo, isFeatured: true),
        BrandModel(name: 'Zara', image: EImages.zaraLogo, isFeatured: true),
        BrandModel(name: 'Apple', image: EImages.appleLogo, isFeatured: true),
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
        final fileName = brand.image.split('/').last;

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
}