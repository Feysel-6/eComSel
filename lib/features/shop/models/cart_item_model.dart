class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, dynamic>? selectedVariation;

  CartItemModel({
    required this.productId,
    this.title = '',
    this.price = 0.0,
    this.image,
    required this.quantity,
    this.variationId = '',
    this.brandName,
    this.selectedVariation,
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variation_id': variationId,
      'brand_name': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['product_id'],
      title: map['title'],
      price: map['price']?.toDouble(),
      image: map['image'],
      quantity: map['quantity'],
      variationId: map['variation_id'],
      brandName: map['brand_name'],
      selectedVariation:
          map['selectedVariation'] != null
              ? Map<String, String>.from(map['selectedVariation'])
              : null,
    );
  }
}
