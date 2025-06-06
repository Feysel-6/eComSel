import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/texts/product_price_text.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: EAppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder:
              (_, index) => const SizedBox(height: ESizes.spaceBtwSections),
          itemCount: 5,
          itemBuilder:
              (_, index) => Column(
                children: [
                  ECartItem(),
                  SizedBox(height: ESizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 70),
                          EProductQuantity(),
                        ],
                      ),
                      EProductPriceText(price: '256'),
                    ],
                  ),
                ],
              ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(onPressed: (){}, child: Text('Checkout \$256')),
    );
  }
}
