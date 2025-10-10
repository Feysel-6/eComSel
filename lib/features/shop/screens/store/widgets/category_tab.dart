import 'package:ecom_sel/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/features/shop/models/category_model.dart';
import 'package:ecom_sel/features/shop/screens/all_products/all_products.dart';
import 'package:ecom_sel/features/shop/screens/store/widgets/category_brands.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/brand/brand_showcase.dart';
import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card.dart';
import '../../../../../utlis/constants/image_strings.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/helpers/cloud_helper_functions.dart';
import '../../../controllers/category_controller.dart';
import '../../../controllers/product/product_controller.dart';

class ECategoryTab extends StatelessWidget {
  const ECategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final productController = ProductController.instance;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(category: category),
              const SizedBox(height: ESizes.spaceBtwItems),

              FutureBuilder(
                future: productController.getCategoryProducts(
                  categoryId: category.id!,
                ),
                builder: (context, asyncSnapshot) {
                  final widget = ECloudHelperFunctions.checkMultipleRecordState(
                    asyncSnapshot: asyncSnapshot,
                    loader: const EVerticalProductShimmer(),
                  );
                  if (widget != null) return widget;

                  final products = asyncSnapshot.data!;

                  return Column(
                    children: [
                      ESectionHeading(
                        title: 'You might like',
                        showActionButton: true,
                        onPressed:
                            () => Get.to(
                              () => AllProducts(
                                title: category.name,
                                futureMethod: productController
                                    .getCategoryProducts(
                                      categoryId: category.id!,
                                      limit: -1,
                                    ),
                              ),
                            ),
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems),

                      EGridLayout(
                        itemCount: products.length,
                        itemBuilder:
                            (_, index) =>
                                EProductCard(product: products[index]),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
