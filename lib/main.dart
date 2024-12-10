import 'package:flutter/material.dart';
import 'package:flutter_posify/dashboard.dart';
import 'package:flutter_posify/kelolaproduk.dart';
import 'package:flutter_posify/login.dart';
import 'package:flutter_posify/kelolaakun.dart';
import 'package:flutter_posify/product.dart';
import 'package:flutter_posify/premium.dart';
import 'package:flutter_posify/premium.dart';
import 'package:flutter_posify/daftar.dart';
import 'package:flutter_posify/checkout.dart';
import 'package:flutter_posify/kelolaproduk.dart';
import 'package:flutter_posify/tambahproduk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
