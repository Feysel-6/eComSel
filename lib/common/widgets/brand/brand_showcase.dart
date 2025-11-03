import 'package:ecom_sel/features/shop/screens/brand/brand_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utlis/constants/colors.dart';
import '../../../utlis/constants/sizes.dart';
import '../../../utlis/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card.dart';

class EBrandShowcase extends StatelessWidget {
  const EBrandShowcase({
    super.key,
    required this.images,
    required this.brand,
    this.networkImage = false,
  });

  final BrandModel brand;
  final List<String> images;
  final bool networkImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: ERoundedContainer(
        padding: const EdgeInsets.all(ESizes.md),
        showBorder: true,
        borderColor: EColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: ESizes.spaceBtwItems),
        child: Column(
          children: [
            EBrandCard(showBorder: false, brand: brand),
            Row(
              children:
                  images
                      .map(
                        (image) => brandTopProductImageWidget(image, context),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Expanded(
      child: ERoundedContainer(
        height: 100,
        backgroundColor: dark ? EColors.darkerGrey : EColors.light,
        margin: const EdgeInsets.only(right: ESizes.sm),
        padding: const EdgeInsets.all(ESizes.md),
        child: Image(
          fit: BoxFit.contain,
          image: networkImage ? NetworkImage(image) : AssetImage(image),
        ),
      ),
    );
  }
}
