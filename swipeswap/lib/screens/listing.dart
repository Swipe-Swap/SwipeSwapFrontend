import 'package:flutter/material.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:swipeswap/widgets/custom_nav_bar.dart';
import 'package:swipeswap/widgets/dining_court.dart';

class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  String diningCourt = DiningCourt.earhart.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: Form(
        child: Column(
          children: [
            DropdownButtonFormField(
                value: diningCourt,
                decoration:
                    const InputDecoration(hintText: "Exchange your swipe"),
                items: [
                  for (DiningCourt diningCourt in DiningCourt.values)
                    DropdownMenuItem(
                      value: diningCourt.toString(),
                      child: DiningCourtWidget(
                        assetPath: Asset.fromDiningCourt(diningCourt),
                        assetText: diningCourt.toString(),
                      ),
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    diningCourt = value ?? diningCourt;
                  });
                }),
            // TODO: good font
            // TODO: price
            // TODO: canDeliver
            // TODO: delivery fee (appears if can deliver)
            // TODO: button
          ],
        ),
      ),
    );
  }
}
