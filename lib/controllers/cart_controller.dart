import 'package:barista_apps/models/cart.dart';
import 'package:barista_apps/models/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = <CartEntry>[].obs;

  var paymentSelected = "qris".obs;
  var paymentMethods = <PaymentMethod>[
    PaymentMethod(
      slug: "qris",
      label: "QRIS",
      subtitle: "Scan QRIS",
      icon: Icons.qr_code_2,
    ),
  ];

  void addCart(CartEntry entry) {
    cart.add(entry);
    update();
  }

  void clearCart() {
    cart.clear();
    update();
  }

  void setPaymentMethod(String value) {
    paymentSelected.value = value;
    update();
  }

  int getTotal() {
    int total = 0;
    for (final e in cart) {
      final int unit = e.product.price + e.extrasPrice;
      total += unit * e.quantity;
    }
    return total;
  }

  int getCount() {
    int count = 0;
    for (final e in cart) {
      count += e.quantity;
    }
    return count;
  }
}
