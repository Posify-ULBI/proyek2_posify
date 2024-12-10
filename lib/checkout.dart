import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int nasiPadangCount = 2;
  int mojitoCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Pesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildToggleButton('Bungkus'),
                _buildToggleButton('Instan'),
                _buildToggleButton('Ditempat'),
              ],
            ),
            const SizedBox(height: 16),
            _buildOrderItem('Nasi Padang', 15000, nasiPadangCount, (value) {
              setState(() {
                nasiPadangCount = value;
              });
            }),
            const Divider(),
            _buildOrderItem('Mojito', 8000, mojitoCount, (value) {
              setState(() {
                mojitoCount = value;
              });
            }),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Ubah Pesanan
              },
              child: const Text(
                'Ubah Pesanan',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const Spacer(),
            _buildSummary(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Simpan Pesanan
                    },
                    child: const Text('Simpan',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Bayar Pesanan
                    },
                    child: const Text('Bayar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text, style: const TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _buildOrderItem(
      String name, int price, int count, Function(int) onCountChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 16)),
            Text('Rp $price,-',
                style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (count > 0) onCountChanged(count - 1);
              },
              icon: const Icon(Icons.remove, color: Colors.black),
            ),
            Text('$count', style: const TextStyle(fontSize: 16)),
            IconButton(
              onPressed: () {
                onCountChanged(count + 1);
              },
              icon: const Icon(Icons.add, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummary() {
    int subtotal = (nasiPadangCount * 15000) + (mojitoCount * 8000);
    int discount = 0;
    int total = subtotal - discount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryItem('Subtotal', subtotal),
        _buildSummaryItem('Diskon', discount),
        GestureDetector(
          onTap: () {
            // Hapus Pesanan
          },
          child: const Text(
            'Hapus Pesanan',
            style: TextStyle(color: Colors.red),
          ),
        ),
        const Divider(),
        _buildSummaryItem('Total', total, isBold: true),
      ],
    );
  }

  Widget _buildSummaryItem(String label, int amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text('Rp $amount,-',
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
