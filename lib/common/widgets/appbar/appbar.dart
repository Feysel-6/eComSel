import 'package:ecom_sel/utlis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utlis/constants/sizes.dart';

class EAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.onLeadingPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? onLeadingPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading:
          showBackArrow
              ? IconButton(
                onPressed: () {
                  if (Get.isSnackbarOpen) {
                    Get.closeCurrentSnackbar();
                  }
                  Get.back();
                },
                icon: const Icon(Iconsax.arrow_left),
              )
              : leadingIcon != null
              ? IconButton(onPressed: onLeadingPressed, icon: Icon(leadingIcon))
              : null,
      title:
          title != null
              ? Padding(padding: EdgeInsets.only(left: ESizes.md), child: title)
              : null,
      actions:
          actions
              ?.map(
                (action) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: ESizes.md),
                  child: action,
                ),
              )
              .toList(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(EDeviceUtils.getAppBarHeight());
}
