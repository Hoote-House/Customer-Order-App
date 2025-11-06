import 'package:barista_apps/models/product.dart';

class CartEntry {
  final Product product;
  int quantity;
  final int extrasPrice;
  final String optionsSummary;
  CartEntry({
    required this.product,
    required this.quantity,
    required this.extrasPrice,
    required this.optionsSummary,
  });
}
