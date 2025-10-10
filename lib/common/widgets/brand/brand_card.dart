import 'package:flutter/material.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utlis/constants/colors.dart';
import '../../../utlis/constants/enums.dart';
import '../../../utlis/constants/sizes.dart';
import '../../../utlis/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/e_circular_image.dart';
import '../texts/e_brand_title_text_with_verified_icon.dart';

class EBrandCard extends StatelessWidget {
  const EBrandCard({
    super.key, required this.showBorder, this.onTap, required this.brand,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);


    return GestureDetector(
      onTap: onTap,
      child: ERoundedContainer(
        padding: const EdgeInsets.all(ESizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: ECircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor:
                dark ? EColors.white : EColors.black,
              ),
            ),
            const SizedBox(
              width: ESizes.spaceBtwItems / 2,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  EBrandTitleWithVerifiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 products',
                    overflow: TextOverflow.ellipsis,
                    style:
                    Theme.of(
                      context,
                    ).textTheme.labelMedium,
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