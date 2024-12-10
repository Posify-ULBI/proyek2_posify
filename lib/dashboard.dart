import 'package:flutter/material.dart';
import 'package:flutter_posify/checkout.dart';
import 'package:flutter_posify/aturakun.dart';
import 'package:flutter_posify/kelolaakun.dart';
import 'package:flutter_posify/kelolaproduk.dart';
import 'package:flutter_posify/product.dart';
import 'package:flutter_posify/input.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
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
            icon: Icon(Icons.logout),
            onPressed: () {},
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
                  _buildDrawerItem(
                    Icons.point_of_sale,
                    'Kasir',
                    '/kasir',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                      Icons.store, 'Kelola Produk', '/kelolaproduk', onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KelolaProdukScreen(),
                      ),
                    );
                  }),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header toko
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logocake.jpg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Toko Cake',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Text('0897878646'),
                      const Text('cake@gmail.com'),
                    ],
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AturakunScreen(),
                        ),
                      );
                    },
                    child: const Text('Atur Akun'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Statistik Produk dan Pendapatan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      Text(
                        '6',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text('Produk Terjual'),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'Rp 62.000,-',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text('Pendapatan'),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32),

              // Produk Terlaris
              const Text(
                'Produk Terlaris :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPopularProduct('Ricebowl', 'assets/mixplatter.jpg'),
                  _buildPopularProduct('Coffee', 'assets/mixplatter.jpg'),
                  _buildPopularProduct('Mojito', 'assets/mixplatter.jpg'),
                ],
              ),
              const SizedBox(height: 16),

              // Paket Bundling
              const Text(
                'Paket Bundling:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildBundlePackage(
                'Mix platter + 2 Chocolate',
                '10 stock',
                'Rp 30,000.-',
                'assets/chocolate.jpg',
              ),
              const SizedBox(height: 8),
              _buildBundlePackage(
                '4 Chocolate',
                '20 stock',
                'Rp 18,000.-',
                'assets/mixplatter.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String route,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      onTap: onTap,
    );
  }

  Widget _buildPopularProduct(String name, String imagePath) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBundlePackage(
      String title, String stock, String price, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(stock),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {},
              child:
                  const Text('Lihat >', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
