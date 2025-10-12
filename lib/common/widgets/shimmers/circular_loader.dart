import 'package:ecom_sel/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class ECircularLoader extends StatelessWidget {
  const ECircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}