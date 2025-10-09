import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/shop/models/product_images.dart';
import '../../../main.dart';
import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/loaders/loaders.dart';

class ProductImagesRepository extends GetxController {
  static ProductImagesRepository get instance => Get.find();

  final _db = Supabase.instance.client;
  late List<String> images;


  Future<List<String>> getProductImages(String productId) async {
    try {
      final response = await _db
          .from('product_images')
          .select('url, position')
          .eq('product_id', productId)
          .order('position', ascending: true);

      // response is a List<dynamic> of maps
      final List<String> images = response.map<String>((row) => row['url'] as String).toList();

      return images;
    }catch(e) {
      throw Exception('Failed to fetch product images: $e');
    }
  }

  Future<void> pushDummyData() async {
    try {
      final List<ProductImagesModel> images = [
        ProductImagesModel(
          productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
          url: EImages.productImage1,
          position: 01,
        ),
        ProductImagesModel(
          productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
          url: EImages.productImage23,
          position: 02,
        ),
        ProductImagesModel(
          productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
          url: EImages.productImage21,
          position: 03,
        ),
        ProductImagesModel(
          productId: '4a3909b7-ee5d-4656-93b8-0b2f6a8409df',
          url: EImages.productImage68,
          position: 01,
        ),
        ProductImagesModel(
          productId: '4a3909b7-ee5d-4656-93b8-0b2f6a8409df',
          url: EImages.productImage69,
          position: 02,
        ),
        ProductImagesModel(
          productId: '4a3909b7-ee5d-4656-93b8-0b2f6a8409df',
          url: EImages.productImage5,
          position: 03,
        ),
        ProductImagesModel(
          productId: 'dc8c453e-247b-4e30-b814-806db11ff69c',
          url: EImages.productImage65,
          position: 01,
        ),
        ProductImagesModel(
          productId: 'dc8c453e-247b-4e30-b814-806db11ff69c',
          url: EImages.productImage66,
          position: 02,
        ),
        ProductImagesModel(
          productId: 'dc8c453e-247b-4e30-b814-806db11ff69c',
          url: EImages.productImage67,
          position: 03,
        ),
        ProductImagesModel(
          productId: '6d877e22-bba9-4222-bcf3-3ec005be225f',
          url: EImages.productImage51,
          position: 01,
        ),
        ProductImagesModel(
          productId: '6d877e22-bba9-4222-bcf3-3ec005be225f',
          url: EImages.productImage52,
          position: 02,
        ),
        ProductImagesModel(
          productId: '6d877e22-bba9-4222-bcf3-3ec005be225f',
          url: EImages.productImage53,
          position: 03,
        ),
        
        ProductImagesModel(productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d', url: EImages.productImage60, position: 01),
        ProductImagesModel(productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d', url: EImages.productImage61, position: 02),
        ProductImagesModel(productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d', url: EImages.productImage62, position: 03),
        ProductImagesModel(productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d', url: EImages.productImage63, position: 04),
      ];

      for (var image in images) {
        final inserted =
            await supabase
                .from('product_images')
                .insert({
                  'product_id': image.productId,
                  'url': null,
                  'position': image.position,
                })
                .select()
                .single();

        final id = inserted['id'] as String;
        final byteData = await rootBundle.load(image.url);
        final fileBytes = byteData.buffer.asUint8List();

        // Extract filename from asset path (e.g. "icons8-bowling-64.png")
        final fileName = image.url.split('/').last;

        // Step 3: Upload to bucket under that category's folder
        final path = 'product_images/$id/$fileName';
        await supabase.storage
            .from('product_images')
            .uploadBinary(
              path,
              fileBytes,
              fileOptions: const FileOptions(contentType: 'image/png'),
            );

        final imageUrl = supabase.storage
            .from('product_images')
            .getPublicUrl(path);

        // Step 5: Update DB row with image URL
        await supabase
            .from('product_images')
            .update({'url': imageUrl})
            .eq('id', id);
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
