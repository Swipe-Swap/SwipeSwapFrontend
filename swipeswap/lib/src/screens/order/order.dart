import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/src/models/order_model.dart';
import 'package:swipeswap/src/provider/order_provider.dart';
import 'package:swipeswap/src/screens/matching/matching.dart';
import 'package:swipeswap/src/utils/constants.dart';
import 'package:validatorless/validatorless.dart';

/// Form for submitting an order to be fulfilled
class Order extends StatefulWidget {
  const Order({
    super.key,
  });

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String diningCourt = '';
  final formKey = GlobalKey<FormState>();
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    symbol: '',
  );
  TextEditingController orderDetailsController = TextEditingController();
  TextEditingController deliveryInstructionsController =
      TextEditingController();
  String maxPrice = "1000";
  var docId;
  String deliveryLocation = '';
  bool delivery = false;
  @override
  void initState() {
    // Register callback that runs post first frame
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String diningCourtValue =
          Provider.of<OrderProvider>(context, listen: false)
              .diningCourt
              .toString();
      setState(() {
        diningCourt = diningCourtValue;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: numSellers(int.tryParse(maxPrice) ?? 10),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  // Title
                  Text(
                    "Order from $diningCourt",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                  // Max base price
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(15.0.sp),
                      child: Text(
                        "Set your maximum price",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(7.sp, 5.sp, 0, 0),
                          child: SizedBox(
                            height: 2.h,
                            width: 20.w,
                            child: TextFormField(
                              initialValue: _formatter.format(maxPrice),
                              inputFormatters: <TextInputFormatter>[_formatter],
                              decoration: InputDecoration(
                                hintText: _formatter.format("10.00"),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  maxPrice = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  (snapshot.hasData)
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Text(
                              "${snapshot.data} sellers are available at this base price",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 7.sp,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  // Order details
                  SizedBox(
                    height: 3.h,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      // height: 10.h,
                      child: Text(
                        "Order Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 8.h,
                      width: 80.w,
                      child: TextFormField(
                        controller: orderDetailsController,
                        validator:
                            Validatorless.required("Order cannot be blank!"),
                        decoration: const InputDecoration(
                          // labelText: ,
                          border: OutlineInputBorder(),

                          hintText: "Type details about your order here!",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(15.0.sp),
                      child: Text(
                        "Would you like your order to be delivered?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10.sp),
                    child: Row(
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
                            child: const Center(child: Text("No")),
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
                            child: const Center(child: Text("Yes")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TEMPLATE CODE: Location
                  // (delivery)
                  //     ? Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: Padding(
                  //           padding: EdgeInsets.fromLTRB(15.sp, 5.sp, 0, 5.sp),
                  //           child: Text(
                  //             "Delivery Location",
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold, fontSize: 15.sp),
                  //           ),
                  //         ),
                  //       )
                  //     : const SizedBox(),
                  (delivery)
                      // MAPS CODE
                      ? SizedBox(
                          height: 500,
                          width: 500,
                          child: MapLocationPicker(
                            apiKey: dotenv.env['API_KEY']!,
                            onNext: (GeocodingResult? result) {
                              if (result != null) {
                                deliveryLocation =
                                    result.formattedAddress ?? "";
                              }
                            },
                          ),
                        )
                      : const SizedBox(),
                  // ? Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Padding(
                  //       padding: EdgeInsets.fromLTRB(15.sp, 0.sp, 0, 0.sp),
                  //       child: SizedBox(
                  //         height: 8.h,
                  //         width: 60.w,
                  //         child: TextFormField(
                  //           // temporarily readonly
                  //           readOnly: true,
                  //           initialValue:
                  //               "Ex: 355 N Martin Jischke Dr, West Lafayette, IN 47906",
                  //           decoration: const InputDecoration(
                  //             hintStyle: TextStyle(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   )
                  // : const SizedBox(),

                  // Delivery instructions
                  (delivery)
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15.sp, 5.sp, 0, 0),
                            child: Text(
                              "Delivery Instructions",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  (delivery)
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15.sp, 0.sp, 0, 0.sp),
                            child: SizedBox(
                              height: 5.h,
                              width: 60.w,
                              child: TextFormField(
                                controller: deliveryInstructionsController,
                                decoration: const InputDecoration(
                                  hintText:
                                      "Special instructions for your delivery (optional)",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.sp),
                    child: ElevatedButton(
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
                                OrderModel.toJson(
                                  OrderModel(
                                    deliveryInstructions:
                                        deliveryInstructionsController.text,
                                    deliveryLocation: deliveryLocation,
                                    diningCourt: diningCourt,
                                    isDelivery: delivery,
                                    orderDetails: orderDetailsController.text,
                                    orderStatus: OrderStatus.listed,
                                    buyerId:
                                        FirebaseAuth.instance.currentUser?.uid,
                                    sellerId: "",
                                    timeListed: null,
                                    maxPrice: int.tryParse(maxPrice) ?? 10,
                                  ),
                                ),
                              )
                              .then((DocumentReference doc) => docId = doc.id);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Matching(docID: docId)));
                        }
                      },
                      child: const Text("Submit?"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

/// Retrieve numSellers
Future<int> numSellers(int maxBasePrice) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
      .collection("listings")
      .where("basePrice", isLessThanOrEqualTo: maxBasePrice)
      .get();

  return querySnapshot.size;
}
