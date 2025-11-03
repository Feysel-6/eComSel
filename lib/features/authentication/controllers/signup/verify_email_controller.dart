import 'dart:async';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/constants/text_strings.dart';
import '../../../../utlis/loaders/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final supabase = Supabase.instance.client;

  /// Check email verification by attempting login
  Future<void> checkEmailVerificationStatus(String email, String password) async {
    try {
      final loginRes = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = loginRes.user;

      if (user != null && user.emailConfirmedAt != null) {
        // Redirect to home / success screen
        Get.offAll(
              () => SuccessScreen(
            image: EImages.successfullyRegisterAnimation,
            title: ETexts.yourAccountCreatedTitle,
            description: ETexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      } else {
        Get.snackbar(
          "Not Verified",
          "Your email is not verified yet. Please check your inbox.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on AuthException catch (e) {
      Get.snackbar("Not Verified", e.message, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Resend verification email
  Future<void> resendVerificationEmail(String email) async {
    try {
      await supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );

      ELoaders.successSnackBar(
        title: "Email Sent",
        message: "We've resent a verification email to $email. Please check your inbox.",
      );
    } on AuthException catch (e) {
      ELoaders.errorSnackBar(
        title: "Error",
        message: e.message,
      );
    } catch (_) {
      ELoaders.errorSnackBar(
        title: "Error",
        message: "Something went wrong while resending the email.",
      );
    }
  }
}

