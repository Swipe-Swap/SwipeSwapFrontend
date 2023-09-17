import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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
            Text(
              "Exchange your swipe",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            // Dining court
            DropdownButtonFormField(
                value: diningCourt,
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
            // TODO: price
            TextFormField(
              controller: _maxPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Max base price (not accounting for delivery)",
              ),
              validator: Validatorless.multiple([
                Validatorless.min(1, 'The price must be greater than 1'),
                Validatorless.max(20, 'The price must be less than 20'),
                Validatorless.required("Price cannot be blank!")
              ]),
            ),
            // TODO: canDeliver
            // TODO: delivery fee (appears if can deliver)
            // TODO: button
          ],
        ),
      ),
    );
  }
}
