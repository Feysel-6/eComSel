import 'package:ecom_sel/data/repositories/brand/brand_repository.dart';
import 'package:ecom_sel/data/repositories/product/product_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
    final products = await ProductRepository.instance.getProductForBrand(brandId: brandId);
    return products;

  }


}