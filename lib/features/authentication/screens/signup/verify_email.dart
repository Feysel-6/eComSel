import 'package:ecom_sel/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signup/clear_button.dart';
import '../../../../common/widgets/success_screen/check_your_email.dart';
import '../../../../utlis/constants/text_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email, this.password});

  final String? email;
  final String? password;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [ClearButton()],
      ),
      body: SingleChildScrollView(
        child: CheckYourEmail(
          title: ETexts.confirmEmail,
          subTitle: ETexts.confirmEmailSubTitle,
          btnTxt: ETexts.tContinue,
          email: email,
          onPressed: () =>
              controller.checkEmailVerificationStatus(email!, password!),
          onResend: () => controller.resendVerificationEmail(email!),
        ),
      ),
    );
  }
}

