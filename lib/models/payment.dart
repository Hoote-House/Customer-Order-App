import 'package:barista_apps/models/cart.dart';

typedef Request = Map<String, dynamic>;

class PaymentResponse {
  String qris;
  String gopay;

  PaymentResponse({this.qris = "", this.gopay = ""});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      qris: json['qris'] ?? "",
      gopay: json['gopay'] ?? "",
    );
  }
}

class PaymentRequest {
  String paymentMethod;
  List<CartEntry> items;

  PaymentRequest({this.paymentMethod = "qris", required this.items});

  Request toMap() {
    return {
      "payment_method": paymentMethod,
      "items": items.map((e) => e.toMap()).toList(),
    };
  }
}
