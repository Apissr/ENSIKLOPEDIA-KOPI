// lib/detail_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kopi.dart';

class DetailPage extends StatelessWidget {
  final Kopi kopi;
  const DetailPage({super.key, required this.kopi});

  String getRoastLevelString(RoastLevel roastLevel) {
    switch (roastLevel) {
      case RoastLevel.light:
        return "Light Roast";
      case RoastLevel.medium:
        return "Medium Roast";
      case RoastLevel.dark:
        return "Dark Roast";
    }
  }

  String getProcessingMethodString(ProcessingMethod method) {
    switch (method) {
      case ProcessingMethod.natural:
        return "Natural Process";
      case ProcessingMethod.washed:
        return "Washed Process";
      case ProcessingMethod.honey:
        return "Honey Process";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: SingleChildScrollView(
          child: Hero(
            tag: 'card_${kopi.nama}',
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xfff3f0eb),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Gambar kopi sesuai data
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        kopi.gambar,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.brown[100],
                            child: Icon(
                              Icons.local_cafe,
                              size: 64,
                              color: Colors.brown[700],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Nama Kopi
                    Text(
                      kopi.nama,
                      style: GoogleFonts.merriweather(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Asal
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Colors.brown[700], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          kopi.asal,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "${kopi.rating}/5.0",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 24, thickness: 1),

                    // Roast Level & Processing Method
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          backgroundColor: Colors.brown[100],
                          label: Text(
                            getRoastLevelString(kopi.roastLevel),
                            style: GoogleFonts.poppins(
                              color: Colors.brown[700],
                            ),
                          ),
                        ),
                        Chip(
                          backgroundColor: Colors.brown[100],
                          label: Text(
                            getProcessingMethodString(kopi.processingMethod),
                            style: GoogleFonts.poppins(
                              color: Colors.brown[700],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Deskripsi
                    Text(
                      "Deskripsi:",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      kopi.deskripsi,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Fun Fact
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.brown[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.brown[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fun Fact:",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            kopi.funFact,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.brown[800],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tombol Tutup
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Tutup",
                          style: GoogleFonts.poppins(
                            color: Colors.brown[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
