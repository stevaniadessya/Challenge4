
import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../models/cart_item.dart';
import 'home_page.dart';
import 'cart_page.dart';

const Color biruUtama = Color(0xFFD9BCA5);
const Color biruMuda = Color(0xFFFBF7F2);
const Color warnaTeks = Color(0xFF6D5548);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];

  final List<Drink> _drinkList = const [
    Drink(
      id: '1',
      name: 'Espresso',
      price: 18000,
      imageUrl: 'assets/espresso.jpg',
    ),
    Drink(
      id: '2',
      name: 'Americano',
      price: 20000,
      imageUrl: 'assets/americano.jpg',
    ),
    Drink(
      id: '3',
      name: 'Matcha Latte',
      price: 28000,
      imageUrl: 'assets/matcha_latte.jpg',
    ),
    Drink(
      id: '4',
      name: 'Chocolate Frappe',
      price: 30000,
      imageUrl: 'assets/chocolate_frappe.jpg',
    ),
  ];

  void _addToCart(Drink drink, int quantity) {
    setState(() {
      final index = _cartItems.indexWhere(
        (item) => item.drink.id == drink.id,
      );

      if (index >= 0) {
        _cartItems[index].quantity += quantity;
      } else {
        _cartItems.add(
          CartItem(drink: drink, quantity: quantity),
        );
      }
    });
  }

  void _removeFromCart(String id) {
    setState(() {
      _cartItems.removeWhere(
        (item) => item.drink.id == id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: biruMuda,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(
            drinkList: _drinkList,
            onAddToCart: _addToCart,
          ),
          CartPage(
            cartItems: _cartItems,
            onRemoveFromCart: _removeFromCart,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDCE8FF),
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_cafe_outlined),
            selectedIcon: Icon(
              Icons.local_cafe,
              color: biruUtama,
            ),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(
              Icons.shopping_cart,
              color: biruUtama,
            ),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}
