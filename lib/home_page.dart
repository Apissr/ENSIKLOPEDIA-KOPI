// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kopi.dart';
import 'detail_page.dart';
import 'dummy_data.dart';
import 'dart:math';
import 'login_page.dart'; //
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  RoastLevel? selectedRoastLevel;
  ProcessingMethod? selectedProcess;
  late Kopi randomKopi;

  @override
  void initState() {
    super.initState();
    randomKopi = coffeeList[Random().nextInt(coffeeList.length)];
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = coffeeList.where((kopi) {
      final matchesSearch = kopi.nama.toLowerCase().contains(searchQuery.toLowerCase()) ||
          kopi.asal.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesRoast = selectedRoastLevel == null || kopi.roastLevel == selectedRoastLevel;
      final matchesProcess = selectedProcess == null || kopi.processingMethod == selectedProcess;
      return matchesSearch && matchesRoast && matchesProcess;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xfff3f0eb),
      appBar: AppBar(
        title: Text(
          "Selamat datang, ${widget.username}",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
          color: Colors.white)


        ),
        backgroundColor: Colors.brown[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
        color: Colors.white,

            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔽 Fun Fact Banner
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.brown[100],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb, color: Colors.brown, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Fun Fact: ${randomKopi.funFact}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.brown[900],
                    ),

                  ),
                ),
              ],
            ),
          ),

          // 🔽 Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<RoastLevel?>(
                    value: selectedRoastLevel,
                    decoration: InputDecoration(
                      labelText: "Roast Level",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.brown[50],
                    ),
                    items: [null, ...RoastLevel.values].map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(level?.displayName ?? "Semua Roast",
                            style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedRoastLevel = value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<ProcessingMethod?>(
                    value: selectedProcess,
                    decoration: InputDecoration(
                      labelText: "Processing",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.brown[50],
                    ),
                    items: [null, ...ProcessingMethod.values].map((process) {
                      return DropdownMenuItem(
                        value: process,
                        child: Text(process?.displayName ?? "Semua Proses",
                            style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedProcess = value);
                    },
                  ),
                ),
              ],
            ),
          ),

          // 🔽 ListView Katalog Kopi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final kopi = filteredList[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => DetailPage(kopi: kopi),
                    );
                  },
                  child: Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  elevation: 4,
  margin: const EdgeInsets.only(bottom: 12),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          Colors.brown.shade50,
        ],
      ),
    ),
    child: Row(
      children: [
        Hero(
          tag: 'kopi_${kopi.nama}_${index}',
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Image.asset(
                kopi.gambar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.local_cafe, size: 60, color: Colors.brown[300]),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kopi.nama,
                  style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.brown[700]),
                    const SizedBox(width: 4),
                    Text(
                      kopi.asal,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.brown[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ...List.generate(5, (index) => Icon(
                      index < kopi.rating ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    )),
                    const SizedBox(width: 4),
                    Text(
                      kopi.rating.toString(),
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
).animate()
  .fadeIn()
  .slideX(begin: -30, end: 0, delay: Duration(milliseconds: index * 100)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}