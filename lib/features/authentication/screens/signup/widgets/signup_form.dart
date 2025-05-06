import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../common/widgets/login_signup/social_button.dart';
import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';
import '../../../../../utlis/helpers/helper_functions.dart';

class ESignupForm extends StatelessWidget {
  const ESignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ETexts.firstName,
                    prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                  ),
                ),
              ),
              SizedBox(width: ESizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ETexts.firstName,
                    prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: ETexts.username,
              prefixIcon: Icon(Icons.supervised_user_circle_outlined),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: ETexts.email,
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: ETexts.phoneNo,
              prefixIcon: Icon(Icons.call),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: ETexts.password,
              prefixIcon: Icon(Icons.password_outlined),
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),

          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(value: true, onChanged: (value) {}),
              ),
              const SizedBox(width: ESizes.sm),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${ETexts.iAgreeTo} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: ETexts.privacyPolicy,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? EColors.white : EColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? EColors.white : EColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: ' ${ETexts.and} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: ETexts.termsOfUse,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? EColors.white : EColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? EColors.white : EColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: ESizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(ETexts.createAccount),
            ),
          ),
          const SizedBox(height: ESizes.spaceBtwItems),
          EFormDivider(dividerText: ETexts.orSignInWith.capitalize!),
          const SizedBox(height: ESizes.spaceBtwItems),
          const ESocialButtons(),
        ],
      ),
    );
  }
}
