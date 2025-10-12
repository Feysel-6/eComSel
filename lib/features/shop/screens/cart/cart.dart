import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecom_sel/features/shop/screens/checkout/checkout.dart';
import 'package:ecom_sel/navigation_menu.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: EAppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Obx(() {
        final emptyWidget = EAnimationLoaderWidget(
          text: 'Whoos! Cart is EMPTY.',
          animation: EImages.processInfo,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(ESizes.defaultSpace),
                child: ECartItems(),
              ),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty ?
       const SizedBox()
      :Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: Obx(() => Text('Checkout \$${controller.totalCartPrice.value}')),
        ),
      ),
    );
  }
}
