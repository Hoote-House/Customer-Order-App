import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/controllers/product_controller.dart';
import 'package:barista_apps/models/cart.dart';
import 'package:barista_apps/models/category.dart';
import 'package:barista_apps/models/product.dart';
import 'package:barista_apps/utils/rupiah_format.dart';
import 'package:barista_apps/widget/cart_dialog.dart';
import 'package:barista_apps/widget/product_dialog.dart';
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
  final ProductController productC = Get.find<ProductController>(
    tag: 'products',
  );

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
        body: Obx(
          () => SafeArea(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 420,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1509042239860-f550ce710b93?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=687",
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            child: Card(
                              color: Colors.white,
                              child: IconButton(
                                onPressed: () {},

                                icon: Icon(Icons.arrow_back_sharp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
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
                                    SizedBox(height: 100),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.grey[50],
                                width: 10,
                                height: 40,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (final c in productC.productsCat)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8,
                                        ),
                                        child: ChoiceChip(
                                          backgroundColor: Colors.white,
                                          selectedColor: Colors.grey[200],
                                          label: Text(c.name),
                                          selected: false,
                                          onSelected: (_) {},
                                        ),
                                      ),
                                  ],
                                ),
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
                        color: Colors.white,
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

  Widget _productCategory(
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
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: gridCross,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.05,
          children: category.products.map((p) {
            return ProductCard(
              product: p,
              onTap: () async {
                if (cartC.isOnDialog.value) return;

                cartC.isOnDialog(true);
                await productC.fetchProductDetail(id: p.id);
                if (productC.productDetail.value != null) {
                  showProductDialog(context);
                }
              },
              priceText: formatRp(p.price),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

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
      onTap: () {
        onTap();
      },
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
