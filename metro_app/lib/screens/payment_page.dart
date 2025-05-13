import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String baseUrl = 'https://f503-41-233-107-206.ngrok-free.app';

class PaymentPage extends StatefulWidget {
  final double currentAmount;

  const PaymentPage({super.key, required this.currentAmount});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _controller = TextEditingController();

  void startPayment() async {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('يرجى إدخال المبلغ أولاً')));
      return;
    }

    final double? enteredAmount = double.tryParse(text);
    if (enteredAmount == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('يرجى إدخال رقم صحيح')));
      return;
    }

    final url = Uri.parse('$baseUrl/pay?amount=$enteredAmount');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      // بعد نجاح الفتح، نرجع القيمة المدخلة
      Navigator.pop(context, enteredAmount);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('تعذر فتح صفحة الدفع')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('زود رصيدك'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'ادخل المبلغ المطلوب',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: startPayment, child: Text('ادفع')),
          ],
        ),
      ),
    );
  }
}
