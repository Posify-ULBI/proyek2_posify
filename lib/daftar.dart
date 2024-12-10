import 'package:flutter/widgets.dart';
import 'package:flutter_posify/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DaftarScreen extends StatefulWidget {
  DaftarScreen({Key? key}) : super(key: key);

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final TextEditingController _namaToko = TextEditingController();
  final TextEditingController _emailToko = TextEditingController();
  final TextEditingController _passwordToko = TextEditingController();

  var isObsecure = true.obs;

  Future<void> _insertRecord() async {
    if (_namaToko.text.isEmpty ||
        _emailToko.text.isEmpty ||
        _passwordToko.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the fields");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.122.157/practice_api/insert_record.php'),
        body: {
          'nama_toko': _namaToko.text,
          'email_toko': _emailToko.text,
          'password': _passwordToko.text,
        },
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          AlertDialog alert = AlertDialog(
            title: Text("Login Berhasil"),
            content: Container(
              child: Text("Selamat Anda Berhasil login"),
            ),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );

          // Show the success dialog
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          showDialog(context: context, builder: (context) => alert);
          return;
        } else {
          print(responseBody['error']);
          // You can show an error dialog if necessary
          Get.snackbar('Error', responseBody['error'],
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        print('Server error: ${response.statusCode}');
        // You can handle different status codes if necessary
      }
    } catch (error) {
      print(error);
      // Handle network or any other error here
      Get.snackbar('Error', 'Network or server error',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color set to white
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20), // Space above the title
                    Text(
                      "POSify.",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20), // Space between title and image
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Image.asset(
                        'assets/Posify.png',
                        height: 260,
                      ),
                    ),
                    const SizedBox(
                        height: 20), // Space between image and input fields

                    // Nama Toko Field
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _namaToko,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.store, // Toko icon
                            color: Colors.black,
                          ),
                          hintText: 'Masukkan Nama Toko',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          fillColor: Color(0xFFD1DDE7),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20), // Space between input fields

                    // Email Toko Field
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _emailToko,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email, // Email icon
                            color: Colors.black,
                          ),
                          hintText: 'Masukkan Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          fillColor: Color(0xFFD1DDE7),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20), // Space between input fields

                    // Password Field
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _passwordToko,
                          obscureText: isObsecure.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.vpn_key_sharp,
                              color: Colors.black,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                isObsecure.value = !isObsecure.value;
                              },
                              child: Icon(
                                isObsecure.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Masukkan Kata Sandi",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            fillColor: Color(0xFFD1DDE7),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20), // Space between input fields

                    // Insert button
                    Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: _insertRecord,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Text(
                            "Buat Akun Toko",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 20), // Space between button and other elements
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
