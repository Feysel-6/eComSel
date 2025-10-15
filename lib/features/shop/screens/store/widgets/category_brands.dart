import 'package:ecom_sel/common/widgets/brand/brand_showcase.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/helpers/cloud_helper_functions.dart';
import '../../../controllers/brand_controller.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../models/category_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    final productController = ProductController.instance;
    return FutureBuilder(
      future: controller.getBrandCategory(category.id!),
      builder: (context, asyncSnapshot) {
        const loader = Column(
          children: [
            EListTileShimmer(),
            SizedBox(height: ESizes.spaceBtwItems),
            EBoxesShimmer(),
            SizedBox(height: ESizes.spaceBtwItems),
          ],
        );

        final widget = ECloudHelperFunctions.checkMultipleRecordState(
          asyncSnapshot: asyncSnapshot,
          loader: loader,
        );
        if (widget != null) return widget;

        final brands = asyncSnapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: productController.getBrandProducts(brandId:brand.id!, limit: 2),
              builder: (context, asyncSnapshot) {
                final widget = ECloudHelperFunctions.checkMultipleRecordState(
                  asyncSnapshot: asyncSnapshot,
                  loader: loader,
                );
                if (widget != null) return widget;

                final products = asyncSnapshot.data;
                final productImages = products
                    ?.map((e) => e.thumbnail)
                    .where((thumbnail) => thumbnail != null && thumbnail.isNotEmpty)
                    .cast<String>()
                    .toList();
                return EBrandShowcase(
                  brand: brand,
                  images: productImages!,
                  networkImage: true,
                );
              });
          },
        );
      },
    );
  }
}
