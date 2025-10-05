import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/shop/models/banner_model.dart';
import '../../../main.dart';
import '../../../routes/routes.dart';
import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/loaders/loaders.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db.from('banners').select().eq('active', 'true');
      final list =
          (snapshot as List)
              .map((e) => BannerModel.fromMap(e as Map<String, dynamic>))
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
      final List<BannerModel> banners = [
        BannerModel(
          imageUrl: EImages.banner1,
          targetScreen: ERoutes.order,
          active: false,
        ),
        BannerModel(
          imageUrl: EImages.banner2,
          targetScreen: ERoutes.cartScreen,
          active: true,
        ),
        BannerModel(
          imageUrl: EImages.banner3,
          targetScreen: ERoutes.favouritesScreen,
          active: true,
        ),
        BannerModel(
          imageUrl: EImages.banner4,
          targetScreen: ERoutes.search,
          active: true,
        ),
        BannerModel(
          imageUrl: EImages.banner5,
          targetScreen: ERoutes.settings,
          active: true,
        ),
        BannerModel(
          imageUrl: EImages.banner6,
          targetScreen: ERoutes.userAddress,
          active: true,
        ),
        BannerModel(
          imageUrl: EImages.banner7,
          targetScreen: ERoutes.order,
          active: false,
        ),
        BannerModel(
          imageUrl: EImages.banner8,
          targetScreen: ERoutes.checkoutScreen,
          active: false,
        ),
      ];

      for (var banner in banners) {
        // Step 1: Insert row (image = null initially)
        final inserted =
            await supabase
                .from('banners')
                .insert({
                  'image': banner.imageUrl,
                  'active': banner.active,
                  'target_screen': banner.targetScreen,
                })
                .select()
                .single();

        final id = inserted['id'] as String;

        // Step 2: Load image from assets
        final byteData = await rootBundle.load(banner.imageUrl);
        final fileBytes = byteData.buffer.asUint8List();

        // Extract filename from asset path (e.g. "icons8-bowling-64.png")
        final fileName = banner.imageUrl.split('/').last;

        // Step 3: Upload to bucket under that category's folder
        final path = 'banners/$id/$fileName';
        await supabase.storage
            .from('banners')
            .uploadBinary(
              path,
              fileBytes,
              fileOptions: const FileOptions(contentType: 'image/png'),
            );

        // Step 4: Get public URL
        final imageUrl = supabase.storage.from('banners').getPublicUrl(path);

        // Step 5: Update DB row with image URL
        await supabase
            .from('banners')
            .update({'image': imageUrl})
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
