import 'package:ecom_sel/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecom_sel/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:ecom_sel/common/widgets/texts/product_title_text.dart';
import 'package:ecom_sel/features/shop/screens/product/product.dart';
import 'package:ecom_sel/utlis/constants/enums.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/product_attribute_controller.dart';
import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/controllers/product/product_variation_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../styles/shadows.dart';
import '../../icons/e_circular_icon.dart';
import '../../images/e_rounded_image.dart';
import '../../texts/e_brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';

class EProductCard extends StatelessWidget {
  const EProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;



  @override
  Widget build(BuildContext context) {
    final attributeController = Get.put(ProductAttributeController());
    final variationController = Get.put(ProductVariationController());

    if(product.productType == ProductType.variable.toString() && product.id != null) {
      attributeController.fetchProductAttributes(product.id!);
      variationController.fetchProductVariations(product.id!);
    }
    final controller = Get.put(ProductController());
    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final dark = EHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetainScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [EShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(ESizes.productImageRadius),
          color: dark ? EColors.darkerGrey : EColors.white,
        ),
        child: Column(
          children: [
            ERoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(ESizes.sm),
              backgroundColor: dark ? EColors.dark : EColors.light,
              child: Stack(
                children: [
                  ERoundedImage(
                    imageUrl: product.thumbnail!,
                    applyImageRadius: true,
                  ),
                  Positioned(
                    top: 12,
                    child: ERoundedContainer(
                      radius: ESizes.sm,
                      backgroundColor: EColors.secondary.withValues(alpha: 0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: ESizes.sm,
                        vertical: ESizes.xs,
                      ),
                      child: Text(
                        '$salePercentage',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: EColors.black),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: EFavouriteIcon(productId: product.id!,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwItems / 2),
            Padding(
              padding: EdgeInsets.only(left: ESizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EProductTitleText(title: product.title, textAlign: TextAlign.start,),
                  SizedBox(height: ESizes.spaceBtwItems / 2),
                  EBrandTitleWithVerifiedIcon(
                    title: product.brand?['name'] ?? 'Unknown brand',
                  ),
                ],
              ),
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      if (product.productType ==
                              ProductType.single.toString() &&
                          product.salePrice! < product.price)
                        Padding(
                          padding: EdgeInsets.only(left: ESizes.sm),
                          child: Text(
                            product.price.toString(),
                            style: Theme.of(context).textTheme.labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.only(left: ESizes.sm),
                        child: Obx(() {
                          final variations = variationController.productVariations;
                          return EProductPriceText(
                            price: controller.getProductPrice(product, variations.toList()),
                          );
                        })
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: EColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ESizes.cardRadiusMd),
                      bottomRight: Radius.circular(ESizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    height: ESizes.iconLg * 1.2,
                    width: ESizes.iconLg * 1.2,
                    child: Center(
                      child: const Icon(Iconsax.add, color: EColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
