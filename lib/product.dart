import 'package:flutter/material.dart';
import 'package:flutter_posify/kelolaakun.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  int totalItems = 6;
  int totalPrice = 62000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Produk'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Membuka drawer
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Arahkan ke halaman keranjang
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(
            255, 145, 189, 225), // Mengubah warna seluruh background drawer
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 145, 189, 225), // Header drawer biru
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Kelola Akun'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KelolaAkunScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(Icons.point_of_sale, 'Kasir', '/kasir'),
                  _buildDrawerItem(
                      Icons.store, 'Kelola Produk', '/kelolaproduk'),
                  _buildDrawerItem(
                      Icons.bar_chart, 'Laporan Keuangan', '/laporankeuangan'),
                  _buildDrawerItem(
                      Icons.history, 'Riwayat Transaksi', '/riwayattrx'),
                  _buildDrawerItem(
                      Icons.business, 'Kelola Toko', '/kelolatoko'),
                  _buildDrawerItem(
                      Icons.people, 'Data Pelanggan', '/datapelanggan'),
                  _buildDrawerItem(Icons.help, 'Bantuan', '/bantuan'),
                ].map((item) {
                  return ListTileTheme(
                    iconColor: Colors.black,
                    textColor: Colors.black,
                    child: item,
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'POSify.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Teks footer berwarna putih
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Semua Produk',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildProductCard(
                      product['name']!,
                      product['price']!,
                      product['stock']!,
                      'assets/mixplatter.jpg',
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                // Logika untuk membuka halaman keranjang
                print("Keranjang ditekan!");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 145, 189, 225),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          '$totalItems Produk',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      'Rp $totalPrice',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildProductCard(
      String name, String price, String stock, String imagePath) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
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
                Text('Stock: $stock', style: TextStyle(color: Colors.grey)),
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
    {'name': 'Mie Ayam', 'price': '8.000', 'stock': '10'},
    {'name': 'Chocolate', 'price': '5.000', 'stock': '20'},
    {'name': 'Nasi Padang', 'price': '15.000', 'stock': '8'},
    {'name': 'Juice', 'price': '8.000', 'stock': '32'},
    {'name': 'Lumpia', 'price': '5.000', 'stock': '20'},
    {'name': 'Mojito', 'price': '9.000', 'stock': '13'},
    {'name': 'Ricebowl', 'price': '15.000', 'stock': '20'},
    {'name': 'Coffee', 'price': '10.000', 'stock': '15'},
    {'name': 'Mix Platter', 'price': '25.000', 'stock': '9'},
  ];
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Hasil pencarian: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Masukkan nama produk untuk mencari'),
    );
  }
}
