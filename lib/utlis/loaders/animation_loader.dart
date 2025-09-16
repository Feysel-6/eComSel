import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/sizes.dart';

/// I mean honestly this how description is written
class EAnimationLoaderWidget extends StatelessWidget {
  const EAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Lottie.asset(animation, fit: BoxFit.contain),
          ),
          const SizedBox(height: ESizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: ESizes.defaultSpace),
          showAction
              ? SizedBox(
                width: 250,
                child: OutlinedButton(
                  onPressed: onActionPressed,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: EColors.dark,
                  ),
                  child: Text(
                    actionText!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.apply(color: EColors.light),
                  ),
                ),
              )
              : const SizedBox(),
        ],
      ),
    );
  }
}
