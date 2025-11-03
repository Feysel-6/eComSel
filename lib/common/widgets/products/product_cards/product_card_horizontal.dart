import 'package:ecom_sel/common/widgets/images/e_rounded_image.dart';
import 'package:ecom_sel/common/widgets/texts/e_brand_title_text_with_verified_icon.dart';
import 'package:ecom_sel/common/widgets/texts/product_price_text.dart';
import 'package:ecom_sel/common/widgets/texts/product_title_text.dart';
import 'package:ecom_sel/features/shop/models/product_model.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/product_attribute_controller.dart';
import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/controllers/product/product_variation_controller.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/enums.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../favourite_icon/favourite_icon.dart';

class EProductCardHorizontal extends StatelessWidget {
  const EProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final attributeController = ProductAttributeController.instance;
    final variationController = ProductVariationController.instance;

    if(product.productType == ProductType.variable.toString() && product.id != null) {
      attributeController.fetchProductAttributes(product.id!);
      variationController.fetchProductVariations(product.id!);
    }
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final dark = EHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ESizes.productImageRadius),
        color: dark ? EColors.darkerGrey : EColors.softGrey,
      ),
      child: Row(
        children: [
          ERoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(ESizes.sm),
            backgroundColor: dark ? EColors.dark : EColors.light,
            child: Stack(
              children: [
                SizedBox(
                  height: 180,
                  width: 120,
                  child: ERoundedImage(
                    imageUrl: product.thumbnail!,
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),
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
                      salePercentage!,
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

          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: ESizes.sm, left: ESizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EProductTitleText(
                        title: product.title,
                        smallSize: true,
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems / 2),
                      EBrandTitleWithVerifiedIcon(title: product.brand?['name']),
                    ],
                  ),

                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: EProductPriceText(price: controller.getProductPrice(product, variationController.productVariations.toList()))),

                      Container(
                        decoration: const BoxDecoration(
                          color: EColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ESizes.cardRadiusMd),
                            bottomRight: Radius.circular(ESizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: ESizes.iconLg * 1.2,
                          height: ESizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: EColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
