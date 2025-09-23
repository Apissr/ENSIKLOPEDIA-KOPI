enum RoastLevel {
  light,
  medium,
  dark;

  String get displayName {
    switch (this) {
      case RoastLevel.light:
        return "Light Roast";
      case RoastLevel.medium:
        return "Medium Roast";
      case RoastLevel.dark:
        return "Dark Roast";
    }
  }
}

enum ProcessingMethod {
  natural,
  washed,
  honey;

  String get displayName {
    switch (this) {
      case ProcessingMethod.natural:
        return "Natural Process";
      case ProcessingMethod.washed:
        return "Washed Process";
      case ProcessingMethod.honey:
        return "Honey Process";
    }
  }
}

class Kopi {
  final String nama;
  final String asal;
  final String gambar;
  final RoastLevel roastLevel;
  final ProcessingMethod processingMethod;
  final double rating;
  final String deskripsi;
  final String funFact;
  bool isFavorite; // ✅ INI YANG DITAMBAHKAN

  Kopi({
    required this.nama,
    required this.asal,
    required this.gambar,
    required this.roastLevel,
    required this.processingMethod,
    required this.rating,
    required this.deskripsi,
    required this.funFact,
    this.isFavorite = false, // ✅ DAN INI
  });
}