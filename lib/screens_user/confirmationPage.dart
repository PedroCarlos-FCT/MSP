import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final double amount;
  final String description;

  ConfirmationPage({required this.amount, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Payment confirmed!', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Text('Amount: \$${amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Description: $description', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}


