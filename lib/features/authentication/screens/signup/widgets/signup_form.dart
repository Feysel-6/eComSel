import 'package:ecom_sel/utlis/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../common/widgets/login_signup/social_button.dart';
import '../../../../../utlis/constants/colors.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';
import '../../../../../utlis/helpers/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';

class ESignupForm extends StatelessWidget {
  const ESignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = EHelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator:
                      (value) =>
                      EValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ETexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: ESizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator:
                      (value) =>
                      EValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ETexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.username,
            validator:
                (value) => EValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: ETexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),
          TextFormField(
            validator: (value) => EValidator.validateEmail(value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(
              labelText: ETexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),
          TextFormField(
            validator: (value) => EValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            expands: false,
            decoration: const InputDecoration(
              labelText: ETexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),
          Obx(
                () => TextFormField(
              validator: (value) => EValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: ETexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed:
                      () =>
                  controller.hidePassword.value =
                  !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: ESizes.spaceBtwInputFields),

          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Obx(
                      () => Checkbox(
                    value: controller.privacyPolicy.value, // Corrected line
                    onChanged:
                        (value) =>
                    controller.privacyPolicy.value = // Corrected line
                    !controller.privacyPolicy.value, // Corrected line
                  ),
                ),
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
              onPressed: controller.signup,
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