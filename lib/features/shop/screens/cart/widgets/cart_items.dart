import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../controllers/cart_controller.dart';

class ECartItems extends StatelessWidget {
  const ECartItems({super.key, this.showAddRemoveButton = true});

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder:
            (_, index) => const SizedBox(height: ESizes.spaceBtwSections),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) { return Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              ECartItem(cartItem: item),
              if (showAddRemoveButton) SizedBox(height: ESizes.spaceBtwItems),

              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        EProductQuantity(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    EProductPriceText(
                      price: (item.price * item.quantity).toStringAsFixed(2),
                    ),
                  ],
                ),
            ],
          );
        }
        );
        },
      ),
    );
  }
}
