
import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../theme/app_theme.dart';
import 'drink_detail_page.dart';

class HomePage extends StatefulWidget {
  final List<Drink> drinkList;
  final Function(Drink, int) onAddToCart;
  final Function(Drink) onEdit;
  final Function(Drink) onDelete;
  final Function(Drink) onAdd;

  const HomePage({
    Key? key,
    required this.drinkList,
    required this.onAddToCart,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = '';

  String formatRupiah(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

void _showMessage(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: AppTheme.cream,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color(0xFF443329),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );
}

 void _showDeleteDialog(Drink drink) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: const Color(0xFF29211C),
      title: const Text(
        'Hapus Produk?',
        style: TextStyle(
          color: AppTheme.cream,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Apakah kamu yakin ingin menghapus ${drink.name}?',
        style: const TextStyle(
          color: AppTheme.cream,
          fontSize: 15,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text(
            'Batal',
            style: TextStyle(
              color: AppTheme.cream,
              fontSize: 14,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onDelete(drink);
            Navigator.pop(dialogContext);
            _showMessage('${drink.name} berhasil dihapus.');
          },
          child: const Text(
            'Hapus',
            style: TextStyle(
              color: Color(0xFFFF7777),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final filteredDrinks = widget.drinkList.where((drink) {
      return drink.name.toLowerCase().contains(
            searchText.toLowerCase(),
          );
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: const Row(
          children: [
            Icon(
              Icons.coffee_rounded,
              color: AppTheme.bronze,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'WARUNG IS',
              style: TextStyle(
                color: AppTheme.cream,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner utama
         
          // Banner utama versi compact
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF39291F),
                  Color(0xFF211A16),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'PREMIUM COFFEE',
                        style: TextStyle(
                          color: AppTheme.bronze,
                          fontSize: 10,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Your Daily Espresso.',
                        style: TextStyle(
                          color: AppTheme.cream,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Temukan minuman favoritmu.',
                        style: TextStyle(
                          color: AppTheme.muted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.coffee_rounded,
                  size: 42,
                  color: AppTheme.bronze,
                ),
              ],
            ),
          ),

          // Kolom pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              style: const TextStyle(color: AppTheme.cream),
              decoration: InputDecoration(
                hintText: 'Cari minuman favorit...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppTheme.bronze,
                ),
                filled: true,
                fillColor: AppTheme.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppTheme.border,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppTheme.border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppTheme.bronze,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          // Judul menu
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Our Menu',
                    style: TextStyle(
                      color: AppTheme.cream,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${filteredDrinks.length} Produk',
                  style: const TextStyle(
                    color: AppTheme.bronze,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Daftar produk
          Expanded(
            child: filteredDrinks.isEmpty
                ? const Center(
                    child: Text(
                      'Produk tidak ditemukan.',
                      style: TextStyle(color: AppTheme.muted),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                    itemCount: filteredDrinks.length,
                    itemBuilder: (context, index) {
                      final drink = filteredDrinks[index];

                      return TweenAnimationBuilder<double>(
                        key: ValueKey(drink.id),
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(
                          milliseconds: 300 + (index * 70),
                        ),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 15 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: AppTheme.border,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(13),
                                      child: Image.asset(
                                        drink.imageUrl,
                                        width: 88,
                                        height: 88,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 88,
                                            height: 88,
                                            color: AppTheme.background,
                                            child: const Icon(
                                              Icons.coffee,
                                              color: AppTheme.bronze,
                                              size: 35,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            drink.name,
                                            style: const TextStyle(
                                              color: AppTheme.cream,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            formatRupiah(drink.price),
                                            style: const TextStyle(
                                              color: AppTheme.bronze,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _smallButton(
                                                  icon: Icons
                                                      .info_outline_rounded,
                                                  label: 'Detail',
                                                  outlined: true,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DrinkDetailPage(
                                                          drink: drink,
                                                          onAddToCart:
                                                              widget
                                                                  .onAddToCart,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: _smallButton(
                                                  icon: Icons
                                                      .shopping_bag_outlined,
                                                  label: 'Pesan',
                                                  outlined: false,
                                                  onPressed: () {
                                                    widget.onAddToCart(
                                                      drink,
                                                      1,
                                                    );
                                                    _showMessage(
                                                      '${drink.name} ditambahkan ke keranjang.',
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Divider(
                                    color: AppTheme.border,
                                    height: 1,
                                  ),
                                ),

                                // Tombol edit dan hapus
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _iconAction(
                                      icon: Icons.edit_outlined,
                                      label: 'Edit',
                                      color: AppTheme.bronze,
                                      onPressed: () {
                                        widget.onEdit(drink);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    _iconAction(
                                      icon: Icons.delete_outline,
                                      label: 'Hapus',
                                      color: Colors.redAccent,
                                      onPressed: () {
                                        _showDeleteDialog(drink);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // Tombol tambah produk
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.bronze,
        foregroundColor: AppTheme.background,
        onPressed: () {
          if (widget.drinkList.isNotEmpty) {
            widget.onAdd(widget.drinkList.first);
          } else {
            widget.onAdd(
              Drink(
                id: DateTime.now().toString(),
                name: '',
                price: 0,
                imageUrl: '',
              ),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Tambah Produk',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _smallButton({
    required IconData icon,
    required String label,
    required bool outlined,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 36,
      child: outlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 15),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.bronze,
                side: const BorderSide(color: AppTheme.bronze),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                textStyle: const TextStyle(fontSize: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 15),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.bronze,
                foregroundColor: AppTheme.background,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
    );
  }

  Widget _iconAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 17, color: color),
      label: Text(
        label,
        style: TextStyle(color: color, fontSize: 12),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
