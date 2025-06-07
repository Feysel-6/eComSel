import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/images/e_rounded_image.dart';
import 'package:ecom_sel/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EAppBar(showBackArrow: true, title: Text('Sports shirts')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              const ERoundedImage(
                imageUrl: EImages.banner4,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(height: ESizes.spaceBtwSections),

              Column(
                children: [
                  ESectionHeading(title: 'Sports shirts', onPressed: () {}),
                  const SizedBox(height: ESizes.spaceBtwSections / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder:
                          (context, index) => const EProductCardHorizontal(),
                      separatorBuilder: (context, index) => const SizedBox(width: ESizes.spaceBtwItems,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
