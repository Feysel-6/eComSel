import 'package:ecom_sel/common/widgets/appbar/appbar.dart';
import 'package:ecom_sel/common/widgets/images/e_circular_image.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:ecom_sel/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utlis/constants/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: EAppBar(title: Text('Profile'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : EImages.user;
                      return ECircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: ESizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),
              ESectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(height: ESizes.spaceBtwItems),

              EProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName.capitalize!,
                onPressed: () => Get.to(() => ChangeName()),
              ),
              EProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                onPressed: () {},
              ),

              const SizedBox(height: ESizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),

              const ESectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: ESizes.spaceBtwItems),

              EProfileMenu(
                title: 'User Id',
                value: controller.user.value.id,
                onPressed: () {},
                icon: Iconsax.copy,
              ),
              EProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email.capitalize!,
                onPressed: () {},
              ),
              EProfileMenu(
                title: 'Phone Number',
                value:
                    controller.user.value.phoneNumber != null &&
                            controller.user.value.phoneNumber!.isNotEmpty
                        ? controller.user.value.phoneNumber!
                        : 'Not Set',
                onPressed: () {},
              ),
              EProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              EProfileMenu(
                title: 'Date of Birth',
                value: '10 Oct, 1994',
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
