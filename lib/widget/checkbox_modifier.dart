import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/models/customization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Column checkboxModifier(
  Customization customization,
  CartController cartC,
  // int cartIdx,
) {
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Type',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      ...customization.options.map(
        (e) => CheckboxListTile(
          value: cartC.curCart.value!.customizations.contains(e),
          onChanged: (value) {
            cartC.toggleCustomization(e);
          },
        ),
      ),
    ],
  );
}
