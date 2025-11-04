// lib/ensiklopedia_kopi_page.dart
// (TIMPA SEMUA KODE LAMA DENGAN VERSI 3 INI)

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// --- BAGIAN 1: MODEL ---
// Model untuk data Produk dari DummyJSON
class Product {
  final int id;
  final String title;
  final String description;
  final String thumbnail; // API ini key-nya 'thumbnail'

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      // Ambil data dari key 'thumbnail'
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }
}

// --- BAGIAN 2: SERVICE ---
// Service untuk mengambil data Produk dari DummyJSON
class ProductService {
  final Dio _dio = Dio();
  // URL API BARU yang 100% stabil
  final String _url = 'https://dummyjson.com/products';

  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await _dio.get(_url);
      if (response.statusCode == 200) {

        // --- INI PERUBAHAN PENTING ---
        // Datanya adalah Map (Object), bukan List
        final Map<String, dynamic> jsonData = response.data;

        // Ambil List-nya dari key 'products'
        final List<dynamic> productList = jsonData['products'];
        // ------------------------------

        // Ubah List<dynamic> menjadi List<Product>
        return productList.map((item) => Product.fromJson(item)).toList();

      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi error: $e');
    }
  }
}

// --- BAGIAN 3: UI (HALAMAN) ---
// Nama class tetap sama agar import di home_page tidak error
class EnsiklopediaKopiPage extends StatefulWidget {
  const EnsiklopediaKopiPage({Key? key}) : super(key: key);

  @override
  _EnsiklopediaKopiPageState createState() => _EnsiklopediaKopiPageState();
}

class _EnsiklopediaKopiPageState extends State<EnsiklopediaKopiPage> {
  final ProductService _productService = ProductService();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = true;
  String _errorMessage = '';
  List<Product> _allProductList = [];
  List<Product> _filteredProductList = [];

  @override
  void initState() {
    super.initState();
    if (_allProductList.isEmpty) {
      _loadProductData();
    }
    _searchController.addListener(_filterProducts);
  }

  Future<void> _loadProductData() async {
    try {
      final data = await _productService.fetchAllProducts();
      if (mounted) {
        setState(() {
          _allProductList = data;
          _filteredProductList = data;
          _isLoading = false;
          _errorMessage = '';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProductList = _allProductList.where((product) {
        // Cari berdasarkan 'title'
        final productName = product.title.toLowerCase();
        return productName.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: $_errorMessage'),
          ));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Cari produk (DummyJSON)...', // Ganti hint
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: _filteredProductList.isEmpty
              ? Center(
            child: Text(
              _searchController.text.isEmpty
                  ? 'Tidak ada data produk'
                  : 'Produk tidak ditemukan',
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: _filteredProductList.length,
            itemBuilder: (context, index) {
              final product = _filteredProductList[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      // Tampilkan 'thumbnail'
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover, // Cover lebih bagus u/ thumbnail
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ));
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.image_not_supported_outlined,
                                color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ),
                  // Tampilkan 'title'
                  title: Text(
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Tampilkan 'description'
                  subtitle: Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    // Nanti bisa buat halaman detail di sini
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold tetap tanpa AppBar
    return Scaffold(
      body: SafeArea(child: _buildBody()),
    );
  }
}