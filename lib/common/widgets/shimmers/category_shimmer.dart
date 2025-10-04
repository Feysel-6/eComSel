import 'package:ecom_sel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../../../utlis/constants/sizes.dart';

class ECategoryShimmer extends StatelessWidget {
  const ECategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: ESizes.spaceBtwItems / 2),
            ],
          );
        },
        separatorBuilder:
            (_, __) => const SizedBox(width: ESizes.spaceBtwItems),
        itemCount: itemCount,
      ),
    );
  }
}
