import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text("© ProMaxBiz 2024"),
      ),
    );
  }
}
