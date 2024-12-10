import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UbahKataSandi extends StatefulWidget {
  @override
  _UbahKataSandiState createState() => _UbahKataSandiState();
}

class _UbahKataSandiState extends State<UbahKataSandi> {
  var isObsecureOld = true.obs;
  var isObsecureNew = true.obs;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Ubah Kata Sandi"),
      ),
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
                    // Tampilkan gambar di atas
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Image.asset(
                        'assets/Posify.png', // Path ke gambar Posify
                        height: 260,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Masukkan Kata Sandi Lama
                    Obx(
                      () => TextFormField(
                        controller: oldPasswordController,
                        obscureText: isObsecureOld.value,
                        decoration: InputDecoration(
                          labelText: "Kata Sandi Lama",
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              isObsecureOld.value = !isObsecureOld.value;
                            },
                            child: Icon(
                              isObsecureOld.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fillColor: Color(0xFFD1DDE7),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Masukkan Kata Sandi Baru
                    Obx(
                      () => TextFormField(
                        controller: newPasswordController,
                        obscureText: isObsecureNew.value,
                        decoration: InputDecoration(
                          labelText: "Kata Sandi Baru",
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              isObsecureNew.value = !isObsecureNew.value;
                            },
                            child: Icon(
                              isObsecureNew.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fillColor: Color(0xFFD1DDE7),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Konfirmasi Kata Sandi Baru
                    Obx(
                      () => TextFormField(
                        controller: confirmNewPasswordController,
                        obscureText: isObsecureNew.value,
                        decoration: InputDecoration(
                          labelText: "Konfirmasi Kata Sandi Baru",
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              isObsecureNew.value = !isObsecureNew.value;
                            },
                            child: Icon(
                              isObsecureNew.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fillColor: Color(0xFFD1DDE7),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Tombol Simpan Perubahan
                    Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          // Tambahkan fungsi untuk menyimpan kata sandi baru
                          if (newPasswordController.text ==
                              confirmNewPasswordController.text) {
                            // Proses ubah kata sandi
                          } else {
                            // Tampilkan pesan error jika konfirmasi kata sandi tidak sesuai
                            Get.snackbar(
                              "Error",
                              "Kata sandi baru dan konfirmasi tidak cocok",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            "Simpan Perubahan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
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
