import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/models/order.dart';
import 'package:swipeswap/provider/order_provider.dart';
import 'package:swipeswap/provider/user_provider.dart';
import 'package:swipeswap/screens/matching/matching.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:validatorless/validatorless.dart';

class Order extends StatefulWidget {
  final String diningCourt;
  const Order({
    super.key,
    required this.diningCourt,
  });

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final formKey = GlobalKey<FormState>();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter();
  TextEditingController orderDetailsController = TextEditingController();
  TextEditingController deliveryInstructionsController =
      TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  var docId;
  String deliveryLocation = '';
  bool delivery = false;
  @override
  void initState() {
    super.initState();
    maxPriceController.text = _formatter.format('1000');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Items to order
            TextFormField(
              controller: orderDetailsController,
              decoration: const InputDecoration(
                hintText: "Your order",
              ),
              validator: Validatorless.required("Order cannot be blank!"),
            ),
            // Max base price
            TextFormField(
              controller: maxPriceController,
              // initialValue: _formatter.format('2000'),
              inputFormatters: <TextInputFormatter>[_formatter],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  // hintText: "Max base price (not accounting for delivery)",
                  ),
            ),
            // Location
            (delivery)
                ? SizedBox(
                    height: 500,
                    width: 500,
                    child: MapLocationPicker(
                      apiKey: dotenv.env['API_KEY']!,
                      onNext: (GeocodingResult? result) {
                        if (result != null) {
                          deliveryLocation = result.formattedAddress ?? "";
                        }
                      },
                    ),
                  )
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      delivery = false;
                    });
                  },
                  child: Container(
                    height: 6.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                      color: !delivery ? kAccentRed : kSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("No")),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      delivery = true;
                    });
                  },
                  child: Container(
                    height: 6.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                      color: delivery ? kAccentGreen : kSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Yes")),
                  ),
                ),
              ],
            ),

            // Delivery instructions
            (delivery)
                ? TextFormField(
                    controller: deliveryInstructionsController,
                    decoration: const InputDecoration(
                      hintText: "Delivery instructions",
                    ),
                  )
                : const SizedBox(),
            ElevatedButton(
              onPressed: () async {
                // Run validator for address
                if (deliveryLocation.isEmpty && delivery) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Address must be specified for an order to be delivered!"),
                    ),
                  );
                } else {
                  // Submit data
                  await db
                      .collection("orders")
                      .add(
                        SwapOrder.toJson(
                          SwapOrder(
                              deliveryInstructions:
                                  deliveryInstructionsController.text,
                              deliveryLocation: deliveryLocation,
                              diningCourt: widget.diningCourt,
                              isDelivery: delivery,
                              orderDetails: orderDetailsController.text,
                              orderStatus: OrderStatus.listed,
                              buyerId: FirebaseAuth.instance.currentUser?.uid,
                              sellerId: "",
                              timeListed: null),
                        ),
                      )
                      .then((DocumentReference doc) => docId = doc.id);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Matching(docID: docId)));
                }
              },
              child: const Text("Submit?"),
            ),
          ],
        ),
      ),
    );
  }
}
