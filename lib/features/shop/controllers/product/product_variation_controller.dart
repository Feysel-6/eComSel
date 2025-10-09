import 'package:ecom_sel/features/shop/controllers/product/product_images_controller.dart';
import 'package:ecom_sel/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_variation_repository.dart';
import '../../../../utlis/loaders/loaders.dart';
import '../../models/product_model.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController get instance => Get.find();

  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  // ... in ProductController

// Add this state variable
  RxList<ProductVariationModel> productVariations = <ProductVariationModel>[].obs;

// You'll need the repository
  final productVariationRepository = Get.put(ProductVariationRepository());

// Add the fetch method
  void fetchProductVariations(String productId) async {
    try {
      // You might want to show a loading state for this specific product detail screen
      // but for now, we'll keep it simple.

      final variations = await productVariationRepository.getProductVariations(productId);
      productVariations.assignAll(variations);

    } catch(e) {
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: 'Failed to load product variations: ${e.toString()}');
    }
  }

  void onAttributeSelected(
      ProductModel product,
      attributeName,
      attributeValue,
      // Change the type of this parameter
      List<ProductVariationModel> variations,
      ) {
    final selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    // Now you can call firstWhere on 'variations'
    final selectedVariation = variations.firstWhere(
          (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );
    if (selectedVariation.image.isNotEmpty) {
      ProductImagesController.instance.selectedImage.value =
          selectedVariation.image;
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
    final price = variation.salePrice ?? variation.price ?? 0.0;
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

  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName){
    final availableVariationAttributeValue = variations
        .where((variation) =>
    variation.attributeValues[attributeName] != null &&
        variation.attributeValues[attributeName]!.isNotEmpty &&
        variation.stock > 0)
    // Cast the mapped value to String?
        .map((variation) => variation.attributeValues[attributeName] as String?)
        .toSet();
    return availableVariationAttributeValue;
  }

}
