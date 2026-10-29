
import 'package:flutter/material.dart';
import 'register_page.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static const Color mocca = Color(0xFF8B6B52);
  static const Color darkMocca = Color(0xFF493528);
  static const Color cream = Color(0xFFF1E7D9);
  static const Color bronze = Color(0xFFB68A5A);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mocca,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9B795F),
              Color(0xFF6D4E39),
              Color(0xFF493528),
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
                vertical: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/login.png',
                    height: 220,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.coffee,
                        size: 100,
                        color: cream,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: cream,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Masukkan email dan password Anda untuk melanjutkan',
                    style: TextStyle(
                      color: cream,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Card(
                    color: const Color(0xFFF7F0E7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: cream,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'contoh: NamaKamu@email.com',
                                prefixIcon: const Icon(Icons.email),
                                filled: true,
                                fillColor: const Color(0xFF29211C),
                                labelStyle: const TextStyle(
                                  color: cream,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintStyle: const TextStyle(
                                  color: Color(0xFFD0C0AF),
                                ),
                                prefixIconColor: bronze,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+$',
                                ).hasMatch(value)) {
                                  return 'Masukkan email yang valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: const TextStyle(
                                color: cream,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                filled: true,
                                fillColor: const Color(0xFF29211C),
                                labelStyle: const TextStyle(
                                  color: cream,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIconColor: bronze,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
                            const SizedBox(height: 25),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: bronze,
                                  foregroundColor: darkMocca,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Login Berhasil!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainScreen(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Belum punya akun? Daftar di sini',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: bronze,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: bronze,
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
