import 'package:ecom_sel/features/shop/controllers/product/product_images_controller.dart';
import 'package:ecom_sel/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_variation_repository.dart';
import '../../../../utlis/loaders/loaders.dart';
import '../../models/product_model.dart';
import '../cart_controller.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController get instance => Get.find();

  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

  final productVariationRepository = Get.put(ProductVariationRepository());

  void fetchProductVariations(String productId) async {
    try {
      final variations = await productVariationRepository.getProductVariations(
        productId,
      );
      productVariations.assignAll(variations);
    } catch (e) {
      ELoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Failed to load product variations: ${e.toString()}',
      );
    }
  }

  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,

    List<ProductVariationModel> variations,
  ) {
    final selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = variations.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );
    if (selectedVariation.image.isNotEmpty) {
      ProductImagesController.instance.selectedImage.value =
          selectedVariation.image;
    }

    if (selectedVariation.id!.isEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(selectedVariation.id!, product.id!);
    }

    this.selectedVariation.value = selectedVariation;
    getProductVariationStockStatus();
  }

  bool _isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    for (final key in selectedAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  String getVariationPrice() {
    final variation = selectedVariation.value;
    final price = variation.salePrice ?? variation.price;
    return price.toString();
  }

  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    final availableVariationAttributeValue =
        variations
            .where(
              (variation) =>
                  variation.attributeValues[attributeName] != null &&
                  variation.attributeValues[attributeName]!.isNotEmpty &&
                  variation.stock > 0,
            )
            .map(
              (variation) =>
                  variation.attributeValues[attributeName] as String?,
            )
            .toSet();
    return availableVariationAttributeValue;
  }
}
