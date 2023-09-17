import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/models/order.dart';
import 'package:swipeswap/screens/order.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:swipeswap/utils/custom_nav_bar.dart';

/// Show listed, pending, completed, and expired orders
class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<SwapOrder> listedOrders = [];
  List<SwapOrder> pendingOrders = [];
  List<SwapOrder> completedOrders = [];
  List<SwapOrder> expiredOrders = [];

  @override
  void initState() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection("listings")
        .where("orderStatus", isEqualTo: OrderStatus.listed.toString())
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      SwapOrder order = SwapOrder.fromJson(docSnapshot.data());
      listedOrders.add(order);
    }

    querySnapshot = await db
        .collection("listings")
        .where("orderStatus", isEqualTo: OrderStatus.pending.toString())
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      SwapOrder order = SwapOrder.fromJson(docSnapshot.data());
      pendingOrders.add(order);
    }

    querySnapshot = await db
        .collection("listings")
        .where("orderStatus", isEqualTo: OrderStatus.completed.toString())
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      SwapOrder order = SwapOrder.fromJson(docSnapshot.data());
      completedOrders.add(order);
    }

    querySnapshot = await db
        .collection("listings")
        .where("orderStatus", isEqualTo: OrderStatus.expired.toString())
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      SwapOrder order = SwapOrder.fromJson(docSnapshot.data());
      expiredOrders.add(order);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Listed and pending at the top
    // Completed and expired below
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const CustomNavBar(),
      body: Column(children: [
        // Listed Orders
        (listedOrders.isNotEmpty)
            ? Text(
                "Listed Orders",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              )
            : const Placeholder(),
        (listedOrders.isNotEmpty) ? ListView() : const Placeholder(),
        // Pending Orders
        (pendingOrders.isNotEmpty)
            ? Text(
                "Pending Orders",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              )
            : const Placeholder(),
        (listedOrders.isNotEmpty) ? ListView() : const Placeholder(),
        // Completed Orders
        (completedOrders.isNotEmpty)
            ? Text(
                "Completed Orders",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              )
            : const Placeholder(),
        (completedOrders.isNotEmpty) ? ListView() : const Placeholder(),
        // Expired Orders
        (expiredOrders.isNotEmpty)
            ? Text(
                "Expired Orders",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              )
            : const Placeholder(),
        (expiredOrders.isNotEmpty) ? ListView() : const Placeholder(),
      ]),
    );
  }
}
