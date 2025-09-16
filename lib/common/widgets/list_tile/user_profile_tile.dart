import 'package:ecom_sel/features/personalization/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utlis/constants/colors.dart';
import '../../../utlis/constants/image_strings.dart';
import '../images/e_circular_image.dart';

class EUserProfileTile extends StatelessWidget {
  const  EUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image =
        networkImage.isNotEmpty ? networkImage : EImages.user;
        return ECircularImage(
          image: image,
          width: 50,
          height: 50,
          padding: 0,
          isNetworkImage: networkImage.isNotEmpty,
        );
      }),
      title: Text(controller.user.value.fullName.capitalize!, style: Theme.of(context).textTheme.headlineSmall!.apply(color: EColors.white),),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: EColors.white),),
      trailing: IconButton(onPressed: () => Get.to(() => ProfileScreen()), icon: const Icon(Iconsax.edit, color: EColors.white,)),
    );
  }
}