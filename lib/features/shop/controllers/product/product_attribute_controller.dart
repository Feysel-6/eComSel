import 'package:get/get.dart';

import '../../../../data/repositories/product/product_attribute_repository.dart';
import '../../../../utlis/loaders/loaders.dart';
import '../../models/product_attribute_model.dart';

class ProductAttributeController extends GetxController {
  static ProductAttributeController get instance => Get.find();

  final attributeRepo = Get.put(ProductAttributeRepository());

  RxList<ProductAttributeModel> attributes = <ProductAttributeModel>[].obs;

  Future<void> fetchProductAttributes(String productId) async {
    try {
      final result = await attributeRepo.fetchProductAttributes(productId);
      attributes.assignAll(result);
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
