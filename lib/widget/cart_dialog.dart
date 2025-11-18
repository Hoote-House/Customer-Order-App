import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/models/cart.dart';
import 'package:barista_apps/utils/rupiah_format.dart';
import 'package:barista_apps/widget/payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showCartDialog(BuildContext context) {
  var cartC = Get.find<CartController>(tag: 'cart');
  var cart = cartC.cart;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Obx(() {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Container(
            width: 430,
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.clear, color: Colors.red, size: 18),
                    GestureDetector(
                      onTap: () {
                        cartC.clearCart();
                      },
                      child: Text(
                        ' Clear',
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (cart.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      'Empty Cart',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  )
                else
                  Obx(
                    () => Column(
                      children: [
                        ...cart.asMap().entries.map((entry) {
                          int idx = entry.key;
                          CartEntry e = entry.value;
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    e.product.imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.brown[200],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.product.name,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        formatRp(cartC.getITotal(e)),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            cartC.increaseQty(idx);
                                          },
                                          iconSize: 24,
                                          padding: EdgeInsets.zero,
                                        ),
                                        Text(
                                          e.quantity.value.toString(),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                          onPressed: () =>
                                              cartC.decreaseQty(idx),
                                          iconSize: 24,
                                          padding: EdgeInsets.zero,
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () => cartC.removeCart(idx),
                                      tooltip: 'Remove',
                                      iconSize: 20,
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      formatRp(cartC.getTotal()),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: cart.isEmpty
                        ? null
                        : () {
                            // Order action here
                            Navigator.pop(context);
                            showPaymentDialog(context, cartC.getTotal());
                          },
                    child: Text(
                      'ORDER',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
