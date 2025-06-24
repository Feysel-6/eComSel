import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/brand/brand_card.dart';
import 'package:ecom_sel/common/widgets/products/sortable/sortable_products.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(title: Text('Nike'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          children: [
            EBrandCard(showBorder: true),
            SizedBox(height: ESizes.spaceBtwSections,),

            ESortableProducts(),
          ],
        ),),
      ),
    );
  }
}
