import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../loaders/animation_loader.dart';

class EFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder:
          (_) => PopScope(
            canPop: false,
            child: Container(
              color:
                  EHelperFunctions.isDarkMode(Get.context!)
                      ? EColors.dark
                      : EColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250),
                  EAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
            ),
          ),
    );
  }

  static void stopLoading({VoidCallback? onFinish}) {
    Navigator.of(Get.overlayContext!).pop();
    if (onFinish != null) {
      Future.microtask(onFinish);
    }
  }
}
