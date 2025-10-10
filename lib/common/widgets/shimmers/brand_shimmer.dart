import 'package:ecom_sel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../layout/grid_layout.dart';

class EBrandShimmer extends StatelessWidget {
  const EBrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return EGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const EShimmerEffect(width: 300, height: 80),
    );
  }
}
