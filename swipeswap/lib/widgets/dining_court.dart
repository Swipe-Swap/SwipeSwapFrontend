import 'package:flutter/material.dart';
import 'package:swipeswap/screens/order.dart';
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
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Order(diningCourt: assetText.toLowerCase()))),
      child: Container(
        decoration: const BoxDecoration(
            color: kSurface,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Opacity(opacity: 0.8, child: Image.asset(assetPath)),
            Text(assetText),
          ],
        ),
      ),
    );
  }
}
