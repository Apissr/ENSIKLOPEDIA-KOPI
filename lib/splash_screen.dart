import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.brown.shade200,
              Colors.brown.shade100,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 400,
                width: 400,
              )
                  .animate()
                  .fadeIn(duration: 1000.ms)
                  .scale(delay: 500.ms),

              Text(
                "Ensiklopedia Kopi",
                style: GoogleFonts.bungee(
                  fontSize: 32,
                  color: Colors.brown[800],
                  fontWeight: FontWeight.w600,
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms)
                  .slideY(begin: 50, end: 0),

              const SizedBox(height: 8),

               LoadingAnimationWidget.flickr(leftDotColor: Colors.black,
                   rightDotColor: Colors.white, size: 45),
              Text(
                "by hapisss",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.2),
                ),
              )
                  .animate()
                  .fadeIn(delay: 600.ms),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}