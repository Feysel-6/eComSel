import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/data/repositories/banners/banner_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/repositories/categories/category_repository.dart';
import '../../../../utlis/constants/sizes.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryRepository());
    final bannerController = Get.put(BannerRepository());
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
                  ESettingMenuTile(icon: Iconsax.menu_14, title: 'Upload Banners', subTitle: '', trailing: Icon(Iconsax.arrow_circle_up4), onTap: bannerController.pushDummyData,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
