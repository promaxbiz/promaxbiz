import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final double footerHeight, footerWidth;
  const Footer({
    super.key,
    required this.footerHeight,
    required this.footerWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: footerWidth * 0.02, vertical: footerHeight * 0.02),
      height: footerHeight,
      width: footerWidth,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text("© ProMaxBiz 2025, All rights reserved."),
      ),
    );
  }
}
