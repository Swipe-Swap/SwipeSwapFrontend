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
  late final Stream<QuerySnapshot<Map<String, dynamic>>> documentStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(

        /// Retrieve queuedJobs sorted by queueNum ascending for the current order
        stream: FirebaseFirestore.instance
            .collection('queuedJobs')
            .where('orderId' == widget.docID)
            .orderBy("queueNum", descending: false)
            .snapshots(),
        // NOTE: firebase cloud messaging will handle notifying sellers
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData) {
            return const Text('Document does not exist');
          }
          else {
            snapshot.data!.docs.forEach((doc) { 
              // 
              // Take the listing data
              queueMatch = SellerModel.fromJson(snapshot.data!.);
              // Convert the listing data to the format
              Navigator.pushNamed(context, "/matchFound",
                  arguments: queueMatch);
            });
            // TODO: reworking the below code above
          //   for (int i = 0; i < snapshot.data!.docs.length; i++) {
          //     if (widget.docID.toString() ==
          //         snapshot.data!.docs[i]["listingId"]) {
          //       // Take the listing data
          //       queueMatch = SellerModel.fromJson(snapshot.data!.);
          //       // Convert the listing data to the format
          //       Navigator.pushNamed(context, "/matchFound",
          //           arguments: queueMatch);
          //     } else {
          //       print(
          //           'no eligible seller found in queue. ${snapshot.data!.docs[i]["listingId"]}, ${widget.docID}');
          //     }
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
