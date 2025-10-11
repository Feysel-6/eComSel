import 'dart:convert';

import 'package:ecom_sel/data/repositories/product/product_repository.dart';
import 'package:ecom_sel/utlis/loaders/loaders.dart';
import 'package:ecom_sel/utlis/local_storage/storage_utility.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  Future<void> initFavorites() async {
    final json = ELocalStorage.instance().readData('favorites');
    if(json != null){
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value)));
    }
  }

  bool isFavourite(String productId){
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if(!favorites.containsKey(productId)){
      favorites[productId] = true;
      saveFavoritesToStorage();
      ELoaders.customToast(message: 'Product has been added to the wishlist.');
    } else {
      ELocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      ELoaders.customToast(message: 'Product has been removed from the wishlist.');
    }
  }

  void saveFavoritesToStorage() {
    final encodeFavorites = json.encode(favorites);
    ELocalStorage.instance().saveData('favorites', encodeFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.fetchFavouriteProducts(favorites.keys.toList());
  }
}