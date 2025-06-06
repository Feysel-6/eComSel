import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class ERatingBarIndicator extends StatelessWidget {
  const ERatingBarIndicator({
    super.key, required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(rating: rating, itemSize: 20, itemBuilder: (_, __) => Icon(HugeIcons.strokeRoundedStar, color: EColors.primary,), unratedColor: EColors.grey, );
  }
}