import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/controllers/product_controller.dart';
import 'package:barista_apps/models/cart.dart';
import 'package:barista_apps/models/category.dart';
import 'package:barista_apps/models/product.dart';
import 'package:barista_apps/utils/rupiah_format.dart';
import 'package:barista_apps/widget/cart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartController cartC = Get.find<CartController>(tag: 'cart');
  final ProductController productC = Get.find<ProductController>(tag: 'device');

  // Data produk contoh dengan imageUrl
  final List<Product> allProducts = [
    Product(
      "test-21312",
      'Cappucino',
      25000,
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrel6xiovhaELr1f--k2jCl7tUC9i2hLsfAA&s',
    ),
    Product(
      "test-31231",
      'Espresso Matcha',
      25000,
      'https://images.unsplash.com/photo-1541167760496-1628856ab772?q=80&w=800&auto=format&fit=crop',
    ),
    // Product(
    //   'Latte',
    //   28000,
    //   'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=800&auto=format&fit=crop',
    // ),
    // Product(
    //   'Mocha',
    //   30000,
    //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOCj_gHGzcoR4OYogtn-3igpzgFB-oFUJqDQ&s',
    // ),
    // Product(
    //   'Americano',
    //   22000,
    //   'https://majestycoffee.com/cdn/shop/articles/americano_b74a8154-454b-4f74-9a6c-95fbc4152ed3_800x.jpg?v=1684048195',
    // ),
    // Product(
    //   'Macchiato',
    //   30000,
    //   'https://i.pinimg.com/736x/6a/34/66/6a3466c5c42f898b0f23889ca62b6724.jpg',
    // ),
    // Product(
    //   'Flat White',
    //   27000,
    //   'https://i.pinimg.com/736x/51/22/61/5122619a7d0b5f44db9481b752f1aa10.jpg',
    // ),
    // Product(
    //   'Affogato',
    //   33000,
    //   'https://i0.wp.com/cookingitalians.com/wp-content/uploads/2024/07/img-RDN4ZfjtP5hB22jQgDlEB.jpeg?fit=250%2C250&ssl=1',
    // ),
    // Product(
    //   'Cortado',
    //   26000,
    //   'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQGGBpg6ycflPRFjBIagD5UAakrYVNcKA2j6RFnZkHTH4-zjj4JCJHskRmwyH0vawvoP_3YWkCm',
    // ),
  ];

  int gridCountForWidth(double width) {
    if (width >= 1050) return 3;
    if (width >= 800) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 800;
    final int gridCross = gridCountForWidth(size.width);

    final categories = productC.productsCat;
    final List<CartEntry> cart = cartC.cart;

    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          titleTextStyle: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Obx(
            () => Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isTablet)
                      Container(
                        width: 220,
                        padding: const EdgeInsets.all(12),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Category',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (final c in categories.asMap().entries)
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: c.value.name == c.key
                                            ? Colors.brown[50]
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(c.value.name),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 24 : 12,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...categories.map(
                              (category) => _productCategory(
                                gridCross,
                                category,
                                context,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: isTablet ? 520 : size.width * 0.95,
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      formatRp(cartC.getTotal()),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: isTablet ? 200 : 120,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showCartDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.brown[700],
                                  ),
                                  child: Text(
                                    'Cart (${cartC.getCount()})',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _productCategory(
    int gridCross,
    ProductCategory category,
    BuildContext context,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // if (!isTablet)
            //   Expanded(
            //     child: SizedBox(
            //       height: 40,
            //       child: ListView(
            //         scrollDirection: Axis.horizontal,
            //         children: [
            //           for (final c in categories)
            //             Padding(
            //               padding: const EdgeInsets.only(
            //                 right: 8,
            //               ),
            //               child: ChoiceChip(
            //                 label: Text(c.name),
            //                 selected: c.name == selectedCategory,
            //                 onSelected: (_) => setState(
            //                   () => selectedCategory = c.name,
            //                 ),
            //               ),
            //             ),
            //         ],
            //       ),
            //     ),
            //   ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 12),
        // Grid produk
        Expanded(
          child: GridView.count(
            crossAxisCount: gridCross,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.05,
            children: category.products.map((p) {
              return ProductCard(
                product: p,
                onTap: () => showProductDialog(context, p),
                priceText: formatRp(p.price),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Tampilkan dialog produk (stateful di dalam showDialog)
  void showProductDialog(BuildContext context, Product product) {
    // options data
    final milkOptions = [
      OptionItem('Dairy', 0),
      OptionItem('Oat', 15000),
      OptionItem('Soy', 12000),
    ];
    final addOns = [
      OptionItem('Espresso +1 shot', 5000),
      OptionItem('Espresso +2 shot', 9000),
      OptionItem('Sugar', 0),
    ];

    showDialog(
      context: context,
      builder: (ctx) {
        String type = 'Hot';
        String icedLevel = 'Normal';
        OptionItem selectedMilk = milkOptions[0];
        final Set<OptionItem> selectedAdds = {};
        int quantity = 1;

        int computeExtras() {
          int sum = 0;
          sum += selectedMilk.price;
          for (final a in selectedAdds) {
            sum += a.price;
          }
          return sum;
        }

        return StatefulBuilder(
          builder: (context, setState) {
            final int extras = computeExtras();
            final int subtotalPerUnit = product.price + extras;
            final int total = subtotalPerUnit * quantity;

            String customersNotes = '';

            return Dialog(
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Type',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Hot',
                            groupValue: type,
                            onChanged: (v) => setState(() => type = v ?? 'Hot'),
                          ),
                          Text('Hot'),
                          const SizedBox(width: 16),
                          Radio<String>(
                            value: 'Iced',
                            groupValue: type,
                            onChanged: (v) =>
                                setState(() => type = v ?? 'Iced'),
                          ),
                          Text('Iced'),
                        ],
                      ),
                      const Divider(),
                      if (type == 'Iced') ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Iced Type',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Less',
                              groupValue: icedLevel,
                              onChanged: (v) =>
                                  setState(() => icedLevel = v ?? 'Less'),
                            ),
                            Text('Less'),
                            const SizedBox(width: 8),
                            Radio<String>(
                              value: 'Normal',
                              groupValue: icedLevel,
                              onChanged: (v) =>
                                  setState(() => icedLevel = v ?? 'Normal'),
                            ),
                            Text('Normal'),
                            const SizedBox(width: 8),
                            Radio<String>(
                              value: 'More',
                              groupValue: icedLevel,
                              onChanged: (v) =>
                                  setState(() => icedLevel = v ?? 'More'),
                            ),
                            Text('More'),
                          ],
                        ),
                        const Divider(),
                      ],
                      // Milk radio
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Milk',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Column(
                        children: milkOptions.map((m) {
                          return RadioListTile<OptionItem>(
                            value: m,
                            groupValue: selectedMilk,
                            title: Row(
                              children: [
                                Text(m.title),
                                Spacer(),
                                if (m.price > 0)
                                  Text(
                                    '+ ${formatRp(m.price)}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                    ),
                                  ),
                              ],
                            ),
                            onChanged: (v) => setState(
                              () => selectedMilk = v ?? milkOptions[0],
                            ),
                          );
                        }).toList(),
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Add',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Column(
                        children: addOns.map((a) {
                          return CheckboxListTile(
                            value: selectedAdds.contains(a),
                            onChanged: (v) {
                              setState(() {
                                if (v == true) {
                                  selectedAdds.add(a);
                                } else {
                                  selectedAdds.remove(a);
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Row(
                              children: [
                                Text(a.title),
                                Spacer(),
                                if (a.price > 0)
                                  Text(
                                    '+ ${formatRp(a.price)}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Additional Notes',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            customersNotes = value;
                          });
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
                                formatRp(total),
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
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.red,
                                      ),
                                      onPressed: quantity > 1
                                          ? () => setState(() => quantity--)
                                          : null,
                                    ),
                                    Text(
                                      '$quantity',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.green,
                                      ),
                                      onPressed: () =>
                                          setState(() => quantity++),
                                    ),
                                  ],
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
                            // build options summary
                            final opts = [
                              'Type: $type',
                              if (type == 'Iced') 'Iced: $icedLevel',
                              'Milk: ${selectedMilk.title}',
                              if (selectedAdds.isNotEmpty)
                                'Add: ${selectedAdds.map((e) => e.title).join(', ')}',
                              if (customersNotes.isNotEmpty)
                                'Notes: $customersNotes',
                            ].join(' • ');
                            final entry = CartEntry(
                              product: product,
                              quantity: quantity,
                              extrasPrice: extras,
                              optionsSummary: opts,
                            );
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
          },
        );
      },
    );
  }
}

// Pilihan dengan harga
class OptionItem {
  final String title;
  final int price;
  OptionItem(this.title, this.price);

  @override
  bool operator ==(Object other) =>
      other is OptionItem && other.title == title && other.price == price;
  @override
  int get hashCode => title.hashCode ^ price.hashCode;
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final String priceText;
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.priceText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: Colors.brown[200]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(priceText, style: GoogleFonts.poppins()),
            ],
          ),
        ),
      ),
    );
  }
}
