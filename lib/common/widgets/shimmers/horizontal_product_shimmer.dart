import 'package:ecom_sel/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_sel/features/shop/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import '../../../features/shop/controllers/brand_controller.dart';
import '../../../utlis/constants/sizes.dart';

class EHorizontalProductShimmer extends StatelessWidget {
  const EHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ESizes.spaceBtwSections),
      height: 120, // 👈 gives bounded height
      child: ListView.separated(
        scrollDirection: Axis.horizontal, // 👈 important for horizontal shimmer
        separatorBuilder: (context, index) =>
        const SizedBox(width: ESizes.spaceBtwItems),
        itemCount: itemCount,
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // product image shimmer
            EShimmerEffect(width: 120, height: 120),
            SizedBox(width: ESizes.spaceBtwItems),

            // text lines shimmer
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // 👈 prevents infinite height
              children: [
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 160, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 110, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 80, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
