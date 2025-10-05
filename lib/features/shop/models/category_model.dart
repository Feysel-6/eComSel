class CategoryModel {
  String? id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  static CategoryModel empty() =>
      CategoryModel(id: '', image: '', name: '', isFeatured: false);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'parent_id': parentId,
      'is_featured': isFeatured,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] ?? '',
      // Handle both string and bool for safety
      isFeatured:
          map['is_featured'] is bool
              ? map['is_featured'] as bool
              : map['is_featured'].toString().toLowerCase() == 'true',
      parentId: map['parent_id'] ?? '',
    );
  }
}
