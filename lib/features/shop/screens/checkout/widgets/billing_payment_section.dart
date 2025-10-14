import 'package:ecom_sel/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/utlis/constants/colors.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:ecom_sel/utlis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utlis/constants/sizes.dart';
import '../../../controllers/product/checkout_controller.dart';

class EBillingPaymentSection extends StatelessWidget {
  const EBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ESectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Obx(
            () => Row(
              children: [
                ERoundedContainer(
                  width: 60,
                  height: 35,
                  backgroundColor: dark ? EColors.light : EColors.white,
                  padding: EdgeInsets.all(ESizes.sm),
                  child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.contain,),
                ),
                const SizedBox(width: ESizes.spaceBtwItems / 2),
                Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge,)
              ],
            ),
        ),

      ],
    );
  }
}
