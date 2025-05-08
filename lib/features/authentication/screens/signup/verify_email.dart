import 'package:ecom_sel/features/authentication/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';
import '../../../../utlis/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: AssetImage(EImages.deliveredEmailIllustration),
                width: EHelperFunctions.screenWidth() * 0.6,
              ),
              SizedBox(height: ESizes.spaceBtwSections),

              Text(
                ETexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ESizes.spaceBtwItems),

              Text(
                'feyselteshome05@gmail.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ESizes.spaceBtwItems),

              Text(
                ETexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ESizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      () => Get.to(
                        () => SuccessScreen(
                          image: EImages.staticSuccessIllustration,
                          title: ETexts.yourAccountCreatedTitle,
                          description: ETexts.yourAccountCreatedSubTitle,
                          onPressed: () => Get.to(() => const LoginScreen()),
                        ),
                      ),
                  child: Text(ETexts.tContinue),
                ),
              ),
              SizedBox(height: ESizes.spaceBtwItems),

              Text(
                ETexts.resendEmail,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ESizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
