import 'package:ecom_sel/utlis/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ESizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading:
            showBackArrow
                ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(HugeIcons.strokeRoundedArrowLeft04),
                )
                : leadingIcon != null ? IconButton(
                  onPressed: onLeadingPressed,
                  icon: Icon(leadingIcon),
                ):null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(EDeviceUtils.getAppBarHeight());
}
