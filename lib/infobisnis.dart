import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class InfoBisnisScreen extends StatefulWidget {
  @override
  State<InfoBisnisScreen> createState() => _InfoBisnisScreenState();
}

class _InfoBisnisScreenState extends State<InfoBisnisScreen> {
  final TextEditingController _namaToko = TextEditingController();
  final TextEditingController _noTelepon = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _noRekening = TextEditingController();

  Future<void> _updateBusinessInfo() async {
    if (_namaToko.text.isEmpty ||
        _noTelepon.text.isEmpty ||
        _email.text.isEmpty ||
        _noRekening.text.isEmpty) {
      Fluttertoast.showToast(msg: "Harap isi semua bidang!");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.200.14.94/practice_api/update_business.php'),
        body: {
          'nama_toko': _namaToko.text,
          'no_telepon': _noTelepon.text,
          'email': _email.text,
          'no_rekening': _noRekening.text,
        },
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          Fluttertoast.showToast(msg: "Informasi bisnis berhasil diupdate!");
          // Clear input fields
          _namaToko.clear();
          _noTelepon.clear();
          _email.clear();
          _noRekening.clear();
        } else {
          Fluttertoast.showToast(
              msg: "Gagal mengupdate data: ${responseBody['error']}");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Kesalahan jaringan: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Bisnis'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _namaToko,
                decoration: InputDecoration(
                  labelText: 'Nama Toko',
                  filled: true,
                  fillColor: Color(0xFFD1DDE7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _noTelepon,
                decoration: InputDecoration(
                  labelText: 'No Telepon',
                  filled: true,
                  fillColor: Color(0xFFD1DDE7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Color(0xFFD1DDE7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _noRekening,
                decoration: InputDecoration(
                  labelText: 'No Rekening',
                  filled: true,
                  fillColor: Color(0xFFD1DDE7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _updateBusinessInfo,
                child: Text(
                  'UPDATE',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
