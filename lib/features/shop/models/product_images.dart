class ProductImagesModel {
  String? id;
  String productId;
  String url;
  int position;

  ProductImagesModel({
    this.id,
    required this.productId,
    required this.url,
    required this.position,
  });

  toJson() {
    return {
      'id': id,
      'product_id': productId,
      'url': url,
      'position': position,
    };
  }

  factory ProductImagesModel.fromMap(Map<String, dynamic> map) {
    return ProductImagesModel(
      id: map['id'] as String,
      productId: map['product_id'] as String,
      url: map['url'] as String,
      position: map['position'] as int,
    );
  }

}