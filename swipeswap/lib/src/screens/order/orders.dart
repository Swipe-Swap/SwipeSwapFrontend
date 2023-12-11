import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/src/models/order_model.dart';
import 'package:swipeswap/src/utils/constants.dart';

List<OrderModel> listedOrders = [];
List<OrderModel> pendingOrders = [];
List<OrderModel> completedOrders = [];
List<OrderModel> expiredOrders = [];

/// Show user's listed, pending, completed, and expired orders
/// TODO: add a way to access this regardless, Soham will write redirection wrapper in
/// the case of a currently accepted order
class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Listed and pending at the top
    // Completed and expired below
    return Scaffold(
      appBar: AppBar(),
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

Future init() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
      .collection("orders")
      .where("orderStatus", isEqualTo: OrderStatus.listed.toString())
      .get();

  for (var docSnapshot in querySnapshot.docs) {
    OrderModel order = OrderModel.fromJson(docSnapshot.data());
    listedOrders.add(order);
  }

  querySnapshot = await db
      .collection("orders")
      .where("orderStatus", isEqualTo: OrderStatus.pending.toString())
      .get();

  for (var docSnapshot in querySnapshot.docs) {
    OrderModel order = OrderModel.fromJson(docSnapshot.data());
    pendingOrders.add(order);
  }

  querySnapshot = await db
      .collection("orders")
      .where("orderStatus", isEqualTo: OrderStatus.completed.toString())
      .get();

  for (var docSnapshot in querySnapshot.docs) {
    OrderModel order = OrderModel.fromJson(docSnapshot.data());
    completedOrders.add(order);
  }

  querySnapshot = await db
      .collection("orders")
      .where("orderStatus", isEqualTo: OrderStatus.expired.toString())
      .get();

  for (var docSnapshot in querySnapshot.docs) {
    OrderModel order = OrderModel.fromJson(docSnapshot.data());
    expiredOrders.add(order);
  }
}
