import 'package:ecom_sel/features/shop/screens/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/enums.dart';
import '../../../../utlis/constants/sizes.dart';

class EProductCartAddToCartButton extends StatelessWidget {
  const EProductCartAddToCartButton({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: (){
        if(product.productType == ProductType.single.toString()){
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetainScreen(product: product));
        }
      },
      child: Obx(
        () {
          final productQuantityInCart = cartController.getProductQuantityInCart(product.id!);
          return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? EColors.primary : EColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ESizes.cardRadiusMd),
                bottomRight: Radius.circular(ESizes.productImageRadius),
              ),
            ),
            child: SizedBox(
              height: ESizes.iconLg * 1.2,
              width: ESizes.iconLg * 1.2,
              child: Center(
                child: productQuantityInCart > 0 ? Text(productQuantityInCart.toString(), style: Theme.of(context).textTheme.bodyLarge!.apply(color: EColors.white),)
                    : const Icon(Iconsax.add, color: EColors.white,),
              ),
            ),
          );
        }
      ),
    );
  }
}