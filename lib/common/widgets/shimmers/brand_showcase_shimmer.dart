import 'package:ecom_sel/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:ecom_sel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../utlis/constants/colors.dart';
import '../../../utlis/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';

class EBrandShowcaseShimmer extends StatelessWidget {
  const EBrandShowcaseShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return ERoundedContainer(
      padding: const EdgeInsets.all(ESizes.lg),
      showBorder: true,
      borderColor: EColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: ESizes.spaceBtwItems),
      child: Column(
        children: [
          EListTileShimmer(),
          const SizedBox(height: ESizes.sm),
          Row(
            children: List.generate(
              2,
              (index) => Expanded(
                child: ERoundedContainer(
                  height: 100,
                  padding: const EdgeInsets.all(ESizes.md),
                  margin: const EdgeInsets.only(right: ESizes.sm),
                  backgroundColor: dark ? Colors.grey[800]! : Colors.grey[300]!,
                  child: const EShimmerEffect(width: 100, height: 100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
