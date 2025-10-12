import 'package:ecom_sel/features/shop/models/cart_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/helpers/helper_functions.dart';
import '../../images/e_rounded_image.dart';
import '../../texts/e_brand_title_text_with_verified_icon.dart';
import '../../texts/product_title_text.dart';

class ECartItem extends StatelessWidget {
  const ECartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        ERoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          padding: EdgeInsets.all(ESizes.sm),
          backgroundColor: dark ? EColors.darkerGrey : EColors.light,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),

        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EBrandTitleWithVerifiedIcon(title: cartItem.brandName! ?? ''),
              Flexible(
                child: EProductTitleText(title: cartItem.title, maxLines: 1),
              ),
              Text.rich(
                TextSpan(
                  children:
                      (cartItem.selectedVariation ?? {}).entries.map((e) {
                        return TextSpan(
                          children: [
                            TextSpan(
                              text: '${e.key}: ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: '${e.value}\n',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
