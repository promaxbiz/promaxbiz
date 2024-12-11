import 'package:flutter/material.dart';
import 'package:promaxbiz/utils/constants.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      height: footerHeight,
      width: footerWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            assetMap["appBarBackground"]!,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text("© ProMaxBiz 2024"),
      ),
    );
  }
}
