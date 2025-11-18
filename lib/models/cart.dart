import 'package:barista_apps/models/customization.dart';
import 'package:barista_apps/models/product.dart';
import 'package:get/get.dart';

class CartEntry {
  ProductDetail product;
  RxInt quantity;
  String note;
  RxList<CustomizationOption> customizations;
  CartEntry({
    required this.product,
    required this.quantity,
    required this.note,
    required this.customizations,
  });

  Map<String, dynamic> toMap() {
    return {
      "product_id": product.id,
      "quantity": quantity.value,
      "note": note,
      "customization": customizations.map((e) => e.id).toList(),
    };
  }
}
