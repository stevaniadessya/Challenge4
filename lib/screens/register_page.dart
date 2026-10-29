
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  static const Color background = Color(0xFF211A16);
  static const Color surface = Color(0xFF29211C);
  static const Color bronze = Color(0xFFB68A5A);
  static const Color cream = Color(0xFFF1E7D9);
  static const Color muted = Color(0xFFD0C0AF);
  static const Color border = Color(0xFF6B5543);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: muted),
      hintStyle: TextStyle(color: muted.withValues(alpha: 0.7)),
      prefixIcon: Icon(icon, color: bronze),
      filled: true,
      fillColor: surface,
      errorStyle: const TextStyle(color: Color(0xFFFF7777)),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: bronze, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF7777)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF7777)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF493326),
              Color(0xFF211A16),
              Color(0xFF151311),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Register.png',
                    height: 250,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 100,
                        color: bronze,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Create Account',
                    style: TextStyle(
                      color: cream,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Isi data berikut untuk membuat akun baru',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: muted,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 28),

                  Card(
                    color: surface,
                    elevation: 8,
                    shadowColor: Colors.black38,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // NAMA LENGKAP
                            TextFormField(
                              controller: _nameController,
                              style: const TextStyle(color: cream),
                              decoration: _inputDecoration(
                                label: 'Nama Lengkap',
                                icon: Icons.person_outline,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // EMAIL
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: cream),
                              decoration: _inputDecoration(
                                label: 'Email',
                                hint: 'contoh: namakamu@email.com',
                                icon: Icons.email_outlined,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                final emailPattern = RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+$',
                                );
                                if (!emailPattern.hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // NOMOR HP
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(color: cream),
                              decoration: _inputDecoration(
                                label: 'Nomor HP',
                                hint: 'contoh: 081234567890',
                                icon: Icons.phone_android,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nomor HP tidak boleh kosong';
                                }
                                final numericPattern = RegExp(r'^[0-9]+$');
                                if (!numericPattern.hasMatch(value)) {
                                  return 'Nomor HP hanya boleh berisi angka';
                                }
                                if (value.length < 10) {
                                  return 'Nomor HP minimal 10 digit';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // PASSWORD
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: const TextStyle(color: cream),
                              decoration: _inputDecoration(
                                label: 'Password',
                                icon: Icons.lock_outline,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // KONFIRMASI PASSWORD
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              style: const TextStyle(color: cream),
                              decoration: _inputDecoration(
                                label: 'Konfirmasi Password',
                                icon: Icons.lock_reset,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi password tidak boleh kosong';
                                }
                                if (value != _passwordController.text) {
                                  return 'Password tidak sama';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            // TOMBOL DAFTAR
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: bronze,
                                  foregroundColor: background,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Color(0xFF443329),
                                        content: Text(
                                          'Registrasi berhasil divalidasi!',
                                          style: TextStyle(
                                            color: cream,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // LINK LOGIN
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Sudah punya akun? Masuk di sini',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: bronze,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
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
