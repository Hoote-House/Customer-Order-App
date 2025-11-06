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
  final option = customization.options[0].obs;
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Type',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      RadioGroup<CustomizationOption>(
        groupValue: option.value,
        onChanged: (CustomizationOption? value) {
          option.value = value!;
          cartC.toggleCustomization(value);
        },
        child: Column(
          children: [
            ...customization.options.map(
              (e) => ListTile(
                title: Text(e.label),
                leading: Radio<CustomizationOption>(value: e),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
