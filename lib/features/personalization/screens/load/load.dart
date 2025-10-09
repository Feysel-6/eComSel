import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/data/repositories/banners/banner_repository.dart';
import 'package:ecom_sel/data/repositories/brand/brand_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/repositories/categories/category_repository.dart';
import '../../../../data/repositories/product/product_attribute_repository.dart';
import '../../../../data/repositories/product/product_images_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../data/repositories/product/product_variation_repository.dart';
import '../../../../utlis/constants/sizes.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryRepository.instance;
    final bannerController = BannerRepository.instance;
    final productController = Get.put(ProductRepository());
    final brandsController = Get.put(BrandRepository());
    final productVariationController = Get.put(ProductVariationRepository());
    final productAttributeController = Get.put(ProductAttributeRepository());
    final productImageController = Get.put(ProductImagesRepository());

    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Upload Data',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  ESectionHeading(
                    title: 'Main Record',
                    showActionButton: false,
                  ),
                  SizedBox(height: ESizes.spaceBtwItems),
                  ESettingMenuTile(icon: Iconsax.menu_14, title: 'Upload Categories', subTitle: '', trailing: Icon(Iconsax.arrow_circle_up4), onTap: categoryController.pushDummyData,),
                  ESettingMenuTile(icon: Iconsax.menu_14, title: 'Upload Banners', subTitle: '', trailing: Icon(Iconsax.arrow_circle_up4), onTap: bannerController.pushDummyData,),
                  ESettingMenuTile(icon: Iconsax.menu_14, title: 'Upload Brands', subTitle: '', trailing: Icon(Iconsax.arrow_circle_up4), onTap: brandsController.pushDummyData,),
                  ESettingMenuTile(icon: Iconsax.menu_14, title: 'Upload Products', subTitle: '', trailing: Icon(Iconsax.arrow_circle_up4), onTap: productController.pushDummyData,),
                  ESettingMenuTile(icon: Iconsax.menu_14, title: 'Upload Product Images', subTitle: '', trailing: Icon(Iconsax.arrow_circle_up4), onTap: productImageController.pushDummyData,),
                  ESettingMenuTile(icon: Iconsax.menu_14, title: 'Upload Product Variations', subTitle: '', trailing: Icon(Iconsax.arrow_circle_up4), onTap: productVariationController.pushDummyData,),
                  ESettingMenuTile(icon: Iconsax.menu_14, title: 'Upload Product Attributes', subTitle: '', trailing: Icon(Iconsax.arrow_circle_up4), onTap: productAttributeController.pushDummyData,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
