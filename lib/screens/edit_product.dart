
import 'package:flutter/material.dart';
import '../models/drink.dart';

class EditProductPage extends StatefulWidget {
  final Function(Drink) onSave;
  final Drink existingDrink;

  const EditProductPage({
    Key? key,
    required this.onSave,
    required this.existingDrink,
  }) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.existingDrink.name;
    _priceController.text = widget.existingDrink.price.toString();
    _imageUrlController.text = widget.existingDrink.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final price = int.parse(_priceController.text);
      final imageUrl = _imageUrlController.text;

      final updatedDrink = Drink(
        id: widget.existingDrink.id,
        name: name,
        price: price,
        imageUrl: imageUrl,
      );

      widget.onSave(updatedDrink);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk berhasil diperbarui!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Validasi gagal! Silakan perbaiki error dari form.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Produk',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.local_cafe),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama produk tidak boleh kosong.';
                    }

                    if (value.length < 3) {
                      return 'Nama produk minimal 3 karakter.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Harga',
                    prefixText: 'Rp ',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga tidak boleh kosong.';
                    }

                    final price = int.tryParse(value);

                    if (price == null) {
                      return 'Masukkan harga dalam bentuk angka.';
                    }

                    if (price <= 0) {
                      return 'Harga harus lebih dari 0.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Path Aset Gambar',
                    hintText: 'assets/espresso.jpg',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.image),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Path gambar tidak boleh kosong.';
                    }

                    if (!value.startsWith('assets/')) {
                      return "Path harus dimulai dengan 'assets/'.";
                    }

                    if (!value.endsWith('.png') &&
                        !value.endsWith('.jpg') &&
                        !value.endsWith('.jpeg')) {
                      return 'Path harus berupa file gambar (.png, .jpg, .jpeg).';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Simpan Perubahan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
