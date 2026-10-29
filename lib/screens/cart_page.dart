
import 'package:flutter/material.dart';
import '../models/cart_item.dart';

const Color warnaLatar = Color(0xFF151311);
const Color warnaLatte = Color(0xFFB68A5A);
const Color warnaCokelat = Color(0xFFD0C0AF);
const Color warnaTeks = Color(0xFFF1E7D9);
const Color warnaKrem = Color(0xFF29211C);
const Color warnaBorder = Color(0xFF6B5543);

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _namaController = TextEditingController();
  final _mejaController = TextEditingController();

  String? _errorNama;
  String? _errorMeja;

  int get totalHarga => widget.cartItems.fold<int>(
        0,
        (total, item) => total + item.drink.price * item.quantity,
      );

  String formatRupiah(int harga) {
    return 'Rp${harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  @override
  void dispose() {
    _namaController.dispose();
    _mejaController.dispose();
    super.dispose();
  }

  void _checkout() {
    final nama = _namaController.text.trim();
    final teksNomorMeja = _mejaController.text.trim();
    final nomorMeja = int.tryParse(teksNomorMeja);

    setState(() {
      _errorNama =
          nama.isEmpty ? 'Nama Pemesan tidak boleh kosong' : null;

      if (teksNomorMeja.isEmpty) {
        _errorMeja = 'Nomor Meja tidak boleh kosong';
      } else if (nomorMeja == null) {
        _errorMeja = 'Nomor Meja harus berupa angka';
      } else if (nomorMeja < 1 || nomorMeja > 20) {
        _errorMeja = 'Nomor Meja harus antara 1-20';
      } else {
        _errorMeja = null;
      }
    });

    if (_errorNama != null || _errorMeja != null) {
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: warnaKrem,
        title: const Text(
          'Checkout Berhasil!',
          style: TextStyle(
            color: warnaTeks,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Pesanan atas nama ${_namaController.text.trim()} '
          'untuk meja ${_mejaController.text.trim()} berhasil dibuat.\n\n'
          'Total: ${formatRupiah(totalHarga)}',
          style: const TextStyle(color: warnaTeks),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: warnaLatte,
              foregroundColor: warnaLatar,
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  InputDecoration dekorasiInput(String hint, String? errorText) {
    return InputDecoration(
      hintText: hint,
      errorText: errorText,
      hintStyle: const TextStyle(color: warnaCokelat),
      errorStyle: const TextStyle(
        color: Color(0xFFFF7777),
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: warnaLatar,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: warnaBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: warnaBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: warnaLatte,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFFF7777)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Keranjang',
          style: TextStyle(
            color: warnaTeks,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: warnaLatar,
        foregroundColor: warnaTeks,
        elevation: 0,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 52,
                    color: warnaLatte,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(
                      color: warnaTeks,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Yuk, pilih minuman favoritmu!',
                    style: TextStyle(color: warnaCokelat),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(14),
              children: [
                const Text(
                  'Pesanan Kamu',
                  style: TextStyle(
                    color: warnaTeks,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                ...widget.cartItems.map((item) {
                  return Card(
                    color: warnaKrem,
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: warnaBorder),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.asset(
                              item.drink.imageUrl,
                              width: 68,
                              height: 68,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 68,
                                  height: 68,
                                  color: const Color(0xFF3B3028),
                                  child: const Icon(
                                    Icons.local_cafe,
                                    color: warnaLatte,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 11),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.drink.name,
                                  style: const TextStyle(
                                    color: warnaTeks,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formatRupiah(item.drink.price),
                                  style: const TextStyle(
                                    color: warnaLatte,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Jumlah: ${item.quantity}',
                                  style: const TextStyle(
                                    color: warnaTeks,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'Subtotal: ${formatRupiah(item.drink.price * item.quantity)}',
                                  style: const TextStyle(
                                    color: warnaCokelat,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: 'Hapus pesanan',
                            onPressed: () {
                              widget.onRemoveFromCart(item.drink.id);
                            },
                            icon: const Icon(Icons.delete_outline),
                            color: const Color(0xFFFF7777),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 6),

                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: warnaKrem,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: warnaBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Harga',
                        style: TextStyle(
                          color: warnaTeks,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatRupiah(totalHarga),
                        style: const TextStyle(
                          color: warnaLatte,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'Data Pemesan',
                  style: TextStyle(
                    color: warnaTeks,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Pemesan',
                      style: TextStyle(
                        color: warnaTeks,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 7),

                    TextField(
                      controller: _namaController,
                      style: const TextStyle(color: warnaTeks),
                      decoration: dekorasiInput(
                        'Masukkan nama pemesan',
                        _errorNama,
                      ),
                      onChanged: (_) {
                        if (_errorNama != null) {
                          setState(() => _errorNama = null);
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Nomor Meja',
                      style: TextStyle(
                        color: warnaTeks,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 7),

                    TextField(
                      controller: _mejaController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: warnaTeks),
                      decoration: dekorasiInput(
                        'Masukkan nomor meja (1–20)',
                        _errorMeja,
                      ),
                      onChanged: (_) {
                        if (_errorMeja != null) {
                          setState(() => _errorMeja = null);
                        }
                      },
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: warnaLatte,
                          foregroundColor: warnaLatar,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        onPressed: _checkout,
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
