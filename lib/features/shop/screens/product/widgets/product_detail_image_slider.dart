import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_sel/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/e_circular_icon.dart';
import '../../../../../common/widgets/images/e_rounded_image.dart';
import '../../../../../common/widgets/shimmers/product_detail_image_slider_shimmer.dart';
import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/helpers/helper_functions.dart';
import '../../../controllers/product/product_images_controller.dart';
import '../../../models/product_model.dart';

class EProductImageSlider extends StatelessWidget {
  const EProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductImagesController(product: product));

    return Obx(() {
      if (controller.productImages.isEmpty) {
        return EProductDetailImageSliderShimmer();
      }

      return ECurvedEdgeWidget(
        child: Container(
          color: dark ? EColors.darkerGrey : EColors.light,
          child: Stack(
            children: [
              SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(ESizes.productImageRadius * 2),
                  child: Center(
                    child: Obx(() {
                      final image = controller.selectedImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImages(image),
                        child: CachedNetworkImage(imageUrl: image,
                          progressIndicatorBuilder: (_, __,
                              ___) => const CircularProgressIndicator(),
                        ),
                      );
                    })),
              ),
              ),

              Positioned(
                right: 0,
                bottom: 30,
                left: ESizes.defaultSpace,
                child: SizedBox(
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
                          separatorBuilder:
                              (_, __) =>
                          const SizedBox(width: ESizes.spaceBtwItems),
                          itemCount: controller.productImages.length,
                          itemBuilder:
                              (_, index) => Obx(
                                    () {
                                      final selectedImage = controller.selectedImage.value == controller.productImages[index];
                                    return  ERoundedImage(
                                        width: 80,
                                        imageUrl: controller
                                            .productImages[index],
                                        backgroundColor: dark
                                            ? EColors.dark
                                            : EColors
                                            .white,
                                        border: Border.all(color: selectedImage ? EColors.primary : Colors.transparent, width: 2),
                                        padding: const EdgeInsets.all(ESizes
                                            .sm),
                                      );

                                    }
                        ),
                      ),
                ),
              ),

              EAppBar(
                showBackArrow: true,
                actions: [
                  EFavouriteIcon(productId: product.id!,),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

