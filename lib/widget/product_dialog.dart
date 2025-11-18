import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/controllers/product_controller.dart';
import 'package:barista_apps/utils/rupiah_format.dart';
import 'package:barista_apps/widget/checkbox_modifier.dart';
import 'package:barista_apps/widget/radio_modifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showProductDialog(BuildContext context) {
  final CartController cartC = Get.find<CartController>(tag: 'cart');
  final ProductController productC = Get.find<ProductController>(
    tag: 'products',
  );
  var firstLoad = false.obs;
  showDialog(
    context: context,
    builder: (ctx) {
      return Obx(() {
        if (productC.isDetailLoad.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (productC.productDetail.value != null) {
          final product = productC.productDetail.value!;
          if (!firstLoad.value) {
            cartC.newCartEntry(product);
          }

          firstLoad(true);
          final curCart = cartC.curCart.value!;

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 120,
                              height: 120,
                              color: Colors.brown[200],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatRp(product.price),
                                style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...product.cutomizations.map(
                      (e) => e.maxSelection == 1
                          ? radioModifier(e, cartC)
                          : checkboxModifier(e, cartC),
                    ),
                    const Divider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Notes',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      onChanged: (value) {
                        cartC.editNote(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'e.g., Less sugar, No ice, Extra hot, etc.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              formatRp(cartC.getCurTotal()),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // quantity controls
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green[50],
                              ),
                              child: Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        cartC.decreaseCurQty();
                                      },
                                    ),
                                    Text(
                                      curCart.quantity.value.toString(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        cartC.increaseCurQty();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Add to order button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                        ),
                        onPressed: () {
                          var entry = curCart;
                          cartC.addCart(entry);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Add to Cart',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(child: Text("Can't Load"));
      });
    },
  ).then((_) {
    cartC.isOnDialog(false);
  });
}
