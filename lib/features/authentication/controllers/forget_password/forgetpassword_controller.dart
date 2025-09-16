import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/helpers/network_manager.dart';
import '../../../../utlis/loaders/loaders.dart';
import '../../../../utlis/popups/full_screen_loader.dart';
import '../../screens/password_configuration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      EFullScreenLoader.openLoadingDialog(
        'Proccesing your request...',
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

      if (!forgetPasswordFormKey.currentState!.validate()) return;

      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      EFullScreenLoader.stopLoading(
        onFinish: () {
          ELoaders.successSnackBar(title: "Reset Password Link Sent");
          Get.to(ResetPassword(email: email.text.trim()));
        },
      );
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      EFullScreenLoader.openLoadingDialog(
        'Proccesing your request...',
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

      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email,
      );

      EFullScreenLoader.stopLoading(
        onFinish: () {
          ELoaders.successSnackBar(title: "Reset Password Link Sent");
          Get.to(ResetPassword(email: email));
        },
      );
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
