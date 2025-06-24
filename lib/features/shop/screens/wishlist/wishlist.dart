import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/icons/e_circular_icon.dart';
import 'package:ecom_sel/common/widgets/layout/grid_layout.dart';
import 'package:ecom_sel/common/widgets/products/product_cards/product_card.dart';
import 'package:ecom_sel/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utlis/constants/sizes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          ECircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              EGridLayout(
                itemCount: 6,
                itemBuilder: (_, index) => EProductCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
