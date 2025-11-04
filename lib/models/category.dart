import 'package:barista_apps/models/product.dart';

class ProductCategory {
  final String id;
  final String name;
  final List<Product> products;
  final bool isActive;

  ProductCategory({
    required this.id,
    required this.name,
    required this.products,
    this.isActive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'products': products
          .map(
            (p) => {
              'id': p.id,
              'name': p.name,
              'price': p.price,
              'imageUrl': p.imageUrl,
            },
          )
          .toList(),
      'isActive': isActive,
    };
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      products: (json['products'] as List<dynamic>? ?? [])
          .map(
            (item) => Product(
              item['product_id'] as String,
              item['name'] as String,
              item['price'] as int,
              item['image_url'] as String,
            ),
          )
          .toList(),
      isActive: json[''] as bool? ?? false,
    );
  }
}
