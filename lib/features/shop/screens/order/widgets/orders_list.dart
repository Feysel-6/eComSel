import 'package:ecom_sel/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecom_sel/navigation_menu.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utlis/helpers/helper_functions.dart';
import '../../../../../utlis/loaders/animation_loader.dart';
import '../../../controllers/product/order_controller.dart';

class EOrderListItems extends StatelessWidget {
  const EOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = EHelperFunctions.isDarkMode(context);
    return FutureBuilder(
      future: controller.getUserOrders(),
      builder: (context, asyncSnapshot) {
        final emptyWidget = EAnimationLoaderWidget(
          text: 'Whoopee! No Order Yet!',
          animation: EImages.processInfo,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        final response = ECloudHelperFunctions.checkMultipleRecordState(
          asyncSnapshot: asyncSnapshot,
          nothingFound: emptyWidget,
        );
        if (response != null) return response;

        final orders = asyncSnapshot.data;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders!.length,
          separatorBuilder:
              (_, __) => const SizedBox(height: ESizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders![index];
            return ERoundedContainer(
              showBorder: true,
              padding: EdgeInsets.all(ESizes.md),
              backgroundColor: dark ? EColors.dark : EColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.ship),
                      SizedBox(width: ESizes.spaceBtwItems / 2),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.apply(
                                color: EColors.primary,
                                fontWeightDelta: 1,
                              ),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.arrow_right_34,
                          size: ESizes.iconSm,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ESizes.spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Iconsax.tag),
                            SizedBox(width: ESizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.id!,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                            Icon(Iconsax.calendar),
                            SizedBox(width: ESizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Date',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.formattedDeliveryDate,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
            );
          },
        );
      },
    );
  }
}
