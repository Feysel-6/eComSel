class BannerModel {
  String imageUrl;
  final String targetScreen;
  final bool active;

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'target_screen': targetScreen,
      'active': active,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      imageUrl: map['image'] ?? '',
      active:
          map['active'] is bool
              ? map['active'] as bool
              : map['active'].toString().toLowerCase() == 'true',
      targetScreen: map['target_screen'],
    );
  }
}
