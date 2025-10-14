import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

import '../../../controllers/product/cart_controller.dart';

class EBillingAmountSection extends StatelessWidget {
  const EBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${subTotal.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text(EPricingCalculator.calculateShippingCost(subTotal, 'US'), style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text(EPricingCalculator.calculateTax(subTotal, 'US'), style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium,),
            Text(EPricingCalculator.calculateTotalPrice(subTotal, 'US').toStringAsFixed(2), style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2,),
      ],
    );
  }
}
