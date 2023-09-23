import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/src/models/seller_model.dart';

/// Screen while sellers and buyers are being matched
class Matching extends StatefulWidget {
  final docID;
  const Matching({super.key, required this.docID});
  @override
  State<Matching> createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  late final SellerModel queueMatch;
  late dynamic documentReference;
  late final Stream<QuerySnapshot> documentStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
          // TODO: don't know what to do
          // There's multiple matches; how do we want to push them?
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            if (widget.docID.toString() ==
                snapshot.data!.docs[i]["listingId"]) {
              // Take the listing data
              queueMatch = SellerModel.fromJson(snapshot.data!.data());
              // Convert the listing data to the format
              Navigator.pushNamed(context, "/matchFound",
                  arguments: queueMatch);
            } else {
              print(
                  'no eligible seller found in queue. ${snapshot.data!.docs[i]["listingId"]}, ${widget.docID}');
            }
          }

          return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/circle-1.png"),
                    SizedBox(height: 5.h),
                    Image.asset("assets/images/findingSeller.png"),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Finding a Seller",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 45.sp),
                        textAlign: TextAlign.center,
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
