import 'package:flutter/material.dart';
import 'package:flutter_posify/dashboard.dart';
import 'package:flutter_posify/ubahkatasandi.dart';
import 'package:get/get.dart';
import 'package:flutter_posify/daftar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isObsecure = true.obs;

  final TextEditingController _namaToko = TextEditingController();
  final TextEditingController _passwordToko = TextEditingController();

  Future<void> _login() async {
    if (_namaToko.text.isEmpty || _passwordToko.text.isEmpty) {
      Fluttertoast.showToast(msg: "apa gitu");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.122.157/practice_api/login.php'), // Your login API URL
        body: {
          'nama_toko': _namaToko.text,
          'password': _passwordToko.text,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          Fluttertoast.showToast(msg: "Login Berhasil");
          Future.delayed(Duration(milliseconds: 2000), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          });
          // Navigate to Dashboard or another screen after successful login
        } else {
          Fluttertoast.showToast(msg: "Invalid username or password");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Network error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    const SizedBox(height: 20),
                    Text(
                      "POSify.",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Image.asset(
                        'assets/Posify.png',
                        height: 260,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _namaToko,
                            validator: (val) =>
                                val == "" ? "Masukkan Nama Toko" : null,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                color: Color.fromARGB(255, 41, 161, 71),
                                fontStyle: FontStyle.italic,
                              ),
                              prefixIcon: const Icon(
                                Icons.store,
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
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => TextFormField(
                              controller: _passwordToko,
                              obscureText: isObsecure.value,
                              validator: (val) =>
                                  val == "" ? "Masukkan Password" : null,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 41, 161, 71),
                                  fontStyle: FontStyle.italic,
                                ),
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
                                hintText: "Masukkan Password",
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
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UbahKataSandi(),
                                ),
                              );
                            },
                            child: Text(
                              "Lupa Kata Sandi?",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Material(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: _login, // Call _login function on tap
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Belum memiliki Akun? "),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DaftarScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Daftar",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
