import 'package:flutter/material.dart';
import 'package:swipeswap/utils/constants.dart';

class DiningCourtWidget extends StatelessWidget {
  final String assetPath;
  final String assetText;
  const DiningCourtWidget({
    super.key,
    required this.assetPath,
    required this.assetText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.order.toString()),
      child: Stack(
        children: [
          Image.asset(assetPath),
          Text(assetText),
        ],
      ),
    );
  }
}
