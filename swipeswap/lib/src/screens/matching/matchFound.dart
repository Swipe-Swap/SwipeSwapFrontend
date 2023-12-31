import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/libraries/models.dart';
import 'package:swipeswap/src/models/seller_model.dart';
import 'package:swipeswap/src/utils/constants.dart';
import 'package:swipeswap/src/utils/order_card.dart';

/// Screen when sellers and buyers have been matched
/// - Stage dots
/// - Found a seller
/// - OrderCard widget
/// - Red & green toggle buttons
class MatchFound extends StatefulWidget {
  DiningCourt diningCourt;
  final docID;
  MatchFound({
    super.key,
    required this.docID,
    required this.diningCourt,
  });
  @override
  State<MatchFound> createState() => _MatchFoundState();
}

class _MatchFoundState extends State<MatchFound> {
  late final queueMatch;
  late final SellerModel seller;
  late final UserModel? user;
  late dynamic documentReference;
  late final Stream<QuerySnapshot> documentStream;
  late bool accept;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('queuedJobs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          if (!snapshot.hasData) {
            return const Text('Document does not exist');
          }
          // TODO: this logic needs to be coordinated w/ backend
          snapshot.data!.docs.forEach((doc) async {
            //
            // Take the listing data
            seller = SellerModel.fromJson(doc.data());
            user = await seller.getUser(seller.sellerPrefId);
            // Convert the listing data to the format
            Navigator.pushNamed(context, "/matchFound", arguments: queueMatch);
          });
          // for (int i = 0; i < snapshot.data!.docs.length; i++) {
          //   if (widget.docID.toString() ==
          //       snapshot.data!.docs[i]["listingId"]) {
          //     print(snapshot.data);
          //     queueMatch = snapshot.data;
          //     // TODO: convert to seller object?
          //     seller = SellerModel.fromJson(snapshot.data.jsify());
          //   } else {
          //     print(
          //         'no eligible seller found in queue. ${snapshot.data!.docs[i]["listingId"]}, ${widget.docID}');
          //   }
          // }

          return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/circle-2.png"),
                    SizedBox(height: 5.h),
                    Center(
                      child: Text(
                        "Found a Seller",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 45.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // TODO: get user data
                    OrderCard(
                      diningCourt: widget.diningCourt,
                      price: seller.basePrice.toString(),
                      // Get seller id by requesting firebase backend using sellerID
                      sellerName: user?.fullName ?? '',
                      sellerId: int.tryParse(seller.sellerPrefId ?? '') ?? 0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                accept = false;
                              });
                            },
                            child: Container(
                              height: 6.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: !accept ? kAccentRed : kSurface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text("No")),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                accept = true;
                              });
                            },
                            child: Container(
                              height: 6.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: accept ? kAccentGreen : kSurface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(child: Text("Yes")),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
