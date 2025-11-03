import 'package:ecom_sel/features/shop/controllers/product/product_variation_controller.dart';
import 'package:ecom_sel/utlis/constants/enums.dart';
import 'package:ecom_sel/utlis/loaders/loaders.dart';
import 'package:get/get.dart';

import '../../../../utlis/local_storage/storage_utility.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = ProductVariationController.instance;

  CartController(){
    loadCartItem();
  }

  void addToCart(ProductModel product) {
    if (productQuantityInCart.value < 1) {
      ELoaders.customToast(message: 'Select Something Bro!');
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id!.isEmpty) {
      ELoaders.customToast(message: 'Select Variation');
      return;
    }

    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        ELoaders.warningSnackBar(
          title: 'Oh Snap',
          message: 'Selected variation is out of stock.',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        ELoaders.warningSnackBar(
          title: 'Oh snap!',
          message: 'Selected Product is out of stock.',
        );
        return;
      }
    }

    final selectedCardItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );

    int index = cartItems.indexWhere(
      (item) =>
          item.productId == selectedCardItem.productId &&
          item.variationId == selectedCardItem.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity = selectedCardItem.quantity;
    } else {
      cartItems.add(selectedCardItem);
    }

    updateCart();
    ELoaders.customToast(message: 'Your product has been added to the Cart');
  }

  void addOneToCart(CartItemModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);
    if(index >= 0){
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
          (cartItem) =>
      cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        removeFromCartDialog(index);
      }
    }

    updateCart();
  }


  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id!.isNotEmpty;
    final price =
        isVariation
            ? variation.salePrice! > 0.0
                ? variation.salePrice
                : variation.price
            : product.salePrice! > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id!,
      quantity: quantity,
      price: price!,
      variationId: variation.id!,
      image: isVariation ? variation.image : product.thumbnail,
      title: product.title,
      brandName: product.brand != null ? product.brand!['name'] : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += item.price * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculateNoOfItems;
  }

  void saveCartItems() {
    final cartItemsString = cartItems.map((item) => item.toJson()).toList();
    ELocalStorage.instance().saveData('cartItems', cartItemsString);
  }

  void loadCartItem() {
    final cartItemsString = ELocalStorage.instance().readData<List<dynamic>>(
      'cartItems',
    );
    if (cartItemsString != null) {
      cartItems.assignAll(
        cartItemsString
            .map((item) => CartItemModel.fromMap(item as Map<String, dynamic>))
            .toList(),
      );
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foudItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foudItem;
  }

  int getVariationQuantityInCart(String variationId, String productId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.variationId == variationId && item.productId == productId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

  void clearCart(){
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: (){
        cartItems.removeAt(index);
        updateCart();
        ELoaders.customToast(message: 'Product Removed');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  void updateExistingProductCount(ProductModel product){
    if(product.productType == ProductType.single.toString()){
      productQuantityInCart.value = getProductQuantityInCart(product.id!);
    } else{
      final variationId = variationController.selectedVariation.value.id!;
      if (variationId.isNotEmpty){
        productQuantityInCart.value = getVariationQuantityInCart(variationId, product.id!);
      } else{
        productQuantityInCart.value = 0;
      }
    }
  }
}
