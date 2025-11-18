import 'package:barista_apps/controllers/payment_controller.dart';
import 'package:barista_apps/utils/rupiah_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showQrisBarcodeDialog(
  BuildContext context,
  int total,
  VoidCallback onPaymentSuccess,
) {
  PaymentController paymentC = Get.find<PaymentController>(tag: 'payment');

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return Obx(() {
        if (paymentC.isPaid.value) {
          (() async {
            await Future.delayed(Duration(seconds: 1));
            Navigator.of(context).pop();
            paymentC.isPaid(false);
            onPaymentSuccess();
          })();
        }

        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Scan QRIS',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.brown[100]!),
                    ),
                    child: Center(
                      child: paymentC.isLoading.value || paymentC.isPaid.value
                          ? !paymentC.isPaid.value
                                ? CircularProgressIndicator()
                                : Icon(
                                    Icons.check_circle,
                                    color: Colors.green[700],
                                    size: 80,
                                  )
                          : Image.network(
                              paymentC.qris.value,
                              width: 160,
                              height: 160,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.qr_code,
                                size: 80,
                                color: Colors.brown[300],
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Total: ${formatRp(total)}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Show this QR code to your payment app.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
