import 'package:ecom_sel/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecom_sel/common/widgets/texts/product_price_text.dart';
import 'package:ecom_sel/common/widgets/texts/product_title_text.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/features/shop/controllers/product/product_variation_controller.dart';
import 'package:ecom_sel/features/shop/models/product_variation_model.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chip/choice_chip.dart';
import '../../../controllers/product/product_attribute_controller.dart';
import '../../../models/product_model.dart';

class EProductAttribute extends StatelessWidget {
  const EProductAttribute({
    super.key,
    required this.product,
    required this.variations,
  });

  final ProductModel product;
  final List<ProductVariationModel> variations;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final attributeController = Get.put(ProductAttributeController());
    attributeController.fetchProductAttributes(product.id!);
    final variationController = ProductVariationController.instance;


    return Obx(
      () {
          final selectedVariation = variationController.selectedVariation.value;
          return Column(

            children: [

              if ((selectedVariation.id ?? '').isNotEmpty)
                if (variationController.selectedVariation.value.id
                    ?.isNotEmpty == true)
                  ERoundedContainer(
                    padding: EdgeInsets.all(ESizes.md),
                    backgroundColor: dark ? EColors.darkerGrey : EColors.grey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const ESectionHeading(
                              title: 'Variation',
                              showActionButton: false,
                            ),
                            SizedBox(width: ESizes.spaceBtwItems),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const EProductTitleText(
                                      title: 'Price : ',
                                      smallSize: true,
                                    ),
                                    SizedBox(width: ESizes.spaceBtwItems),

                                    if ((variationController.selectedVariation
                                        .value.salePrice ?? 0) > 0)

                                      Text(
                                        variationController.getVariationPrice(),
                                        style: Theme
                                            .of(
                                          context,
                                        )
                                            .textTheme
                                            .labelMedium!
                                            .apply(
                                          decoration: TextDecoration
                                              .lineThrough,
                                        ),
                                      ),
                                    const SizedBox(width: ESizes.spaceBtwItems),
                                    EProductPriceText(
                                      price: variationController
                                          .getVariationPrice(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const EProductTitleText(
                                      title: 'Stock : ',
                                      smallSize: true,
                                    ),
                                    SizedBox(width: ESizes.spaceBtwItems),
                                    Text(
                                      variationController.variationStockStatus
                                          .value,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        EProductTitleText(
                          title:
                          variationController
                              .selectedVariation
                              .value
                              .description ??
                              '',
                          smallSize: true,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
              const SizedBox(height: ESizes.spaceBtwItems),

              Obx(() {
                final attributes = attributeController.attributes;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  attributes.map((attr) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ESectionHeading(
                          title: attr.name ?? '',
                          showActionButton: false,
                        ),
                        const SizedBox(height: ESizes.spaceBtwItems / 2),
                        Obx(
                              () =>
                              Wrap(
                                spacing: 8,
                                children:
                                attr.values?.map((value) {
                                  final isSelected =
                                      variationController
                                          .selectedAttributes[attr.name] ==
                                          value;
                                  final available = variationController
                                      .getAttributesAvailabilityInVariation(
                                    variations,
                                    attr.name!,
                                  )
                                      .contains(value);

                                  return EChoiceChip(
                                    text: value,
                                    selected: isSelected,
                                    // You can make this dynamic later
                                    onSelected:
                                    available
                                        ? (selected) {
                                      if (selected && available) {
                                        variationController
                                            .onAttributeSelected(
                                          product,
                                          attr.name ?? '',
                                          value,
                                          variations,
                                        );
                                      }
                                    }
                                        : null,
                                  );
                                }).toList() ??
                                    [],
                              ),
                        ),
                        const SizedBox(height: ESizes.spaceBtwItems),
                      ],
                    );
                  }).toList(),
                );
              }),


            ],
          );
      },
    );
  }
}
