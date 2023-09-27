import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/src/provider/order_provider.dart';
import 'package:swipeswap/src/models/user_model.dart';
import 'package:swipeswap/src/utils/constants.dart';
import 'package:swipeswap/src/widgets/dining_court.dart';

/// Order card contains information about the order
/// Displayed on the Negotiation screen
/// SellerName links to the seller profile
/// TODO: handling redirection and read-only authentication on user profile screen?
class OrderCard extends StatefulWidget {
  String price;
  String sellerName;
  int sellerId;
  OrderCard({
    super.key,
    required this.price,
    required this.sellerName,
    required this.sellerId,
    required DiningCourt diningCourt,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            DiningCourtWidget(
              assetPath: Asset.fromDiningCourt(
                  Provider.of<OrderProvider>(context).diningCourt!),
              assetText:
                  Provider.of<OrderProvider>(context).diningCourt.toString(),
            ),
            Column(
              children: [
                // Price
                Padding(
                  padding: EdgeInsets.fromLTRB(3.sp, 5.sp, 0.sp, 5.sp),
                  child: Text(
                    formatter.format(widget.price),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                ),
                // Delivery Instructions
                Padding(
                  padding: EdgeInsets.fromLTRB(3.sp, 5.sp, 0.sp, 5.sp),
                  child: Text(
                    formatter.format(widget.price),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                ),
                // Seller information
                GestureDetector(
                  // On tap, redirect user to sellers profile in read-only mode
                  onTap: () {
                    Navigator.pushNamed(context, Routes.user.toString(),
                        arguments: (widget.sellerId));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(3.sp, 5.sp, 0.sp, 5.sp),
                    child: Text(
                      "From ${widget.sellerName}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10.sp),
                    ),
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
