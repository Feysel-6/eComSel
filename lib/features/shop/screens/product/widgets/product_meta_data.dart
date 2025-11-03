import 'package:ecom_sel/common/widgets/images/e_circular_image.dart';
import 'package:ecom_sel/common/widgets/texts/e_brand_title_text_with_verified_icon.dart';
import 'package:ecom_sel/common/widgets/texts/product_price_text.dart';
import 'package:ecom_sel/common/widgets/texts/product_title_text.dart';
import 'package:ecom_sel/features/shop/models/product_variation_model.dart';
import 'package:ecom_sel/utlis/constants/enums.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/product_model.dart';

class EProductMetaData extends StatelessWidget {
  const EProductMetaData({super.key, required this.product, required this.variations});

  final ProductModel product;
  final List<ProductVariationModel> variations;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ERoundedContainer(
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
            const SizedBox(width: ESizes.spaceBtwItems,),
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
            if (product.productType ==
                ProductType.single.toString() &&
                product.salePrice! < product.price)
              const SizedBox(width: ESizes.spaceBtwItems,),
            Padding(
              padding: const EdgeInsets.only(left: ESizes.sm),
              child: EProductPriceText(
                price: controller.getProductPrice(
                  product,
                  variations,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 1.5,),

        EProductTitleText(title: product.title),
        const SizedBox(height: ESizes.spaceBtwItems / 1.5,),

        Row(
          children: [
            EProductTitleText(title: 'Status'),
            const SizedBox(width: ESizes.spaceBtwItems,),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 1.5,),

        Row(
          children: [
            ECircularImage(image: product.brand?['image'], isNetworkImage: true, width: 32, height: 32, overlayColor: dark ? EColors.white : EColors.black),
            EBrandTitleWithVerifiedIcon(title: product.brand?['name'], brandTextSize: TextSizes.medium,),
          ],
        ),

      ],
    );
  }
}
