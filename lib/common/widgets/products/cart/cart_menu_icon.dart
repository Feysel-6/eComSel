import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../utlis/constants/colors.dart';

class ECartCounterIcon extends StatelessWidget {
  const ECartCounterIcon({
    super.key, required this.onPressed, required this.iconColor,
  });

  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            HugeIcons.strokeRoundedShoppingBag02,
            color: iconColor,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
                color: EColors.black,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: Text('2', style: Theme.of(context).textTheme.labelLarge!.apply(color: EColors.white, fontSizeFactor: 0.8),),
            ),
          ),
        )
      ],
    );
  }
}
