
import 'package:flutter/material.dart';
import '../models/drink.dart';

const Color warnaLatar = Color(0xFFFBF7F2);
const Color warnaLatte = Color(0xFFD5B49A);
const Color warnaCokelat = Color(0xFF795B49);
const Color warnaTeks = Color(0xFF594438);
const Color warnaKrem = Color(0xFFF0E2D5);
const Color warnaBorder = Color(0xFFE5D4C5);

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;
  final Function(Drink, int) onAddToCart;

  const DrinkDetailPage({
    super.key,
    required this.drink,
    required this.onAddToCart,
  });

  @override
  State<DrinkDetailPage> createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  int _quantity = 1;

  String formatRupiah(int harga) {
    return 'Rp${harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final totalHarga = widget.drink.price * _quantity;

    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Detail Minuman',
          style: TextStyle(
            color: warnaTeks,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: warnaKrem,
        elevation: 0,
        iconTheme: const IconThemeData(color: warnaTeks),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 12),

            // Foto minuman kecil di tengah
            Center(
              child: Container(
                width: 170,
                height: 170,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: warnaBorder),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.drink.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: warnaKrem,
                        child: Icon(
                          Icons.local_cafe,
                          size: 60,
                          color: warnaCokelat,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                widget.drink.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: warnaTeks,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                formatRupiah(widget.drink.price),
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: warnaCokelat,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Pengaturan jumlah pesanan
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: warnaBorder),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Jumlah Pesanan',
                      style: TextStyle(
                        color: warnaTeks,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _quantity > 1
                        ? () {
                            setState(() {
                              _quantity--;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                    color: warnaCokelat,
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: warnaTeks,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    color: warnaCokelat,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Ringkasan harga
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warnaKrem,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Harga',
                    style: TextStyle(
                      fontSize: 15,
                      color: warnaTeks,
                    ),
                  ),
                  Text(
                    formatRupiah(totalHarga),
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: warnaTeks,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: warnaLatte,
                  foregroundColor: warnaTeks,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  widget.onAddToCart(widget.drink, _quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${widget.drink.name} ditambahkan ke keranjang',
                      ),
                      backgroundColor: warnaCokelat,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Tambah ke Keranjang',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
