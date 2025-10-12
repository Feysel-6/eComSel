import 'package:ecom_sel/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/shop/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.id;
      if (userId.isEmpty) throw Exception('Unable to find user information. Try again in few minutes.');

      final response = await _db.from('addresses').select().eq('user_id', userId);
      final result = (response as List)
          .map((e) => AddressModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return result;
    } catch (e) {
      throw Exception('Something went wrong while fetching address information: $e');
    }
  }

  Future<void> updateSelectedField (String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.id;
      if (userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';
      await _db.from('addresses')
          .update({'is_default': selected})
          .eq('id', addressId);
    } catch (e) {
      throw 'Something went wrong while fetching Address Information. Try again later';
    }
  }

  Future addAddress(AddressModel address) async {
    try {
        final userId = AuthenticationRepository.instance.authUser!.id;
        final addressData = {
          'user_id': userId,
          'name': address.name,
          'phone': address.phoneNumber,
          'street': address.street,
          'city': address.city,
          'state': address.state,
          'postal_code': address.postalCode,
          'country': address.country,
          'is_default': address.selected,
        };

        final currentAddress = await _db.from('addresses').insert(addressData).select('id');
        return currentAddress;
    } catch(e){
      throw 'Something went wrong while fetching Address Information. Try again later';
    }
  }

}
