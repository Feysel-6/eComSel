import 'package:ecom_sel/common/widgets/login_signup/clear_button.dart';
import 'package:ecom_sel/common/widgets/success_screen/check_your_email.dart';
import 'package:ecom_sel/features/authentication/controllers/forget_password/forgetpassword_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utlis/constants/text_strings.dart';
import '../login/login.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [ClearButton()],
      ),
      body: CheckYourEmail(
        title: ETexts.changeYourPasswordTitle,
        email: email,
        subTitle: ETexts.changeYourPasswordSubTitle,
        btnTxt: ETexts.done,
        onPressed: () => Get.offAll(() => const LoginScreen()),
        onResend: () => ForgetPasswordController.instance.resendPasswordResetEmail(email!),
      ),
    );
  }
}
