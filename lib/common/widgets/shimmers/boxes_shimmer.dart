import 'package:ecom_sel/common/widgets/layout/grid_layout.dart';
import 'package:ecom_sel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../../../utlis/constants/sizes.dart';

class EBoxesShimmer extends StatelessWidget {
  const EBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: EShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ESizes.spaceBtwItems),
            Expanded(child: EShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ESizes.spaceBtwItems),
            Expanded(child: EShimmerEffect(width: 150, height: 110)),
          ],
        ),
      ],
    );
  }
}
