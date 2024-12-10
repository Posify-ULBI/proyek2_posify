import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TambahProdukScreen extends StatefulWidget {
  @override
  State<TambahProdukScreen> createState() => _TambahProdukScreenState();
}

class _TambahProdukScreenState extends State<TambahProdukScreen> {
  final TextEditingController _namaProduk = TextEditingController();
  final TextEditingController _hargaModal = TextEditingController();
  final TextEditingController _hargaJual = TextEditingController();
  final TextEditingController _stokProduk = TextEditingController();
  final TextEditingController _fotoProduk = TextEditingController();
  List<Map<String, dynamic>> _kategoriList = [];
  int? _selectedKategori;
  var isObsecure = true.obs;

  @override
  void initState() {
    super.initState();
    _fetchKategori();
  }

  Future<void> _fetchKategori() async {
    try {
      // Perbaikan: Hapus spasi dari URL
      final response = await http
          .get(Uri.parse('http://192.168.122.157/api/get_kategori.php'));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          setState(() {
            _kategoriList =
                List<Map<String, dynamic>>.from(responseBody['kategori']);
          });
        } else {
          Fluttertoast.showToast(msg: responseBody['message']);
        }
      } else {
        Fluttertoast.showToast(msg: "Gagal mengambil data kategori!");
      }
    } on Exception catch (error) {
      Fluttertoast.showToast(msg: "Terjadi kesalahan: $error");
    }
  }

  Future<void> _insertProduct() async {
    if (_namaProduk.text.isEmpty ||
        _hargaModal.text.isEmpty ||
        _hargaJual.text.isEmpty ||
        _stokProduk.text.isEmpty ||
        _selectedKategori == null ||
        _fotoProduk.text.isEmpty) {
      Fluttertoast.showToast(msg: "Semua kolom harus diisi!");
      return;
    }

    try {
      // Perbaikan: Hapus spasi dari URL
      final response = await http.post(
        Uri.parse('http://192.168.122.157/api/insert_produk.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'nama_produk': _namaProduk.text,
          'harga_modal': _hargaModal.text,
          'harga_jual': _hargaJual.text,
          'stok': _stokProduk.text,
          'id_kategori': _selectedKategori.toString(),
          'foto_produk': _fotoProduk.text,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          Fluttertoast.showToast(msg: "Produk berhasil ditambahkan!");
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: responseBody['message']);
        }
      } else {
        Fluttertoast.showToast(msg: "Gagal menambahkan produk!");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Terjadi kesalahan: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Produk"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Tambahkan logika untuk memilih gambar (file picker)
              },
              child: Column(
                children: [
                  Icon(Icons.add_photo_alternate, size: 80, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Masukkan Foto Produk"),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildTextField("Nama Produk", _namaProduk),
            SizedBox(height: 16),
            _buildTextField("Harga Modal", _hargaModal, isNumber: true),
            SizedBox(height: 16),
            _buildTextField("Harga Jual", _hargaJual, isNumber: true),
            SizedBox(height: 16),
            _buildTextField("Stok Produk", _stokProduk, isNumber: true),
            SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _selectedKategori,
              hint: Text("Pilih Kategori"),
              items: _kategoriList.map((Map<String, dynamic> value) {
                return DropdownMenuItem<int>(
                  value: value['id_kategori'],
                  child: Text(value['nama_kategori']),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _selectedKategori = newValue;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildTextField("Nama File Foto Produk", _fotoProduk),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _insertProduct,
              child: Text("SIMPAN"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
