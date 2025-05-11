import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utlis/constants/image_strings.dart';
import '../../../../utlis/constants/sizes.dart';
import '../../../../utlis/constants/text_strings.dart';
import '../login/login.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          children: [
            Image(
              image: AssetImage(EImages.deliveredEmailIllustration),
              width: EHelperFunctions.screenWidth() * 0.6,
            ),
            SizedBox(height: ESizes.spaceBtwSections),

            Text(
              ETexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ESizes.spaceBtwItems),

            Text(
              ETexts.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ESizes.spaceBtwItems),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text(ETexts.done)),
            ),
            SizedBox(height: ESizes.spaceBtwItems),

            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: () {}, child: Text(ETexts.resendEmail)),
            ),
          ],
        ),
      ),
    );
  }
}
