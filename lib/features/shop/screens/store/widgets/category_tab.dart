import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/brand/brand_showcase.dart';
import '../../../../../utlis/constants/image_strings.dart';
import '../../../../../utlis/constants/sizes.dart';

class ECategoryTab extends StatelessWidget {
  const ECategoryTab({super.key, required CategoryModel category});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              EBrandShowcase(
                images: [
                  EImages.productImage3,
                  EImages.productImage2,
                  EImages.productImage1,
                ],
              ),
              const SizedBox(height: ESizes.spaceBtwItems),

              ESectionHeading(
                title: 'You might like',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: ESizes.spaceBtwItems),

              // EGridLayout(
              //   itemCount: 4,
              //   itemBuilder: (_, index) => EProductCard(),
              // ),
              SizedBox(height: ESizes.spaceBtwSections,)
            ],
          ),
        ),
      ],
    );
  }
}
