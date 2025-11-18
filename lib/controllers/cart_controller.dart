import 'package:barista_apps/models/cart.dart';
import 'package:barista_apps/models/customization.dart';
import 'package:barista_apps/models/payment_method.dart';
import 'package:barista_apps/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = <CartEntry>[].obs;
  var curCart = Rxn<CartEntry>();
  var isOnDialog = false.obs;

  var paymentSelected = "qris".obs;
  var paymentMethods = <PaymentMethod>[
    PaymentMethod(
      slug: "qris",
      label: "QRIS",
      subtitle: "Scan QRIS",
      icon: Icons.qr_code_2,
    ),
  ];

  void toggleCustomization(CustomizationOption? option) {
    if (option == null) return;
    final cart = curCart.value!;

    var exist = cart.customizations.indexOf(option);
    if (exist != -1) {
      cart.customizations.remove(option);
    } else {
      cart.customizations.add(option);
    }
    update();
  }

  void newCartEntry(ProductDetail product) {
    curCart.value = CartEntry(
      product: product,
      quantity: 1.obs,
      note: "",
      customizations: <CustomizationOption>[].obs,
    );
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
    int total = 0;

    for (final e in cart) {
      final addedPrice = e.customizations.fold(0, (v, e) => v + e.price);
      final unit = e.product.price + addedPrice;
      final qty = e.quantity.value;
      total += unit * qty;
    }
    return total;
  }

  int getITotal(CartEntry entry) {
    int total = 0;

    final addedPrice = entry.customizations.fold(0, (v, e) => v + e.price);
    final unit = entry.product.price + addedPrice;

    total += unit * entry.quantity.value;
    return total;
  }

  int getCurTotal() {
    int total = 0;

    final addedPrice = curCart.value!.customizations.fold(
      0,
      (v, e) => v + e.price,
    );
    final unit = curCart.value!.product.price + addedPrice;

    total += unit * curCart.value!.quantity.value;
    return total;
  }

  int getCount() {
    int count = 0;
    for (final e in cart) {
      count += e.quantity.value;
    }
    return count;
  }

  void increaseQty(int idx) {
    cart[idx].quantity.value++;
    update();
  }

  void decreaseQty(int idx) {
    if (cart[idx].quantity <= 1) return;

    cart[idx].quantity.value--;
    update();
  }

  void increaseCurQty() {
    curCart.value!.quantity.value++;
    print("${curCart.value!.quantity}");
    update();
  }

  void decreaseCurQty() {
    if (curCart.value!.quantity <= 1) return;

    curCart.value!.quantity.value--;
    update();
  }
}
