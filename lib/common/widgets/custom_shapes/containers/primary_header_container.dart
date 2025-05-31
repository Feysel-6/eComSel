import 'package:flutter/cupertino.dart';

import '../../../../utlis/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class EPrimaryHeaderContainer extends StatelessWidget {
  const EPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ECurvedEdgeWidget(
      child: Container(
        color: EColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 320,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: ECircularContainer(
                  backgroundColor: EColors.white.withValues(alpha: 0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: ECircularContainer(
                  backgroundColor: EColors.white.withValues(alpha: 0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
