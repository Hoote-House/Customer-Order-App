import 'package:flutter/material.dart';

class PaymentMethod {
  final String slug, label, subtitle;
  final IconData icon;

  PaymentMethod({
    required this.slug,
    required this.label,
    required this.subtitle,
    required this.icon,
  });
}
