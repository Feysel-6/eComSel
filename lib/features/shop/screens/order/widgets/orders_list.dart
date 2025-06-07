import 'package:ecom_sel/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../utlis/helpers/helper_functions.dart';

class EOrderListItems extends StatelessWidget {
  const EOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_,__) => const SizedBox(height: ESizes.spaceBtwItems,),
      itemBuilder: (_, index) => ERoundedContainer(
        showBorder: true,
        padding: EdgeInsets.all(ESizes.md),
        backgroundColor: dark ? EColors.dark : EColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(HugeIcons.strokeRoundedPackageProcess),
                SizedBox(width: ESizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: EColors.primary,
                          fontWeightDelta: 1,
                        ),
                      ),
                      Text(
                        '07 Nov 2024',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: (){}, icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: ESizes.iconSm,))
              ],
            ),
            SizedBox(height: ESizes.spaceBtwItems,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(HugeIcons.strokeRoundedShippingLoading),
                      SizedBox(width: ESizes.spaceBtwItems / 2),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: Theme.of(context).textTheme.labelMedium),
                            Text(
                              '[#484h8]',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(HugeIcons.strokeRoundedCalendar01),
                      SizedBox(width: ESizes.spaceBtwItems / 2),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Shipping Date',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(
                              '08 Feb 2024',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
