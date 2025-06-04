import 'package:ecom_sel/common/widgets/icons/e_circular_icon.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class EBottomAddToCart extends StatelessWidget {
  const EBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ECircularIcon(
                icon: HugeIcons.strokeRoundedMinusSign,
                width: 40,
                height: 40,
                color: EColors.white,
                backgroundColor: EColors.darkerGrey,
              ),
              const SizedBox(width: ESizes.spaceBtwItems),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: ESizes.spaceBtwItems),
              ECircularIcon(
                icon: HugeIcons.strokeRoundedPlusSign,
                width: 40,
                height: 40,
                color: EColors.white,
                backgroundColor: EColors.black,
              ),
            ],
          ),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(ESizes.md),
              backgroundColor: EColors.black,
              side: BorderSide(color: EColors.black),
            ),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
