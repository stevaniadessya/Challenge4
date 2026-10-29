
import 'package:flutter/material.dart';
import '../models/drink.dart';

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;
  final Function(Drink, int) onAddToCart;

  const DrinkDetailPage({
    Key? key,
    required this.drink,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _DrinkDetailPageState createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  int _quantity = 1;

  static const Color background = Color(0xFF151311);
  static const Color surface = Color(0xFF29211C);
  static const Color bronze = Color(0xFFB68A5A);
  static const Color cream = Color(0xFFF1E7D9);
  static const Color muted = Color(0xFFD0C0AF);
  static const Color border = Color(0xFF6B5543);

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _showSuccessDialog(
    BuildContext context,
    String foodName,
    int quantity,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: surface,
          title: const Text(
            'Berhasil Ditambahkan!',
            style: TextStyle(
              color: cream,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '$foodName sebanyak $quantity berhasil ditambahkan ke keranjang.',
            style: const TextStyle(color: cream),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: bronze,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          widget.drink.name,
          style: const TextStyle(
            color: cream,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: background,
        foregroundColor: cream,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: border),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.drink.imageUrl,
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          width: 200,
                          color: const Color(0xFF3B3028),
                          child: const Icon(
                            Icons.local_cafe,
                            size: 60,
                            color: bronze,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.drink.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: cream,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nikmati minuman favoritmu dengan cita rasa yang khas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: muted,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Harga: Rp ${widget.drink.price}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: bronze,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _decrementQuantity,
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF493528),
                          foregroundColor: cream,
                          side: const BorderSide(color: bronze),
                        ),
                        icon: const Icon(
                          Icons.remove,
                          size: 22,
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(minWidth: 48),
                        alignment: Alignment.center,
                        child: Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: cream,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _incrementQuantity,
                        style: IconButton.styleFrom(
                          backgroundColor: bronze,
                          foregroundColor: background,
                        ),
                        icon: const Icon(
                          Icons.add,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onAddToCart(
                          widget.drink,
                          _quantity,
                        );

                        _showSuccessDialog(
                          context,
                          widget.drink.name,
                          _quantity,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bronze,
                        foregroundColor: background,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Tambah ke Keranjang',
                        style: TextStyle(
                          fontSize: 14,
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
    );
  }
}
