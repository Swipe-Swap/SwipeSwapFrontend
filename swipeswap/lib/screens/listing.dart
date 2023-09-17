import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/models/listing.dart';
import 'package:swipeswap/provider/listing_provider.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:validatorless/validatorless.dart';

class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  String diningCourt = DiningCourt.earhart.toString();
  final TextEditingController _rangeMilesController = TextEditingController();
  final TimeOfDay _time =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1)));
  final TextEditingController _milePriceController = TextEditingController();
  final TextEditingController _basePriceController = TextEditingController();
  final List<bool> _delivery = [true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        value: diningCourt.toString(), child: const Text("earhart")),
                ],
                onChanged: (value) {
                  setState(() {
                    diningCourt = value ?? diningCourt;
                  });
                }),
            // Base price
            TextFormField(
              controller: _basePriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText:
                    "Base price for your swipe (not accounting for delivery)",
                hintStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
              validator: Validatorless.multiple([
                Validatorless.min(1, 'The price must be greater than 1'),
                Validatorless.max(20, 'The price must be less than 20'),
                Validatorless.required("Price cannot be blank!")
              ]),
            ),
            // Expiration time
            Text(
              "How long do you want the listing to be available?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       setState(() async {
            //         _time = await showDialog(
            //             context: context,
            //             builder: (context) =>
            //                 TimePickerDialog(initialTime: _time));
            //       });
            //     },
            //     child: Text(_time.toString())),
            // Delivery boolean
            Text(
              "Would you be willing to deliver?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            ToggleButtons(
              isSelected: const [true, false],
              children: const [Text("Pickup"), Text("Deliver")],
              onPressed: (value) {
                setState(() {
                  _delivery[value] = !_delivery[value];
                });
              },
            ),
            // Delivery fee
            Text(
              "Set your delivery fee (per mile)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            (_delivery[0])
                ? TextFormField(
                    controller: _milePriceController,
                    keyboardType: TextInputType.number,
                    validator: Validatorless.multiple([
                      Validatorless.min(1, 'The price must be greater than 1'),
                      Validatorless.max(10, 'The price must be less than 20'),
                      Validatorless.required("Price cannot be blank!")
                    ]),
                  )
                : const Placeholder(),
            // Range Miles
            Text(
              "How far are you willing to go to deliver?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            TextFormField(
              controller: _rangeMilesController,
              keyboardType: TextInputType.number,
            ),
            // Submission Button
            ElevatedButton(
              onPressed: () {
                // Submit data
                db.collection("listings").add(
                      SwapListing.toJson(
                        SwapListing(
                          basePrice:
                              int.tryParse(_basePriceController.value.text) ??
                                  5,
                          canDeliver: _delivery[0],
                          diningCourt: diningCourt,
                          initial: null,
                          // NOTE: hopefully this works
                          expiration: DateTime.tryParse(_time.toString()),
                          milePrice:
                              int.tryParse(_milePriceController.text) ?? 5,
                          rangeMiles:
                              int.tryParse(_rangeMilesController.text) ?? 1,
                          sellerId: Provider.of<ListingProvider>(context,
                                  listen: false)
                              .seller
                              ?.uuid,
                        ),
                      ),
                    );
              },
              child: const Text("Submit?"),
            ),
          ],
        ),
      ),
    );
  }
}
