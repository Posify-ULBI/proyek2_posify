import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputData extends StatefulWidget {
  InputData({Key? key}) : super(key: key);

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final TextEditingController _namaToko = TextEditingController();
  final TextEditingController _emailToko = TextEditingController();
  final TextEditingController _passwordToko = TextEditingController();

  Future<void> _insertRecord() async {
    if (_namaToko.text.isEmpty ||
        _emailToko.text.isEmpty ||
        _passwordToko.text.isEmpty) {
      print("Please fill all the fields");
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
          _namaToko.text = '';
          _emailToko.text = '';
          _passwordToko.text = '';
          print('success');
          // return responseBody['success'];
        } else {
          return responseBody['error'];
          // Handle unsuccessful insertion (e.g., show an error message)
        }
      } else {
        print('error 200');
        // Handle server error (e.g., show an error message)
      }
    } catch (error) {
      print(error);
      // Handle network or other errors (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Insert Toko Record'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _namaToko,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter Nama Toko')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _emailToko,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter Email Toko')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _passwordToko,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter Password')),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: _insertRecord, child: Text('Insert')),
            ),
          ],
        ),
      ),
    );
  }
}
