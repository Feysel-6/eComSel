import 'package:ecom_sel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../features/shop/controllers/product/product_images_controller.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utlis/constants/sizes.dart';

class EProductDetailImageSliderShimmer extends StatelessWidget {
  const EProductDetailImageSliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        EShimmerEffect(height: 400, width: double.infinity),
        Positioned(
          right: 0,
          bottom: 30,
          left: ESizes.defaultSpace,
          child: SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              separatorBuilder:
                  (_, __) => const SizedBox(width: ESizes.spaceBtwItems),
              itemCount: 4,
              itemBuilder: (_, index) => EShimmerEffect(width: 70, height: 80),
            ),
          ),
        ),
      ],
    );
  }
}
