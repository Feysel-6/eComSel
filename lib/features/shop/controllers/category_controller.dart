import 'package:ecom_sel/data/repositories/categories/category_repository.dart';
import 'package:ecom_sel/features/shop/models/category_model.dart';
import 'package:ecom_sel/utlis/loaders/loaders.dart';
import 'package:get/get.dart';


class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
  
  Future<List<CategoryModel>> getSubCategories( String categoryId) async {
    try{
      final subCategories = await _categoryRepository.fetchSubCategories(categoryId);
      return subCategories;

    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<void> getCategories() async {
    try {
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);
      featuredCategories.assignAll(
        allCategories.where(
          (category) => category.isFeatured && category.parentId.isEmpty,
        ).take(8).toList(),
      );
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
