import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward();

    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 400,
                width: 400,
              ),

              // 🔽 Tambahan teks judul
              Text(
                "Ensiklopedia Kopi",
                style: GoogleFonts.lobster(
                  fontSize: 32,
                  color: Colors.brown[800],
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              // 🔽 Watermark transparan
              Text(
                "by hapisss",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.2), // transparan
                ),
              ),

              const SizedBox(height: 20),

              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
