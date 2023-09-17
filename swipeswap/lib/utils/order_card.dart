import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/models/user.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:swipeswap/widgets/dining_court.dart';

/// BRAINSTORMING:
/// I need to retrieve
class OrderCard extends StatefulWidget {
  DiningCourt diningCourt;
  OrderCard({super.key, required this.diningCourt});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  TODOORDERINFO = TODOORDERINFO;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            DiningCourtWidget(
              assetPath: Asset.fromDiningCourt(widget.diningCourt),
              assetText: widget.diningCourt.toString(),
            ),
            Column(
              children: [
                // Price
                Padding(
                  padding: EdgeInsets.fromLTRB(3.sp, 5.sp, 0.sp, 5.sp),
                  child: Text(
                    formatter.format(db.collection("queuedJobs").where("listingId", isEqualTo: "0").get()),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                ),
                // Delivery Instructions
                Padding(
                  padding: EdgeInsets.fromLTRB(3.sp, 5.sp, 0.sp, 5.sp),
                  child: Text(
                    formatter.format(TODOORDERINFO.price),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                ),
                // Seller information
                Padding(
                  padding: EdgeInsets.fromLTRB(3.sp, 5.sp, 0.sp, 5.sp),
                  child: Text(
                    "From ${TODOORDERINFO[sellerName]}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
