import 'package:flutter/material.dart';
import 'package:challenge2/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loadingController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    _logoScale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _textFade = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOutCubic,
      ),
    );

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _startAnimation();
    _goToMainScreen();
  }

  Future<void> _startAnimation() async {
    await _logoController.forward();

    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    await _textController.forward();

    if (!mounted) return;

    _loadingController.forward();
  }

  Future<void> _goToMainScreen() async {
    await Future.delayed(const Duration(seconds: 6));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151311),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF493326),
              Color(0xFF29211C),
              Color(0xFF151311),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),

              // LOGO KOPI
              FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF29211C),
                      border: Border.all(
                        color: const Color(0xFFB68A5A),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFB68A5A)
                              .withOpacity(0.25),
                          blurRadius: 35,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/cafe.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.coffee_rounded,
                              size: 90,
                              color: Color(0xFFB68A5A),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 38),

              // JUDUL DAN TAGLINE
              FadeTransition(
                opacity: _textFade,
                child: SlideTransition(
                  position: _textSlide,
                  child: const Column(
                    children: [
                      Text(
                        'WARUNG IS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF1E7D9),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'YOUR DAILY ESPRESSO',
                        style: TextStyle(
                          color: Color(0xFFB68A5A),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'A little coffee, a lot of comfort.',
                        style: TextStyle(
                          color: Color(0xFFD0C0AF),
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // LOADING ANIMATION
              FadeTransition(
                opacity: _textFade,
                child: Column(
                  children: [
                    SizedBox(
                      width: 110,
                      child: AnimatedBuilder(
                        animation: _loadingController,
                        builder: (context, child) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: _loadingController.value,
                              minHeight: 3,
                              backgroundColor: const Color(0xFF6B5543),
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(
                                Color(0xFFB68A5A),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'PREPARING YOUR COFFEE...',
                      style: TextStyle(
                        color: Color(0xFFD0C0AF),
                        fontSize: 9,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
