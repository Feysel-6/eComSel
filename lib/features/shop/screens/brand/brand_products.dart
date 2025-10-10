import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/brand/brand_card.dart';
import 'package:ecom_sel/common/widgets/products/sortable/sortable_products.dart';
import 'package:ecom_sel/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecom_sel/features/shop/controllers/brand_controller.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../utlis/helpers/cloud_helper_functions.dart';
import '../../models/brand_model.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: EAppBar(title: Text(brand.name), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          children: [
            EBrandCard(showBorder: true, brand: brand,),
            SizedBox(height: ESizes.spaceBtwSections,),

            FutureBuilder(
              future: controller.getBrandProducts(brand.id!),
              builder: (context, asyncSnapshot) {
                const loader = EVerticalProductShimmer();
                final widget = ECloudHelperFunctions.checkMultipleRecordState(asyncSnapshot: asyncSnapshot, loader: loader);
                if (widget != null) return widget;
                final brandProducts = asyncSnapshot.data;
                return ESortableProducts(products: brandProducts!,);
              }
            ),
          ],
        ),),
      ),
    );
  }
}
