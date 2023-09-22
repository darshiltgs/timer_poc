import 'package:flutter/material.dart';
import 'package:timer_poc/razorpay/payment_screen.dart';
import 'package:timer_poc/timer/countdown_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentScreen(),
    );
  }
}
