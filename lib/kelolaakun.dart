import 'package:flutter/material.dart';
import 'package:flutter_posify/aturakun.dart';
import 'package:flutter_posify/dashboard.dart';
import 'package:flutter_posify/premium.dart';
import 'package:flutter_posify/infobisnis.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_posify/login.dart'; // Pastikan path benar

class KelolaAkunScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Kelola Akun',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'assets/logocake.jpg'), // Ganti sesuai path logo
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Toko Cake',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('0898786546'),
                      Text('cake@gmail.com'),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            ListTile(
              title: Text('Informasi Bisnis'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoBisnisScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Reset Data Transaksi'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Fluttertoast.showToast(
                  msg: "Data transaksi telah dihapus.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigasi kembali ke halaman login
                  Fluttertoast.showToast(msg: "Anda telah keluar.");
                  Future.delayed(Duration(milliseconds: 2000), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  });
                },
                child: Text(
                  'Keluar Akun',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PremiumScreen(),
                  ),
                );
              },
              child: Text(
                'Upgrade ke Premium',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
