import 'package:ecom_sel/features/shop/controllers/address_controller.dart';
import 'package:ecom_sel/features/shop/controllers/product/checkout_controller.dart';
import 'package:ecom_sel/features/shop/controllers/product/product_variation_controller.dart';
import 'package:ecom_sel/utlis/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
      Get.put(NetworkManager());
      Get.put(ProductVariationController());
      Get.put(CheckoutController());
      Get.put(AddressController());
  }
}