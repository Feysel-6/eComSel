import 'package:flutter/material.dart';

import '../../../utlis/constants/image_strings.dart';
import '../../../utlis/constants/sizes.dart';
import '../../../utlis/helpers/helper_functions.dart';

class CheckYourEmail extends StatelessWidget {
  const CheckYourEmail({
    super.key,
    required this.title,
    this.email,
    required this.subTitle,
    required this.btnTxt,
    required this.onPressed,  this.onResend,
  });

  final String title, subTitle, btnTxt;
  final String? email;
  final VoidCallback onPressed;
  final VoidCallback? onResend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ESizes.defaultSpace),
      child: Column(
        children: [
          Image(
            image: AssetImage(EImages.deliveredEmailIllustration),
            width: EHelperFunctions.screenWidth() * 0.6,
          ),
          SizedBox(height: ESizes.spaceBtwSections),

          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ESizes.spaceBtwItems),

          if (email != null) ...[
            Text(
              email!,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ESizes.spaceBtwItems),
          ],

          Text(
            subTitle,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ESizes.spaceBtwItems),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: onPressed, child: Text(btnTxt)),
          ),
          SizedBox(height: ESizes.spaceBtwItems),

          TextButton(
            onPressed: onResend,
            child: const Text(
              "Resend verification email",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwItems),
        ],
      ),
    );
  }
}
