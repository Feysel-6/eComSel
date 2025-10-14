import 'package:ecom_sel/common/widgets/icons/e_circular_icon.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/product/cart_controller.dart';
import '../../../models/product_model.dart';

class EBottomAddToCart extends StatelessWidget {
  const EBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateExistingProductCount(product);
    final dark = EHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ESizes.defaultSpace,
        vertical: ESizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? EColors.darkerGrey : EColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(ESizes.cardRadiusLg),
          topRight: Radius.circular(ESizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ECircularIcon(
                  icon: Iconsax.minus,
                  width: 40,
                  height: 40,
                  color: EColors.white,
                  backgroundColor: EColors.darkerGrey,
                  onPressed:
                      () =>
                          controller.productQuantityInCart < 1
                              ? null
                              : controller.productQuantityInCart -= 1,
                ),
                const SizedBox(width: ESizes.spaceBtwItems),
                Text(
                  controller.productQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: ESizes.spaceBtwItems),
                ECircularIcon(
                  icon: Iconsax.add,
                  width: 40,
                  height: 40,
                  color: EColors.white,
                  backgroundColor: EColors.black,
                  onPressed: () => controller.productQuantityInCart += 1,
                ),
              ],
            ),

            ElevatedButton(
              onPressed:
                  () =>
                      controller.productQuantityInCart < 1
                          ? null
                          : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(ESizes.md),
                backgroundColor: EColors.black,
                side: BorderSide(color: EColors.black),
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
