import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/models/customization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';

Column radioModifier(
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
        (e) => ListTile(
          title: Text(e.label),
          leading: Radio<CustomizationOption>(value: e),
        ),
      ),
    ],
  );
}
