import 'package:ecom_sel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ecom_sel/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

import '../../../../common/styles/spacing_style.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_button.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const LoginHeader(),
              const LoginForm(),
              const EFormDivider(dividerText: ETexts.orSignInWith
              ),
              const SizedBox(height: ESizes.spaceBtwSections),
              const ESocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}


