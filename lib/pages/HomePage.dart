import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Kategori sederhana
  final List<String> categories = [
    'Coffee',
    'Matcha',
    'Pastry',
    'Artisan Bread',
  ];
  String selectedCategory = 'Coffee';

  // Data produk contoh dengan imageUrl
  final List<Product> allProducts = [
    Product(
      'Cappucino',
      25000,
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrel6xiovhaELr1f--k2jCl7tUC9i2hLsfAA&s',
    ),
    Product(
      'Espresso Matcha',
      25000,
      'https://images.unsplash.com/photo-1541167760496-1628856ab772?q=80&w=800&auto=format&fit=crop',
    ),
    Product(
      'Latte',
      28000,
      'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=800&auto=format&fit=crop',
    ),
    Product(
      'Mocha',
      30000,
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOCj_gHGzcoR4OYogtn-3igpzgFB-oFUJqDQ&s',
    ),
    Product(
      'Americano',
      22000,
      'https://majestycoffee.com/cdn/shop/articles/americano_b74a8154-454b-4f74-9a6c-95fbc4152ed3_800x.jpg?v=1684048195',
    ),
    Product(
      'Macchiato',
      30000,
      'https://i.pinimg.com/736x/6a/34/66/6a3466c5c42f898b0f23889ca62b6724.jpg',
    ),
    Product(
      'Flat White',
      27000,
      'https://i.pinimg.com/736x/51/22/61/5122619a7d0b5f44db9481b752f1aa10.jpg',
    ),
    Product(
      'Affogato',
      33000,
      'https://i0.wp.com/cookingitalians.com/wp-content/uploads/2024/07/img-RDN4ZfjtP5hB22jQgDlEB.jpeg?fit=250%2C250&ssl=1',
    ),
    Product(
      'Cortado',
      26000,
      'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQGGBpg6ycflPRFjBIagD5UAakrYVNcKA2j6RFnZkHTH4-zjj4JCJHskRmwyH0vawvoP_3YWkCm',
    ),
  ];

  final List<CartEntry> cart = [];

  String formatRp(int value) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return format.format(value);
  }

  void addEntryToCart(CartEntry entry) {
    setState(() {
      cart.add(entry);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${entry.product.name} ditambahkan ke keranjang',
          style: GoogleFonts.poppins(),
        ),
        duration: const Duration(milliseconds: 700),
        backgroundColor: Colors.brown[700],
      ),
    );
  }

  // Hitung total dari cart entries
  int getTotal() {
    int total = 0;
    for (final e in cart) {
      final int unit = e.product.price + e.extrasPrice;
      total += unit * e.quantity;
    }
    return total;
  }

  // Hitung jumlah item total di keranjang
  int getCount() {
    int count = 0;
    for (final e in cart) {
      count += e.quantity;
    }
    return count;
  }

  // Tentukan jumlah kolom grid berdasarkan lebar layar (sederhana)
  int gridCountForWidth(double width) {
    if (width >= 1050) return 3;
    if (width >= 800) return 2;
    return 1;
  }

  void showCartDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            int total = getTotal();

            void increaseQty(int idx) {
              setState(() => cart[idx].quantity++);
            }

            void decreaseQty(int idx) {
              if (cart[idx].quantity > 1) {
                setState(() => cart[idx].quantity--);
              }
            }

            void removeItem(int idx) {
              setState(() => cart.removeAt(idx));
            }

            void clearCart() {
              setState(() => cart.clear());
            }

            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: Container(
                width: 420,
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.clear, color: Colors.red, size: 18),
                        GestureDetector(
                          onTap: () {
                            clearCart();
                          },
                          child: Text(
                            ' Clear',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (cart.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          'Keranjang kosong',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      )
                    else
                      Column(
                        children: [
                          ...cart.asMap().entries.map((entry) {
                            int idx = entry.key;
                            CartEntry e = entry.value;
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      e.product.imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.brown[200],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.product.name,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          formatRp(e.product.price),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        if (e.optionsSummary.isNotEmpty)
                                          Text(
                                            e.optionsSummary,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black54,
                                              fontSize: 13,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.add_circle,
                                              color: Colors.green,
                                            ),
                                            onPressed: () => increaseQty(idx),
                                            iconSize: 24,
                                            padding: EdgeInsets.zero,
                                          ),
                                          Text(
                                            '${e.quantity}',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                            onPressed: () => decreaseQty(idx),
                                            iconSize: 24,
                                            padding: EdgeInsets.zero,
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () => removeItem(idx),
                                        tooltip: 'Remove',
                                        iconSize: 20,
                                        padding: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    const SizedBox(height: 12),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          formatRp(getTotal()),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: cart.isEmpty
                            ? null
                            : () {
                                // Order action here
                                Navigator.pop(context);
                                showPaymentDialog(context, getTotal());
                              },
                        child: Text(
                          'ORDER',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showPaymentDialog(BuildContext context, int total) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        String selectedMethod = 'QRIS';
        return StatefulBuilder(
          builder: (dialogContext, setStateDialog) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Payment',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Payment Method',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      color: selectedMethod == 'QRIS'
                          ? Colors.brown[50]
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.qr_code, color: Colors.brown[700]),
                        title: Text(
                          'QRIS',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Scan QR to pay',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                        trailing: Radio<String>(
                          value: 'QRIS',
                          groupValue: selectedMethod,
                          onChanged: (v) =>
                              setState(() => selectedMethod = v ?? 'QRIS'),
                        ),
                        onTap: () => setState(() => selectedMethod = 'QRIS'),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          formatRp(total),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.payment, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          showQrisBarcodeDialog(
                            context, // <-- gunakan context utama
                            total,
                            () {
                              // Gunakan context utama untuk showSnackBar dan setState
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Payment successful!',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: Colors.green[700],
                                ),
                              );
                              setState(() => cart.clear());
                            },
                          );
                        },
                        label: Text(
                          'Pay',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showQrisBarcodeDialog(
    BuildContext context,
    int total,
    VoidCallback onPaymentSuccess,
  ) {
    showDialog(
      context: context, // Use the passed context
      builder: (BuildContext dialogContext) {
        // Get fresh context from builder
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
                      child: Image.network(
                        'https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=QRIS_DUMMY_PAYMENT',
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
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(dialogContext); // Use dialogContext here
                        onPaymentSuccess();
                      },
                      child: Text(
                        'Done',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 800;
    final int gridCross = gridCountForWidth(size.width);
    final products = allProducts;

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
        appBar: AppBar(
          backgroundColor: Colors.brown[700],
          elevation: 0,
          title: Text(
            'Barista Shop',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isTablet)
                    Container(
                      width: 220,
                      padding: const EdgeInsets.all(12),
                      child: Card(
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
                              for (final c in categories)
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedCategory = c),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: c == selectedCategory
                                          ? Colors.brown[50]
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(c),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedCategory,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (!isTablet)
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        for (final c in categories)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8,
                                            ),
                                            child: ChoiceChip(
                                              label: Text(c),
                                              selected: c == selectedCategory,
                                              onSelected: (_) => setState(
                                                () => selectedCategory = c,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
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
                              children: products.map((p) {
                                return ProductCard(
                                  product: p,
                                  onTap: () => showProductDialog(context, p),
                                  priceText: formatRp(p.price),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Ringkasan keranjang di bawah
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
                                    formatRp(getTotal()),
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
                                  'Cart (${getCount()})',
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
                            addEntryToCart(entry);
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

class Product {
  final String name;
  final int price;
  final String imageUrl;
  Product(this.name, this.price, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      other is Product &&
      other.name == name &&
      other.price == price &&
      other.imageUrl == imageUrl;
  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ imageUrl.hashCode;
}

class CartEntry {
  final Product product;
  int quantity;
  final int extrasPrice;
  final String optionsSummary;
  CartEntry({
    required this.product,
    required this.quantity,
    required this.extrasPrice,
    required this.optionsSummary,
  });
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
