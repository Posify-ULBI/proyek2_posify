import 'package:flutter/material.dart';
import 'package:flutter_posify/tambahproduk.dart';

class KelolaProdukScreen extends StatefulWidget {
  @override
  State<KelolaProdukScreen> createState() => _KelolaProdukScreenState();
}

class _KelolaProdukScreenState extends State<KelolaProdukScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementasi fitur pencarian
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dua kolom
                childAspectRatio: 0.8, // Rasio ukuran produk
                crossAxisSpacing: 10, // Jarak antar kolom
                mainAxisSpacing: 10, // Jarak antar baris
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(
                  product['name']!,
                  product['price']!,
                  product['stock']!,
                  product['imagePath']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TambahProdukScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Tambah Produk Baru',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
      String name, String price, String stock, String imagePath) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('$stock stock', style: TextStyle(color: Colors.grey)),
                Text('Rp $price',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, String>> products = [
    {
      'name': 'Mie Ayam',
      'price': '8.000',
      'stock': '10',
      'imagePath': 'assets/chocolate.jpg',
    },
    {
      'name': 'Chocolate',
      'price': '5.000',
      'stock': '20',
      'imagePath': 'assets/chocolate.jpg',
    },
    {
      'name': 'Nasi Padang',
      'price': '15.000',
      'stock': '8',
      'imagePath': 'assets/chocolate.jpg',
    },
    {
      'name': 'Juice',
      'price': '8.000',
      'stock': '32',
      'imagePath': 'assets/chocolate.jpg',
    },
    {
      'name': 'Lumpia',
      'price': '5.000',
      'stock': '20',
      'imagePath': 'assets/chocolate.jpg',
    },
    {
      'name': 'Mojito',
      'price': '9.000',
      'stock': '13',
      'imagePath': 'assets/chocolate.jpg',
    },
    {
      'name': 'Ricebowl',
      'price': '15.000',
      'stock': '20',
      'imagePath': 'assets/chocolate.jpg',
    },
    {
      'name': 'Coffee',
      'price': '10.000',
      'stock': '15',
      'imagePath': 'assets/chocolate.jpg',
    },
    {
      'name': 'Mix Platter',
      'price': '25.000',
      'stock': '9',
      'imagePath': 'assets/mixplatter.jpg',
    },
  ];
}
