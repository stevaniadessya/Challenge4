
import 'package:flutter/material.dart';
import '../models/drink.dart';
import 'drink_detail_page.dart';

const Color warnaLatar = Color(0xFFFBF7F2);
const Color warnaLatte = Color(0xFFD5B49A);
const Color warnaCokelat = Color(0xFF795B49);
const Color warnaTeks = Color(0xFF594438);
const Color warnaKrem = Color(0xFFF0E2D5);
const Color warnaBorder = Color(0xFFE5D4C5);

class HomePage extends StatelessWidget {
  final List<Drink> drinkList;
  final Function(Drink, int) onAddToCart;

  const HomePage({
    super.key,
    required this.drinkList,
    required this.onAddToCart,
  });

  String formatRupiah(int harga) {
    return 'Rp${harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text(
          'Menu Minuman',
          style: TextStyle(
            color: warnaTeks,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: warnaKrem,
        elevation: 0,
      ),
      body: drinkList.isEmpty
          ? const Center(
              child: Text(
                'Belum ada menu minuman.',
                style: TextStyle(color: warnaTeks),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: drinkList.length,
              itemBuilder: (context, index) {
                final drink = drinkList[index];

                return Card(
                  color: Colors.white,
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: warnaBorder),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            drink.imageUrl,
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 85,
                                height: 85,
                                color: warnaKrem,
                                child: const Icon(
                                  Icons.local_cafe,
                                  size: 34,
                                  color: warnaCokelat,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                drink.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: warnaTeks,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                formatRupiah(drink.price),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: warnaCokelat,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: warnaCokelat,
                                      side: const BorderSide(
                                        color: warnaLatte,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      minimumSize: const Size(0, 32),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DrinkDetailPage(
                                            drink: drink,
                                            onAddToCart: onAddToCart,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('Detail'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: warnaLatte,
                                      foregroundColor: warnaTeks,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      minimumSize: const Size(0, 32),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      onAddToCart(drink, 1);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${drink.name} ditambahkan ke keranjang',
                                          ),
                                          backgroundColor: warnaCokelat,
                                          duration:
                                              const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: const Text('Pesan'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
