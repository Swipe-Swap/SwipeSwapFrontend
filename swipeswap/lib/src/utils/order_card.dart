import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/providers.dart';
import 'package:swipeswap/src/models/user_model.dart';
import 'package:swipeswap/src/utils/constants.dart';
import 'package:swipeswap/widgets.dart';
import 'package:swipeswap/src/widgets/dining_court.dart';

/// Order card contains information about the order
/// Displayed on the Negotiation screen
class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

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
              assetPath: Asset.fromDiningCourt(Provider.of<OrderProvider>(context).diningCourt!),
              assetText: Provider.of<OrderProvider>(context).diningCourt.toString(),
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
