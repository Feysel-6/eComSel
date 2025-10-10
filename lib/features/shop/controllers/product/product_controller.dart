import 'package:ecom_sel/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utlis/constants/enums.dart';
import '../../../../utlis/loaders/loaders.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try{
      isLoading.value = true;
      final products = await productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
    }catch(e){
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try{
      final products = await productRepository.getFeaturedProducts();
      return products;
    }catch(e){
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  String getProductPrice(ProductModel product, List<ProductVariationModel> variations) {
    // --- Single Product Logic ---
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice != null && product.salePrice! > 0
          ? product.salePrice
          : product.price)?.toString() ?? '0.0'; // Added null-aware operator and default '0.0'
    }

    // --- Variable Product Logic ---
    else {
      // 1. Check if the variations list is empty. If so, return a default price.
      if (variations.isEmpty) {
        return (product.price).toString(); // Fallback to base product price or '0.0'
      }

      double smallestPrice = double.infinity;
      double largestPrice = 0.0;
      bool foundValidPrice = false; // Flag to check if we actually found a price

      for (var variation in variations) {
        // Use null-aware operators to safely get the price, defaulting to 0.0 if both are null
        double priceToConsider = (variation.salePrice != null && variation.salePrice! > 0)
            ? variation.salePrice!
            : (variation.price);

        // Only proceed if the price is greater than 0
        if (priceToConsider > 0.0) {
          foundValidPrice = true;

          if (priceToConsider < smallestPrice) {
            smallestPrice = priceToConsider;
          }

          if (priceToConsider > largestPrice) {
            largestPrice = priceToConsider;
          }
        }
      }

      // 2. Check the flag before returning the range
      if (!foundValidPrice) {
        // If no valid price was found in any variation, return a default value
        return (product.price).toString();
      }

      // 3. Return the range (now guaranteed to have valid numbers)
      if (smallestPrice == largestPrice) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - $largestPrice';
      }
    }
  }


  String? calculateSalePercentage(double originalPrice, double? salePrice){
    if(salePrice == null || salePrice <= 0.0) return null;
    if(originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return '${percentage.toStringAsFixed(0)}%';
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
 }