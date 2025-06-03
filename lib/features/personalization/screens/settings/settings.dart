import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecom_sel/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../../../utlis/constants/colors.dart';
import '../../../../utlis/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            EPrimaryHeaderContainer(
              child: Column(
                children: [
                  EAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: EColors.white),
                    ),
                  ),

                  EUserProfileTile(),
                  const SizedBox(height: ESizes.spaceBtwSections),
                ],
              ),
            ),

            Padding(padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(
              children: [
                ESectionHeading(title: 'Account Setting', showActionButton: false,),
                SizedBox(height: ESizes.spaceBtwItems,),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedHome06, title: 'My Addresses', subTitle: 'Set shopping delivery address', onTap: (){},),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedShoppingBag01, title: 'My Cart', subTitle: 'Add, remove products and move to checkout', onTap: (){},),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedShoppingBagCheck, title: 'My Order', subTitle: 'In-progress and Completed Orders', onTap: (){},),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedBank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account', onTap: (){},),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedDiscount, title: 'My Coupons', subTitle: 'List of all the discounted coupons', onTap: (){},),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedNotification01, title: 'Notifications', subTitle: 'Set any kind of notification message', onTap: (){},),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedSecurity, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts', onTap: (){},),
                
                SizedBox(height: ESizes.spaceBtwSections,),
                ESectionHeading(title: 'App Settings', showActionButton: false,),
                SizedBox(height: ESizes.spaceBtwItems,),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedDocumentAttachment, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase'),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedLocation01, title: 'Geolocation', subTitle: 'Get recommendation based on location', trailing: Switch(value: true, onChanged: (value){}),),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedUserLock01, title: 'Safe Mode', subTitle: 'Search result is safe for all ages', trailing: Switch(value: false, onChanged: (value){}),),
                ESettingMenuTile(icon: HugeIcons.strokeRoundedImage01, title: 'HD Image Quality', subTitle: 'Set image quality to be seen', trailing: Switch(value: false, onChanged: (value){}),),
                const SizedBox(height: ESizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(onPressed: (){}, child: const Text('Logout')),
                ),
                const SizedBox(height: ESizes.spaceBtwSections * 2.5 ,)

              ],
            ),)
          ],
        ),
      ),
    );
  }
}


