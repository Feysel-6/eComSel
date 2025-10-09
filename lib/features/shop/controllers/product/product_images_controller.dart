import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_sel/data/repositories/product/product_images_repository.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utlis/loaders/loaders.dart';
import '../../models/product_model.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();
  ProductImagesController({required this.product});
  final ProductModel product;
  final RxList<String> productImages = <String>[].obs;
  RxString selectedImage = ''.obs;

  @override
  void onInit() {
    fetchProductImages();
    super.onInit();
  }

  Future<void> fetchProductImages() async {
    try {
      selectedImage.value = product.thumbnail!;
      final repo = Get.put(ProductImagesRepository());
      final images = await repo.getProductImages(product.id!);

      productImages.assignAll(images);

    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void showEnlargedImages (String image) {
    Get.to(
      fullscreenDialog: true,
        () => Dialog.fullscreen(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: ESizes.defaultSpace * 2, horizontal: ESizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image),),
              const SizedBox(height: ESizes.spaceBtwSections,),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
                ),
              )
            ],
          ),
        )
    );
  }
}
