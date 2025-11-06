import 'package:barista_apps/models/customization.dart';
import 'package:barista_apps/models/product.dart';

class CartEntry {
  ProductDetail product;
  int quantity;
  String note;
  List<CustomizationOption> customizations;
  CartEntry({
    required this.product,
    required this.quantity,
    required this.note,
    required this.customizations,
  });

  Map<String, dynamic> toMap() {
    return {
      "product_id": product.id,
      "quantity": quantity,
      "note": note,
      "customization": customizations.map((e) => e.id).toList(),
    };
  }
}
