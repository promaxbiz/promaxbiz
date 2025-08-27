import 'package:flutter/material.dart';

class ImageIconLabel extends StatelessWidget {
  final String label, imageUrl;
  const ImageIconLabel({
    super.key,
    required this.label,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImageIcon(
            color: Theme.of(context).scaffoldBackgroundColor,
            AssetImage(
              imageUrl,
            ),
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
