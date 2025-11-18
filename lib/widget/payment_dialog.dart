import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/controllers/payment_controller.dart';
import 'package:barista_apps/models/payment_method.dart';
import 'package:barista_apps/utils/rupiah_format.dart';
import 'package:barista_apps/widget/qris_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showPaymentDialog(BuildContext context, int total) {
  final cartC = Get.find<CartController>(tag: 'cart');
  final paymentC = Get.find<PaymentController>(tag: 'payment');
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
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Payment',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Payment Method',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ...cartC.paymentMethods.map(
                  (method) => _paymentCard(method, cartC),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      formatRp(total),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.payment, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      paymentC.requestPayment();
                      switch (cartC.paymentSelected.value) {
                        case "qris":
                          showQrisBarcodeDialog(context, total, () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Payment successful!',
                                  style: GoogleFonts.poppins(),
                                ),
                                backgroundColor: Colors.green[700],
                              ),
                            );
                            cartC.clearCart();
                          });
                      }
                    },
                    label: Text(
                      'Pay',
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

Card _paymentCard(PaymentMethod payment, CartController cartC) {
  return Card(
    color: cartC.paymentSelected.value == payment.slug
        ? Colors.brown[50]
        : Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      leading: Icon(Icons.qr_code, color: Colors.brown[700]),
      title: Text(
        payment.label,
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        payment.subtitle,
        style: GoogleFonts.poppins(fontSize: 13),
      ),
      trailing: RadioGroup<String>(
        groupValue: cartC.paymentSelected.value,
        onChanged: (v) => cartC.paymentSelected.value = v ?? 'QRIS',
        child: Text(payment.label),
      ),
      onTap: () {
        cartC.setPaymentMethod(payment.slug);
      },
    ),
  );
}
