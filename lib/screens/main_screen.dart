
import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../models/cart_item.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'login_page.dart';
import 'add_product.dart';
import 'edit_product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Drink> _drinkList = [
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

  final List<CartItem> _cartItems = [];

  void _addToCart(Drink drink, int quantity) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
        (item) => item.drink.id == drink.id,
      );

      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity += quantity;
      } else {
        _cartItems.add(
          CartItem(
            drink: drink,
            quantity: quantity,
          ),
        );
      }
    });
  }

  void _addProduct(Drink drink) {
    setState(() {
      _drinkList.add(drink);
    });
  }

  void _editProduct(Drink updatedDrink) {
    setState(() {
      final index = _drinkList.indexWhere(
        (drink) => drink.id == updatedDrink.id,
      );

      if (index != -1) {
        _drinkList[index] = updatedDrink;
      }
    });
  }

  void _deleteProduct(Drink drink) {
    setState(() {
      _drinkList.removeWhere(
        (item) => item.id == drink.id,
      );
    });
  }

  void _openAddProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductPage(
          onSave: _addProduct,
        ),
      ),
    );
  }

  void _openEditProduct(Drink drink) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(
          existingDrink: drink,
          onSave: _editProduct,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        drinkList: _drinkList,
        onAddToCart: _addToCart,
        onEdit: _openEditProduct,
        onDelete: _deleteProduct,
        onAdd: (_) => _openAddProduct(),
      ),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: (drinkId) {
          setState(() {
            _cartItems.removeWhere(
              (item) => item.drink.id == drinkId,
            );
          });
        },
      ),
      const LoginPage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF29211C),
        selectedItemColor: const Color(0xFFB68A5A),
        unselectedItemColor: const Color(0xFFD0C0AF),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
