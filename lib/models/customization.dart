class Customization {
  final String id;
  final String name;
  final int sortOrder;
  final String description;
  final bool isRequired;
  final int maxSelection;
  final int minSelection;
  final List<CustomizationOption> options;

  Customization({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.description,
    required this.isRequired,
    required this.maxSelection,
    required this.minSelection,
    required this.options,
  });

  factory Customization.fromJson(Map<String, dynamic> json) {
    return Customization(
      id: json['group_id'] as String,
      name: json['group_name'] as String,
      sortOrder: json['sort_order'] as int,
      description: json['description'] as String? ?? '',
      isRequired: json['is_required'] as bool? ?? false,
      maxSelection: json['max_selection'] as int? ?? 0,
      minSelection: json['min_selection'] as int? ?? 0,
      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => CustomizationOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CustomizationOption {
  final String id;
  final String label;
  final bool isDefault;
  final int sortOrder;
  final int price;
  final bool isAvailable;

  CustomizationOption({
    required this.id,
    required this.label,
    required this.isDefault,
    required this.sortOrder,
    required this.price,
    required this.isAvailable,
  });

  factory CustomizationOption.fromJson(Map<String, dynamic> json) {
    return CustomizationOption(
      id: json['option_id'] as String,
      label: json['label'] as String,
      isDefault: json['is_default'] as bool? ?? false,
      sortOrder: json['sort_order'] as int? ?? 0,
      price: json['store_price'] as int,
      isAvailable: json['is_available'] as bool? ?? true,
    );
  }
}
