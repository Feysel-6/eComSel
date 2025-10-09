class ProductVariationModel {
  String? id;
  String productId;
  String image;
  String? description;
  double price;
  double? salePrice;
  int stock;
  Map<String, dynamic> attributeValues;

  ProductVariationModel({
    this.id,
    required this.productId,
    this.image = '',
    this.description,
    this.price = 0.0,
    this.salePrice,
    this.stock = 0,
    required this.attributeValues,
  });

  factory ProductVariationModel.empty() => ProductVariationModel(
    id: '',
    price: 0.0,
    salePrice: 0.0,
    stock: 0,
    image: '',
    description: '',
    attributeValues: {}, productId: '',
  );


  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'image': image,
      'description': description,
      'price': price,
      'sale_price': salePrice,
      'stock': stock,
      'attribute_values': attributeValues, // Supabase jsonb
    };
  }

  factory ProductVariationModel.fromMap(Map<String, dynamic> map) {
    return ProductVariationModel(
      id: map['id'] as String?,
      productId: map['product_id'] as String,
      image: map['image'] ?? '',
      description: map['description'],
      price: (map['price'] as num).toDouble(),
      salePrice: map['sale_price'] != null ? (map['sale_price'] as num).toDouble() : null,
      stock: map['stock'] ?? 0,
      attributeValues: Map<String, dynamic>.from(map['attribute_values'] ?? {}),
    );
  }
}
