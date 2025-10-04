import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/appbar/tabbar.dart';
import 'package:ecom_sel/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecom_sel/common/widgets/layout/grid_layout.dart';
import 'package:ecom_sel/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/features/shop/screens/brand/all_brands.dart';
import 'package:ecom_sel/features/shop/screens/store/widgets/category_tab.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/brand/brand_card.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../controllers/category_controller.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: EAppBar(
          title: Text(
            'Store',
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
          ),
          actions: [ECartCounterIcon(onPressed: () {})],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? EColors.black : EColors.white,
                expandedHeight: 400,

                flexibleSpace: Padding(
                  padding: EdgeInsets.all(ESizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: ESizes.spaceBtwItems),
                      ESearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(height: ESizes.spaceBtwItems),

                      ESectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => AllBrandsScreen()) ,
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems / 1.5),
                      EGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return EBrandCard(showBorder: true);
                        },
                      ),
                    ],
                  ),
                ),

                bottom: ETabBar(
                  tabs: categories.map((category) => Tab(child: Text(category.name))).toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories.map((category) => ECategoryTab(category: category)).toList()
          ),
        ),
      ),
    );
  }
}


