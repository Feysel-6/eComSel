import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/icons/e_circular_icon.dart';
import 'package:ecom_sel/features/shop/controllers/product/favourite_controller.dart';
import 'package:ecom_sel/features/shop/screens/home/home.dart';
import 'package:ecom_sel/navigation_menu.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:ecom_sel/utlis/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/helpers/cloud_helper_functions.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: EAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          ECircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              Obx(()
                => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, asyncSnapshot) {
                    final emptyWidget = EAnimationLoaderWidget(
                      text: 'Whoopee! Wishlist is Empty...',
                      animation: EImages.processInfo,
                      showAction: true,
                      actionText: 'Let\'s add some',
                      onActionPressed:
                          () => Get.off(() => const NavigationMenu()),
                    );
                    const loader = EVerticalProductShimmer(itemCount: 6,);
                    final widget = ECloudHelperFunctions.checkMultipleRecordState(
                      asyncSnapshot: asyncSnapshot,
                      loader: loader,
                      nothingFound: emptyWidget,
                    );
                    if (widget != null) return widget;
                
                    final products = asyncSnapshot.data!;
                    return EGridLayout(
                      itemCount: 6,
                      itemBuilder:
                          (_, index) => EProductCard(product: products[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
