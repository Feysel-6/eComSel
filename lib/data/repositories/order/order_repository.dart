import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/shop/models/order_model.dart';
import '../authentication/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.id;
      if (userId.isEmpty) {
        throw Exception(
          'Unable to find user information. Try again in few minutes.',
        );
      }

      final response = await _db.from('orders').select().eq('user_id', userId);
      final result =
          (response as List)
              .map((e) => OrderModel.fromMap(e as Map<String, dynamic>))
              .toList();
      return result;
    } catch (e) {
      throw 'Something went Wrong while fetch Order Information. Try again later.';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      final orderData = {
        'user_id': userId,
        'payment_method': order.paymentMethod,
        'total_amount': order.totalAmount,
        'status': order.status,
        'delivery_date': order.deliveryDate?.toIso8601String(),
        'address_id': order.addressId,
      };

      await _db.from('orders').insert(orderData);
    } catch (e) {
      throw 'Something went Wrong while Inserting Order Information. Try again later.';
    }
  }
}
