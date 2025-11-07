import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/models/customization.dart';
import 'package:barista_apps/utils/rupiah_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';

Widget radioModifier(
  Customization customization,
  CartController cartC,
  // int cartIdx,
) {
  var option = Rxn<CustomizationOption>();
  return Obx(
    () => Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            customization.name,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
        ),
        RadioGroup<CustomizationOption>(
          groupValue: option.value,
          onChanged: (CustomizationOption? value) {
            cartC.toggleCustomization(option.value);
            option.value = value!;
            cartC.toggleCustomization(value);
            print(
              cartC.curCart.value!.customizations.map((e) => e.label).toList(),
            );
          },
          child: Column(
            children: [
              ...customization.options.map(
                (e) => ListTile(
                  title: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Text(e.label),
                      Text(e.price != 0 ? "+${formatRp(e.price)}" : ""),
                    ],
                  ),
                  leading: Radio<CustomizationOption>(value: e),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
