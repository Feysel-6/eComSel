import 'package:ecom_sel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/cupertino.dart';

import '../../../utlis/constants/sizes.dart';

class EListTileShimmer extends StatelessWidget {
  const EListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            EShimmerEffect(width: 50, height: 50, radius: 50,),
            SizedBox(width: ESizes.spaceBtwItems,),
            Column(
              children: [
                EShimmerEffect(width: 100, height: 15,),
                SizedBox(width: ESizes.spaceBtwItems / 2,),
                EShimmerEffect(width: 80, height: 15,),
              ],
            )
          ]
          ,
        )
      ]
      ,
    );
  }


}