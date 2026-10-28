
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _pathController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _deskripsiController.dispose();
    _pathController.dispose();
    super.dispose();
  }

  void _simpanProduk() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Validasi berhasil!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF7FF),
        title: const Text(
          'Tambah Produk Baru',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.store_outlined),
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
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
              const SizedBox(height: 16),

              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.money_outlined),
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                ),
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
              const SizedBox(height: 16),

              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.notes_outlined),
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi produk',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi tidak boleh kosong.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _pathController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.image_outlined),
                  labelText: 'Path Aset Gambar',
                  hintText: 'assets/americano.jpg',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Path gambar tidak boleh kosong.';
                  }

                  if (!value.startsWith('assets/')) {
                    return "Path harus dimulai dengan 'assets/'.";
                  }

                  final path = value.toLowerCase();

                  if (!path.endsWith('.png') &&
                      !path.endsWith('.jpg') &&
                      !path.endsWith('.jpeg')) {
                    return 'Path harus berupa file gambar (.png, .jpg).';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpanProduk,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
