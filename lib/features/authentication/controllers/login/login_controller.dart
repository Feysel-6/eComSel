import 'package:ecom_sel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecom_sel/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:ecom_sel/features/personalization/controllers/user_controller.dart';
import 'package:ecom_sel/utlis/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/exceptions/supabase_auth_exceptions.dart';
import '../../../../utlis/helpers/network_manager.dart';
import '../../../../utlis/loaders/loaders.dart';
import '../../screens/signup/verify_email.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final userController = Get.put(UserController());
  final verifyEmailController = Get.put(VerifyEmailController());

  // @override
  // void onInit() {
  //   email.text = localStorage.read('REMEMBER_ME_EMAIL');
  //   password.text = localStorage.read('REMEMBER_ME_PASSWORD');
  // }

  Future<void> emailAndPasswordSignIn() async {
    try {
      EFullScreenLoader.openLoadingDialog(
        'Logging you in...',
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

      if (!loginFormKey.currentState!.validate()) return;

      // if (rememberMe.value) {
      //   localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      //   localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      // }

      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      EFullScreenLoader.stopLoading(
        onFinish: () {
          ELoaders.successSnackBar(title: "Logged In");
          AuthenticationRepository.instance.screenRedirect();
        },
      );
    } catch (e) {
      EFullScreenLoader.stopLoading();
      if(e is EAuthException && e.message.contains('Email not confirmed')){
        Get.to(() => VerifyEmailScreen(
          email: email.text.trim(),
          password: password.text.trim(),
        ));
        await verifyEmailController.resendVerificationEmail(email.text.trim());
      } else {
        ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      }
    }
  }

  Future<void> googleSignIn() async {
    try {
      EFullScreenLoader.openLoadingDialog(
        'Logging you in...',
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

      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      await userController.saveUserRecord(userCredentials);

      EFullScreenLoader.stopLoading(
        onFinish: () {
          ELoaders.successSnackBar(title: "Logged In");
          AuthenticationRepository.instance.screenRedirect();
        },
      );
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
