import 'package:ecom_sel/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utlis/constants/sizes.dart';
import '../../../../../utlis/constants/text_strings.dart';
import '../../../../../utlis/validators/validation.dart';

class ReAuthenticateUserLoginForm extends StatelessWidget {
  const ReAuthenticateUserLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: EAppBar(
        title: Text(
          'Re-Authenticate User',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use real name for easy verifications.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: ESizes.spaceBtwSections),

            /// Form
            Form(
              key: controller.reAuthFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: EValidator.validateEmail,
                    decoration: const InputDecoration(
                      labelText: ETexts.email,
                      prefixIcon: Icon(Iconsax.direct_right),
                    ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwInputFields),

                  TextFormField(
                      controller: controller.verifyPassword,
                      validator:
                          (value) =>
                              EValidator.validateEmptyText('Password', value),
                      decoration: const InputDecoration(
                        labelText: ETexts.password,
                        prefixIcon: Icon(Iconsax.password_check),
                      ),
                    ),

                ],
              ),
            ),

            const SizedBox(height: ESizes.spaceBtwSections),

            /// Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.reAuthenticateEmailAndPasswordUser(),
                child: const Text('verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
