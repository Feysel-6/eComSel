import 'package:ecom_sel/common/widgets/texts/section_heading.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utlis/constants/sizes.dart';
import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
      name: 'Paypal',
      image: EImages.paypal,
    );
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(ESizes.lg),
              child: Column(
                children: [
                  ESectionHeading(
                    title: 'Select Payment Method',
                    showActionButton: false,
                  ),
                  SizedBox(height: ESizes.spaceBtwSections),
                  EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: EImages.paypal)),
                  SizedBox(height: ESizes.spaceBtwItems/2),
                  EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: EImages.googlePay)),
                  SizedBox(height: ESizes.spaceBtwItems/2),
                  EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: EImages.applePay)),
                  SizedBox(height: ESizes.spaceBtwItems/2),
                  EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Visa', image: EImages.visa)),
                  SizedBox(height: ESizes.spaceBtwItems/2),
                  EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: EImages.masterCard)),
                  SizedBox(height: ESizes.spaceBtwItems/2),
                  EPaymentTile(paymentMethod: PaymentMethodModel(name: 'PayStack', image: EImages.paystack)),
                  SizedBox(height: ESizes.spaceBtwItems/2),
                  EPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: EImages.creditCard)),
                  SizedBox(height: ESizes.spaceBtwItems/2),
                  SizedBox(height: ESizes.spaceBtwSections),

                ],
              ),
            ),
          ),
    );
  }
}
