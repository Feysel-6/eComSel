import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../utlis/loaders/loaders.dart';
import '../../../features/shop/models/product_attribute_model.dart';

class ProductAttributeRepository extends GetxController {
  static ProductAttributeRepository get instance => Get.find();

  final _db = Supabase.instance.client;

  Future<List<ProductAttributeModel>> fetchProductAttributes(
    String productId,
  ) async {
    try {
      final response = await _db
          .from('product_attributes')
          .select()
          .eq('product_id', productId);

      return (response as List)
          .map((e) => ProductAttributeModel.fromMap(e))
          .toList();
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<void> pushDummyData() async {
    try {
      final List<ProductAttributeModel> attributes = [
        ProductAttributeModel(
          productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
          name: 'Color',
          values: ['Green', 'Black', 'Red'],
        ),
        ProductAttributeModel(
          productId: 'abca6eb6-1216-4847-b9ef-ced604ee6fab',
          name: 'Size',
          values: ['EU 30', 'EU 32', 'EU 34'],
        ),

        ProductAttributeModel(productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d', name: 'Color', values: ['Red', 'Yellow', 'Green', 'Blue']),
        ProductAttributeModel(productId: '1bc2cb73-3f51-4c2c-82a3-2a82d0856a1d', name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ];

      for (var attribute in attributes) {
        await _db.from('product_attributes').insert(attribute.toJson());
      }

      ELoaders.successSnackBar(
        title: 'Uploaded Successfully',
        message: 'Product attributes uploaded successfully!',
      );
    } on PostgrestException catch (e) {
      ELoaders.errorSnackBar(title: 'Database Error', message: e.message);
      throw Exception('Database Error: ${e.message}');
    } on AuthException catch (e) {
      ELoaders.errorSnackBar(title: 'Auth Error', message: e.message);
      throw AuthException(e.message);
    } on FormatException {
      throw const FormatException();
    } catch (e) {
      ELoaders.errorSnackBar(
        title: 'Error',
        message: 'Something went wrong. Please try again.',
      );
      throw Exception('Something went wrong. Please try again');
    }
  }
}
