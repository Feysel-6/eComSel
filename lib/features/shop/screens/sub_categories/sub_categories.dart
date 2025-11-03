import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/images/e_rounded_image.dart';
import 'package:ecom_sel/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:ecom_sel/common/widgets/shimmers/horizontal_product_shimmer.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/features/shop/models/category_model.dart';
import 'package:ecom_sel/features/shop/screens/all_products/all_products.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utlis/helpers/cloud_helper_functions.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/product/product_controller.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final controller = CategoryController.instance;

    // Separate loaders for clarity
    final categoryLoader = EHorizontalProductShimmer();
    final productLoader = EHorizontalProductShimmer();

    return Scaffold(
      appBar: EAppBar(showBackArrow: true, title: Text(category.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ERoundedImage(
                imageUrl: EImages.banner4,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(height: ESizes.spaceBtwSections),

              // Fetch subcategories
              FutureBuilder<List<CategoryModel>>(
                future: controller.getSubCategories(category.id!),
                builder: (context, asyncSnapshot) {
                  final widget = ECloudHelperFunctions.checkMultipleRecordState(
                    asyncSnapshot: asyncSnapshot,
                    loader: categoryLoader,
                  );
                  if (widget != null) return widget;

                  final subCategories = asyncSnapshot.data!;

                  return ListView.builder(
                    itemCount: subCategories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];

                      // Fetch products for each subcategory
                      return FutureBuilder(
                        future: productController.getCategoryProducts(
                          categoryId: subCategory.id!,
                        ),
                        builder: (context, asyncSnapshot) {
                          final widget =
                          ECloudHelperFunctions.checkMultipleRecordState(
                            asyncSnapshot: asyncSnapshot,
                            loader: productLoader,
                          );
                          if (widget != null) return widget;

                          final products = asyncSnapshot.data!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ESectionHeading(
                                title: subCategory.name,
                                onPressed: () => Get.to(
                                      () => AllProducts(
                                    title: subCategory.name,
                                    futureMethod: productController
                                        .getCategoryProducts(
                                      categoryId: subCategory.id!,
                                      limit: -1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: ESizes.spaceBtwSections / 2,
                              ),
                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      EProductCardHorizontal(
                                          product: products[index]),
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(
                                      width: ESizes.spaceBtwItems),
                                ),
                              ),
                              const SizedBox(
                                height: ESizes.spaceBtwSections,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
