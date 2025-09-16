import 'package:ecom_sel/features/personalization/controllers/user_controller.dart';
import 'package:ecom_sel/features/personalization/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/helpers/network_manager.dart';
import '../../../utlis/loaders/loaders.dart';
import '../../../utlis/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepo = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      EFullScreenLoader.openLoadingDialog(
        'We are updating your information...',
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

      if (!updateUserNameFormKey.currentState!.validate()) return;

      Map<String, dynamic> name = {'first_name': firstName.text.trim(), 'last_name': lastName.text.trim()};
      await userRepo.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      EFullScreenLoader.stopLoading(
        onFinish: () {
          ELoaders.successSnackBar(title: "Successful", message: 'Your name has been updated');
          Get.off(() => const ProfileScreen());
        },
      );
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
