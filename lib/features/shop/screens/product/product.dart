import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/features/shop/controllers/product/product_variation_controller.dart';
import 'package:ecom_sel/features/shop/screens/product/widgets/bottom_add_to_cart_widget.dart';
import 'package:ecom_sel/features/shop/screens/product/widgets/product_attribute.dart';
import 'package:ecom_sel/features/shop/screens/product/widgets/product_detail_image_slider.dart';
import 'package:ecom_sel/features/shop/screens/product/widgets/product_meta_data.dart';
import 'package:ecom_sel/features/shop/screens/product/widgets/rating_share_widget.dart';
import 'package:ecom_sel/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecom_sel/utlis/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../utlis/constants/sizes.dart';
import '../../controllers/product/product_attribute_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../../models/product_model.dart';

class ProductDetainScreen extends StatelessWidget {
  const ProductDetainScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final attributeController = Get.put(ProductAttributeController());
    final variationController = Get.put(ProductVariationController(), permanent: true);

    if(product.productType == ProductType.variable.toString() && product.id != null) {
      attributeController.fetchProductAttributes(product.id!);
      variationController.fetchProductVariations(product.id!);
    }
    return Scaffold(
      bottomNavigationBar: EBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EProductImageSlider(product: product),

            Padding(
              padding: EdgeInsets.only(
                right: ESizes.defaultSpace,
                left: ESizes.defaultSpace,
                bottom: ESizes.defaultSpace,
              ),
              child: Column(
                children: [
                  ERatingAndShare(),

                  Obx(() => EProductMetaData(
                    product: product,
                    variations: variationController.productVariations.toList(), // <--- FIXED
                  )),

                  if(product.productType == ProductType.variable.toString())
                    Obx(() => EProductAttribute(
                      product: product,
                      variations: variationController.productVariations.toList(), // <--- FIXED
                    )),
                  if(product.productType == ProductType.variable.toString()) const SizedBox(height: ESizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Checkout"),
                    ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections),

                  ESectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: ESizes.spaceBtwItems),

                  ReadMoreText(
                    product.description ?? 'No description is available for this product',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more ',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const Divider(),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ESectionHeading(
                        title: 'Reviews(199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed:
                            () => Get.to(() => const ProductReviewsScreen()),
                        icon: Icon(Iconsax.arrow_right_3, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
