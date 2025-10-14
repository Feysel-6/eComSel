import 'package:ecom_sel/common/widgets/success_screen/success_screen.dart';
import 'package:ecom_sel/features/shop/controllers/product/cart_controller.dart';
import 'package:ecom_sel/features/shop/models/order_model.dart';
import 'package:ecom_sel/navigation_menu.dart';
import 'package:ecom_sel/utlis/constants/image_strings.dart';
import 'package:ecom_sel/utlis/popups/full_screen_loader.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../utlis/constants/enums.dart';
import '../../../../utlis/loaders/loaders.dart';
import '../address_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> getUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      ELoaders.warningSnackBar(title: 'Oh snap ', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      EFullScreenLoader.openLoadingDialog(
          'Processing your order', EImages.processInfo);
      final userId = AuthenticationRepository.instance.authUser!.id;
      if (userId.isEmpty) return;

      final order = OrderModel(userId: userId,
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          totalAmount: totalAmount,
          status: OrderStatus.pending.toString(),
          deliveryDate: DateTime.now(),
          addressId: addressController.selectedAddress.value.id!);

      await orderRepository.saveOrder(order, userId);

      cartController.clearCart();
      
      Get.off(() => SuccessScreen(image: EImages.staticSuccessIllustration, title: 'Payment Success', description: 'Your item will be shipped soon!', onPressed: () => Get.offAll(() => const NavigationMenu()),));
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Unsuccessful', message: e.toString());
      EFullScreenLoader.stopLoading();
    }
  }

}