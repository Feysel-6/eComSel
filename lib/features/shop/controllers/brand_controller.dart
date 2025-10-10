import 'package:ecom_sel/data/repositories/brand/brand_repository.dart';
import 'package:ecom_sel/data/repositories/product/product_repository.dart';
import 'package:ecom_sel/utlis/loaders/loaders.dart';
import 'package:get/get.dart';

import '../models/brand_model.dart';
import '../models/product_model.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  final brandRepository = Get.put(BrandRepository());
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getFeaturedBrands();
  }

  Future<void> getFeaturedBrands() async {
    try{
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(
        allBrands.where(
              (brand) => brand.isFeatured ?? false
        ).take(8).toList(),
      );
    }catch(e){
      throw('Something went wrong');
    }finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    final products = await ProductRepository.instance.fetchProductForBrand(brandId: brandId);
    return products;

  }

  Future<List<BrandModel>> getBrandCategory(String categoryId) async {
    try{
      final brands = await brandRepository.fetchBrandsForCategory(categoryId);
      return brands;
    }catch(e){
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }


}