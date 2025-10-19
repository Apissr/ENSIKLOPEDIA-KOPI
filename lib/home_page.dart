import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kopi.dart';
import 'detail_page.dart';
import 'dummy_data.dart';
import 'dart:math';
import 'login_page.dart';
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
  bool isDarkMode = false; // 🌙 Tema toggle

  @override
  void initState() {
    super.initState();
    randomKopi = coffeeList[Random().nextInt(coffeeList.length)];
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkMode ? const Color(0xff2b231d) : const Color(0xfff3f0eb);
    final cardColor = isDarkMode ? const Color(0xff3a2f28) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.brown[900];
    final secondaryText = isDarkMode ? Colors.brown[200] : Colors.brown[700];

    final filteredList = coffeeList.where((kopi) {
      final matchesSearch = kopi.nama.toLowerCase().contains(searchQuery.toLowerCase()) ||
          kopi.asal.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesRoast = selectedRoastLevel == null || kopi.roastLevel == selectedRoastLevel;
      final matchesProcess = selectedProcess == null || kopi.processingMethod == selectedProcess;
      return matchesSearch && matchesRoast && matchesProcess;
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.brown[900] : Colors.brown[700],
        title: Text(
          "Halo, ${widget.username} 👋",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            tooltip: "Ganti Tema",
            onPressed: () {
              setState(() => isDarkMode = !isDarkMode);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: "Logout",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),


            TextField(
              decoration: InputDecoration(
                hintText: "Cari kopi favoritmu...",
                prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.brown[300] : Colors.brown),
                filled: true,
                fillColor: isDarkMode ? Colors.brown[800] : Colors.white,
                hintStyle: TextStyle(color: secondaryText),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: textColor),
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),

            const SizedBox(height: 16),

            // 🏷️ Filter Row
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<RoastLevel?>(
                    value: selectedRoastLevel,
                    dropdownColor: isDarkMode ? Colors.brown[800] : Colors.white,
                    decoration: InputDecoration(
                      labelText: "Roast Level",
                      labelStyle: TextStyle(color: secondaryText),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: isDarkMode ? Colors.brown[700] : Colors.brown[50],
                    ),
                    items: [null, ...RoastLevel.values].map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(
                          level?.displayName ?? "Semua Roast",
                          style: GoogleFonts.poppins(color: textColor),
                        ),
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
                    dropdownColor: isDarkMode ? Colors.brown[800] : Colors.white,
                    decoration: InputDecoration(
                      labelText: "Processing",
                      labelStyle: TextStyle(color: secondaryText),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: isDarkMode ? Colors.brown[700] : Colors.brown[50],
                    ),
                    items: [null, ...ProcessingMethod.values].map((process) {
                      return DropdownMenuItem(
                        value: process,
                        child: Text(
                          process?.displayName ?? "Semua Proses",
                          style: GoogleFonts.poppins(color: textColor),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedProcess = value);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ☕ Fun Fact Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.brown[800] : Colors.brown[100],
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
                children: [
                  Icon(Icons.lightbulb,
                      color: isDarkMode ? Colors.amber[200] : Colors.brown, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Fun Fact: ${randomKopi.funFact}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),

            const SizedBox(height: 12),

            // 🪔 Judul Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Daftar Kopi Pilihan",
                style: GoogleFonts.merriweather(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),

            const SizedBox(height: 8),


            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final kopi = filteredList[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DetailPage(kopi: kopi),
                      );
                    },
                    child: Card(
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'kopi_${kopi.nama}_${index}',
                            child: ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(16),
                              ),
                              child: Image.asset(
                                kopi.gambar,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.local_cafe, size: 60, color: Colors.brown[300]),
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
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          size: 16, color: secondaryText),
                                      const SizedBox(width: 4),
                                      Text(
                                        kopi.asal,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: secondaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        5,
                                            (i) => Icon(
                                          i < kopi.rating ? Icons.star : Icons.star_border,
                                          size: 16,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        kopi.rating.toString(),
                                        style: GoogleFonts.poppins(fontSize: 13, color: textColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: Duration(milliseconds: index * 80)).slideX(begin: -30),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
