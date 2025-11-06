import 'package:barista_apps/models/cart.dart';
import 'package:barista_apps/models/customization.dart';
import 'package:barista_apps/models/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = <CartEntry>[].obs;
  var curCart = Rxn<CartEntry>();

  var paymentSelected = "qris".obs;
  var paymentMethods = <PaymentMethod>[
    PaymentMethod(
      slug: "qris",
      label: "QRIS",
      subtitle: "Scan QRIS",
      icon: Icons.qr_code_2,
    ),
  ];

  void toggleCustomization(CustomizationOption option) {
    final cart = curCart.value!;

    var exist = cart.customizations.indexOf(option);
    if (exist != -1) {
      cart.customizations.remove(option);
    } else {
      cart.customizations.add(option);
    }

    update();
  }

  void editNote(String value) {
    curCart.value!.note = value;
    update();
  }

  void addCart(CartEntry entry) {
    cart.add(entry);
    update();
  }

  void removeCart(int entry) {
    cart.removeAt(entry);
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
    double total = 0;

    for (final e in cart) {
      final addedPrice = e.customizations.fold(0.0, (v, e) => v + e.price);
      final unit = e.product.price + addedPrice;
      total += unit * e.quantity;
    }
    return total as int;
  }

  int getCount() {
    int count = 0;
    for (final e in cart) {
      count += e.quantity;
    }
    return count;
  }

  void increaseQty(int idx) {
    cart[idx].quantity--;
    update();
  }

  void decreaseQty(int idx) {
    cart[idx].quantity--;
    update();
  }

  void increaseCurQty() {
    curCart.value!.quantity--;
    update();
  }

  void decreaseCurQty() {
    if (curCart.value!.quantity < 1) return;

    curCart.value!.quantity--;
    update();
  }
}
