import 'package:ecom_sel/features/shop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../utlis/constants/colors.dart';

class ECartCounterIcon extends StatelessWidget {
  const ECartCounterIcon({
    super.key, this.iconColor, this.counterByColor, this.counterTextColor
  });

  final Color? iconColor, counterByColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(
            Icons.shopping_bag,
            color: iconColor,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                color: EColors.black,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: Obx(() => Text(controller.noOfCartItems.value.toString(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge!.apply(color: EColors.white, fontSizeFactor: 0.8),)),
            ),
          ),
        )
      ],
    );
  }
}
