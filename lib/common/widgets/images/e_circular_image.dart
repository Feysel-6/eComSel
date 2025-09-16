import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utlis/constants/colors.dart';
import '../../../utlis/constants/sizes.dart';

class ECircularImage extends StatelessWidget {
  const ECircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = ESizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (dark ? EColors.black : EColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child:
              isNetworkImage
                  ? CachedNetworkImage(
                    imageUrl: image,
                    fit: fit,
                    color: overlayColor,
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                  : Image(
                    fit: fit,
                    image:
                        isNetworkImage
                            ? NetworkImage(image)
                            : AssetImage(image) as ImageProvider,
                    color: overlayColor,
                  ),
        ),
      ),
    );
  }
}
