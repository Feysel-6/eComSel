class ProductModel {
  String? id;
  String title;
  String? description;
  double price;
  double? salePrice;
  String? sku;
  int stock;
  String? thumbnail;
  String productType;
  bool isFeatured;
  String? brandId;
  Map<String, dynamic>? brand; // joined brand object
  List<String>? images; // normalized image urls
  String? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    this.id,
    required this.title,
    this.description,
    required this.price,
    this.salePrice,
    this.sku,
    this.stock = 0,
    this.thumbnail,
    required this.productType,
    this.isFeatured = false,
    this.brandId,
    this.brand,
    this.images,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'sale_price': salePrice,
      'sku': sku,
      'stock': stock,
      'thumbnail': thumbnail,
      'product_type': productType,
      'is_featured': isFeatured,
      'brand_id': brandId,
      'category_id': categoryId,
      'brand': brand, // nested brand object (optional)
      'images': images, // list of image URLs (optional)
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    }..removeWhere((_, v) => v == null); // drop nulls for cleaner payload
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    // safe parsing for numeric types
    double parseDouble(dynamic v) => v == null ? 0.0 : (v as num).toDouble();

    // brand already normalized in repository; ensure it's a Map
    Map<String, dynamic>? brand;
    final rawBrand = map['brand'];
    if (rawBrand != null) {
      if (rawBrand is Map) {
        brand = Map<String, dynamic>.from(rawBrand);
      } else if (rawBrand is List && rawBrand.isNotEmpty) {
        brand = Map<String, dynamic>.from(rawBrand[0] as Map);
      }
    }

    List<String>? images;
    if (map['images'] != null) {
      images = List<String>.from(map['images'] as List);
    } else if (map['product_images'] != null) {
      images =
          (map['product_images'] as List)
              .map((e) => e['url'] as String)
              .toList();
    }

    return ProductModel(
      id: map['id'] as String?,
      title: map['title'] ?? '',
      description: map['description'] as String?,
      price: parseDouble(map['price']),
      salePrice:
          map['sale_price'] != null ? parseDouble(map['sale_price']) : null,
      sku: map['sku'] as String?,
      stock:
          (map['stock'] is int)
              ? map['stock'] as int
              : (map['stock'] == null ? 0 : (map['stock'] as num).toInt()),
      thumbnail: map['thumbnail'] as String?,
      productType: map['product_type'] ?? '',
      isFeatured: map['is_featured'] ?? false,
      brandId: map['brand_id'] as String?,
      brand: brand,
      images: images,
      categoryId: map['category_id'] as String?,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
