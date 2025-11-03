import 'package:ecom_sel/utlis/helpers/helper_functions.dart';

import '../../../utlis/constants/enums.dart';

class OrderModel {
  String? id;
  String userId;
  String paymentMethod;
  double totalAmount;
  String status;
  DateTime? deliveryDate;
  DateTime? orderDate;
  String addressId;

  OrderModel({
    this.id,
    required this.userId,
    required this.paymentMethod,
    required this.totalAmount,
    required this.status,
    required this.deliveryDate,
    this.orderDate,
    required this.addressId,
  });

  String get formattedOrderDate => EHelperFunctions.getFormattedDate(orderDate!);

  String get formattedDeliveryDate =>
      deliveryDate != null
          ? EHelperFunctions.getFormattedDate(deliveryDate!)
          : '';

  String get orderStatusText =>
      status == OrderStatus.delivered.toString()
          ? 'Delivered'
          : status == OrderStatus.shipped.toString()
          ? 'Shipment on the way'
          : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'user_id': userId,
      'payment_method': paymentMethod,
      'total_amount': totalAmount,
      'status': status,
      'delivery_date': deliveryDate?.toIso8601String(),
      'order_date': orderDate?.toIso8601String(),
      'address_id': addressId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      paymentMethod: map['payment_method'] as String,
      totalAmount: (map['total_amount'] as num).toDouble(),
      status: map['status'] as String,
      deliveryDate: DateTime.parse(map['delivery_date']),
      orderDate: DateTime.parse(map['order_date']),
      addressId: map['address_id'] as String,
    );
  }
}
