import 'package:ecom_sel/utlis/formatters/formatters.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AddressModel {
  String? id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String? userId;
  final DateTime? dateTime;
  Rx<bool> selected;


  AddressModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.userId,
    this.dateTime,
    Rx<bool>? selected,
  }): selected = selected ?? false.obs;

  String get formattedPhoneNo => EFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
    userId: '',
    selected: false.obs,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phoneNumber,       // DB column
      'street': street,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'country': country,
      'user_id': userId,
      'created_at': dateTime?.toIso8601String(), // DB column
      'is_default': selected,     // DB column
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      phoneNumber: map['phone'] as String,
      street: map['street'] as String,
      city: map['city'] as String,
      state: map['state'] as String? ?? '',
      postalCode: map['postal_code'] as String? ?? '',
      country: map['country'] as String,
      dateTime: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
        selected: (map['is_default'] as bool?)?.obs ?? false.obs,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
