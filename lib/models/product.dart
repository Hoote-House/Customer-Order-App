import 'package:barista_apps/models/customization.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  Product(this.id, this.name, this.price, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      other is Product &&
      other.name == name &&
      other.price == price &&
      other.imageUrl == imageUrl;

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ imageUrl.hashCode;
}

class ProductDetail {
  final String id;
  final String name;
  final String description;
  final String category;
  final int price;
  final bool isAvailable;
  final List<Customization> cutomizations;
  final String imageUrl;

  ProductDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.isAvailable,
    required this.cutomizations,
    required this.imageUrl,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category_name'] as String,
      price: json['store_price'] as int,
      isAvailable: json['is_available'] as bool? ?? true,
      cutomizations: (json['customizations'] as List<dynamic>? ?? [])
          .map((e) => Customization.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['image_url'] as String,
    );
  }
}
