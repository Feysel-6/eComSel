

class BrandModel {
  String? id;
  String name;
  String image;
  bool? isFeatured;

  BrandModel({
    this.id,
    required this.name,
    required this.image,
    this.isFeatured,
  });

  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  toJson() {
    return {'id': id, 'name': name, 'image': image, 'is_featured': isFeatured};
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] ?? '',
      isFeatured:
          map['is_featured'] as bool
              ? map['is_featured'] as bool
              : map['is_featured'].toString().toLowerCase() == 'true',
    );
  }
}
