import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/helpers/helper_functions.dart';
import '../../icons/e_circular_icon.dart';

class EProductQuantity extends StatelessWidget {
  const EProductQuantity({
    super.key, required this.quantity, this.add, this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ECircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ESizes.md,
          color: dark ? EColors.white : EColors.black,
          backgroundColor: dark ? EColors.darkerGrey : EColors.light,
          onPressed: remove ,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: ESizes.spaceBtwItems),
        ECircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ESizes.md,
          color: EColors.white,
          backgroundColor: EColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}