import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/data/repositories/address/address_repository.dart';
import 'package:ecom_sel/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:ecom_sel/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecom_sel/features/shop/models/address_model.dart';
import 'package:ecom_sel/utlis/constants/sizes.dart';
import 'package:ecom_sel/utlis/helpers/cloud_helper_functions.dart';
import 'package:get/get.dart';

import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/helpers/network_manager.dart';
import '../../../utlis/loaders/loaders.dart';
import '../../../utlis/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  Future<List<AddressModel>> getUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (e) => e.selected.value,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      throw ('Something went wrong');
    }
  }

  Future selectAddress(AddressModel address) async {
    try {
      // Get.defaultDialog(
      //   title: '',
      //   onWillPop: () async {
      //     return false;
      //   },
      //   barrierDismissible: false,
      //   backgroundColor: Colors.transparent,
      //   content: const ECircularLoader(),
      // );
      if (selectedAddress.value.id!.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id!,
          false,
        );
      }
      address.selected.value = true;
      selectedAddress.value = address;
      await addressRepository.updateSelectedField(address.id!, true);
      // Get.back();
    } catch (e) {
      ELoaders.errorSnackBar(
        title: 'Error in Selection',
        message: e.toString(),
      );
    }
  }

  Future addNewAddresses() async {
    try {
      EFullScreenLoader.openLoadingDialog(
        'Storing Address...',
        EImages.docerAnimation,
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        ELoaders.errorSnackBar(
          title: 'No Internet',
          message: 'Please check your connection and try again.',
        );
        return;
      }

      if (!addressFormKey.currentState!.validate()) return;

      final address = AddressModel(
        name: name.text.trim(),
        street: street.text.trim(),
        postalCode: postalCode.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        selected: true.obs,
      );

      final inserted = await addressRepository.addAddress(address);

      address.id = inserted[0]['id'];
      await selectAddress(address);

      EFullScreenLoader.stopLoading();
      ELoaders.successSnackBar(
        title: "Congratulations",
        message: 'Your account has been created! Verify email to continue',
      );

      refreshData.toggle();
      resetFormField();
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      EFullScreenLoader.stopLoading();
    }
  }

  void resetFormField() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => Container(
            padding: EdgeInsets.all(ESizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ESectionHeading(
                  title: 'Select Address',
                  showActionButton: false,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getUserAddresses(),
                    builder: (_, asyncSnapshot) {
                      final response =
                          ECloudHelperFunctions.checkMultipleRecordState(
                            asyncSnapshot: asyncSnapshot,
                          );
                      if (response != null) return response;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: asyncSnapshot.data!.length,
                        itemBuilder:
                            (_, index) => ESingleAddress(
                              addressModel: asyncSnapshot.data![index],
                              onTap: () async {
                                await selectAddress(asyncSnapshot.data![index]);
                                Get.back();
                              },
                            ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: ESizes.defaultSpace * 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const AddNewAddressScreen()),
                    child: const Text('Add new address'),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
