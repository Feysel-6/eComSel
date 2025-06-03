import 'package:ecom_sel/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecom_sel/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecom_sel/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/products/product_card.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: ESizes.spaceBtwSections,)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  EPromoSlider(
                    banners: [
                      EImages.banner4,
                      EImages.banner2,
                      EImages.banner3,
                    ],
                  ),
                  SizedBox(height: ESizes.spaceBtwSections),
                  ESectionHeading(title: 'Popular Products', onPressed: (){},),
                  EGridLayout(itemCount: 2, itemBuilder: (_, index) => const EProductCard(),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


