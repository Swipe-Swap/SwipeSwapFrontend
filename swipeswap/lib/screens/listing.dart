import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    symbol: '',
  );
  final TextEditingController _rangeMilesController = TextEditingController();
  final TimeOfDay _time =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1)));
  final TextEditingController _milePriceController = TextEditingController();
  final TextEditingController _basePriceController = TextEditingController();
  bool deliver = false;

  @override
  void initState() {
    super.initState();
    _basePriceController.text = _formatter.format('1000');
  }

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
                dropdownColor: kPrimaryColor1,
                value: diningCourt,
                items: [
                  for (DiningCourt court in DiningCourt.values)
                    DropdownMenuItem(
                      value: court.toString(),
                      child: Text(court.toString()),
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    diningCourt = value ?? diningCourt;
                  });
                }),
            // Base price
            TextFormField(
              controller: _basePriceController,
              // initialValue: _formatter.format('2000'),
              inputFormatters: <TextInputFormatter>[_formatter],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Base price for your swipe",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: kPrimaryColor2.withOpacity(0.2)),
              ),
            ),
            // Expiration time

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      deliver = false;
                    });
                  },
                  child: Container(
                    height: 6.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                      color: !deliver ? kAccentRed : kSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("No")),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      deliver = true;
                    });
                  },
                  child: Container(
                    height: 6.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                      color: deliver ? kAccentGreen : kSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Yes")),
                  ),
                ),
              ],
            ),
            deliver ? deliveryStuff() : const SizedBox(), // Submission Button
            ElevatedButton(
              onPressed: () async {
                // Submit data
                await db.collection("listings").add(
                      SwapListing.toJson(
                        SwapListing(
                          basePrice:
                              int.tryParse(_basePriceController.value.text) ??
                                  5,
                          canDeliver: deliver,
                          diningCourt: diningCourt,
                          initialTime: null,
                          // NOTE: hopefully this works
                          expirationTime: DateTime.tryParse(_time.toString()),
                          milePrice:
                              int.tryParse(_milePriceController.text) ?? 5,
                          rangeMiles:
                              int.tryParse(_rangeMilesController.text) ?? 1,
                          sellerId: FirebaseAuth.instance.currentUser?.uid,
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

  Column deliveryStuff() {
    return Column(
      children: [
        // Delivery fee
        Text(
          "Set your delivery fee (per mile)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        TextFormField(
          controller: _milePriceController,
          keyboardType: TextInputType.number,
          validator: Validatorless.multiple([
            Validatorless.min(1, 'The price must be greater than 1'),
            Validatorless.max(10, 'The price must be less than 20'),
            Validatorless.required("Price cannot be blank!")
          ]),
        ),
        // Range Miles
        Text(
          "How far are you willing to go to deliver?",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        TextFormField(
          controller: _rangeMilesController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
