import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipeswap/src/provider/order_provider.dart';
import 'package:swipeswap/src/screens/order/order.dart';
import 'package:swipeswap/src/utils/constants.dart';

/// A widget for displaying the dining courts
///
/// @param assetPath Path to the asset (dining court image)
/// @param assetText Text of the asset (dining court)
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
      onTap: () {
        // Write to order provider
        debugPrint(assetText);
        Provider.of<OrderProvider>(context, listen: false)
            .setDiningCourt(DiningCourt.fromString(assetText));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Order(),
          ),
        );
      },
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
