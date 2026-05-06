import 'package:flutter/material.dart';

class CreditWidget extends StatelessWidget {
  final int credits;

  const CreditWidget({super.key, required this.credits});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.credit_card, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            "Credits: $credits",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
