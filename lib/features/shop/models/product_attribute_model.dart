class ProductAttributeModel {
  String? id;
  String productId;
  String? name;
  List<String>? values;

  ProductAttributeModel({
    this.id,
    required this.productId,
    this.name,
    this.values,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'values': values, // List<String> is automatically handled as JSONB
    };
  }

  factory ProductAttributeModel.fromMap(Map<String, dynamic> map) {
    return ProductAttributeModel(
      id: map['id'] as String?,
      productId: map['product_id'] as String,
      name: map['name'] as String?,
      values: (map['values'] as List?)?.map((v) => v.toString()).toList(),
    );
  }
}
