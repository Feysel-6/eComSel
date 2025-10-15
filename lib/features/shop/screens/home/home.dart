import 'package:ecom_sel/features/shop/screens/all_products/all_products.dart';
import 'package:ecom_sel/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecom_sel/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecom_sel/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            EPrimaryHeaderContainer(
              child: Column(
                children: [
                  EHomeAppBar(),
                  SizedBox(height: ESizes.spaceBtwHeader),

                  ESearchContainer(text: "Search in Store"),
                  SizedBox(height: ESizes.spaceBtwHeader),

                  Padding(
                    padding: EdgeInsets.only(left: ESizes.defaultSpace),
                    child: Column(
                      children: [
                        ESectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: EColors.white,
                        ),
                        const SizedBox(height: ESizes.spaceBtwItems),

                        EHomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  EPromoSlider(),
                  SizedBox(height: ESizes.spaceBtwSections),
                  ESectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => AllProducts(title: 'Popular Products', futureMethod: controller.getAllFeaturedProducts(),)),
                  ),
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return const EVerticalProductShimmer();
                      }
                      if (controller.featuredProducts.isEmpty) {
                        return Center(child: Text('No products found!', style: Theme.of(context).textTheme.titleMedium,),);
                      } else {
                        return EGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => EProductCard(product: controller.featuredProducts[index]),
                        );
                      }
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
