
import 'package:ecom_sel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecom_sel/data/repositories/user/user_repository.dart';
import 'package:ecom_sel/features/authentication/screens/signup/verify_email.dart';
import 'package:ecom_sel/utlis/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/helpers/network_manager.dart';
import '../../../../utlis/popups/full_screen_loader.dart';
import '../../models/user_model.dart';


class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      EFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        EImages.processInfo,
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

      if (!signupFormKey.currentState!.validate()) return;

      if (!privacyPolicy.value) {
        ELoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
          'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // Sign up
      final response = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim()
      );

      final newUser = UserModel(
        id: response.user!.id,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      EFullScreenLoader.stopLoading(
        onFinish: () {
          ELoaders.successSnackBar(
            title: "Congratulations",
            message: 'Your account has been created! Verify email to continue',
          );

          // Pass email and password to verify screen
          Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
            password: password.text.trim(),
          ));
        },
      );
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      EFullScreenLoader.stopLoading();
    }
  }
}

