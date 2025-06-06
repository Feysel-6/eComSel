import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:ecom_sel/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: EColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(HugeIcons.strokeRoundedAdd01, color: EColors.white,),
      ),
      appBar: EAppBar(
        showBackArrow: false,
        title: Text('Addresses', style: Theme
            .of(context)
            .textTheme
            .headlineSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace), child: Column(
          children: [
            ESingleAddress(selectedAddress: true),
            ESingleAddress(selectedAddress: false),
          ],
        ),),
      ),
    );
  }
}
