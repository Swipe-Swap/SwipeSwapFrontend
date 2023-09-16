import 'package:flutter/material.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:swipeswap/utils/routing.dart';

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
      onTap: () => navigateToRoute(context, Routes.order.toString()),
      child: Stack(
        children: [
          Image.asset(assetPath),
          Text(assetText),
        ],
      ),
    );
  }
}
