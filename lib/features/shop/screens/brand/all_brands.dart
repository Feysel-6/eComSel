import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/brand/brand_card.dart';
import 'package:ecom_sel/common/widgets/layout/grid_layout.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/features/shop/screens/brand/brand_products.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/shimmers/brand_shimmer.dart';
import '../../controllers/brand_controller.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return Scaffold(
      appBar: EAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              ESectionHeading(title: 'Brands', showActionButton: false),
              SizedBox(height: ESizes.spaceBtwItems),

              Obx(() {
                if (controller.isLoading.value) return EBrandShimmer();
                if (controller.allBrands.isEmpty) {
                  return Center(child: Text('No Data Found!'));
                }
                return EGridLayout(
                  itemCount: controller.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final brand = controller.allBrands[index];
                    return EBrandCard(showBorder: true, brand: brand, onTap: () => Get.to(() => BrandProducts(brand: brand,)));
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
