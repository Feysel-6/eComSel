import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:ecom_sel/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utlis/helpers/cloud_helper_functions.dart';
import '../../../shop/controllers/address_controller.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: EColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: EColors.white),
      ),
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Obx(()
              => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getUserAddresses(),
              builder: (context, asyncSnapshot) {
                final widget = ECloudHelperFunctions.checkMultipleRecordState(
                  asyncSnapshot: asyncSnapshot,
                );
                if (widget != null) return widget;

                final addresses = asyncSnapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:
                      (_, index) => ESingleAddress(addressModel: addresses[index], onTap: () => controller.selectAddress(addresses[index]),),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
