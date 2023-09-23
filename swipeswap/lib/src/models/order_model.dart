import 'package:swipeswap/src/utils/constants.dart';

/// A model for buyer preferences; uses the ```orders``` Firebase collection
///
/// @param String deliveryInstructions Instructions for where the order should be delivered
/// @param String deliveryLocation Location where the order should be delivered
/// @param String diningCourt The diningCourt where food should be retrieved from
/// @param bool isDelivery Whether the food should be delivered or not
/// @param String orderDetails Details of the order, e.g. food content
/// @param OrderStatus orderStatus Whether the order has been delivered or not; see [OrderStatus] for more
/// @param String? buyerId The backend id of the buyer
/// @param String? sellerId The backend id of the seller
/// @param DateTime? timeListed The time of the order's creation
/// @param int maxPrice The maximum price the buyer is willing to pay

class OrderModel {
  String deliveryInstructions;
  String deliveryLocation;
  String diningCourt;
  bool isDelivery;
  String orderDetails;
  OrderStatus orderStatus;
  String? buyerId;
  String? sellerId;
  DateTime? timeListed;
  int maxPrice;

  OrderModel({
    required this.deliveryInstructions,
    required this.deliveryLocation,
    required this.diningCourt,
    this.isDelivery = false,
    required this.orderDetails,
    required this.orderStatus,
    this.buyerId,
    this.sellerId,
    DateTime? timeListed,
    this.maxPrice = 10,
  }) : timeListed = timeListed ?? DateTime.now();

  factory OrderModel.fromJson(Map<String, dynamic> responseData) {
    return OrderModel(
      deliveryInstructions: responseData['deliveryInstructions'],
      deliveryLocation: responseData['deliveryLocation'],
      diningCourt: responseData['diningCourt'],
      isDelivery: responseData['isDelivery'],
      orderDetails: responseData['orderDetails'],
      orderStatus: OrderStatus.fromString(responseData['orderStatus']),
      buyerId: responseData['buyerId'],
      sellerId: responseData['sellerId'],
      timeListed: responseData['timeListed'],
      maxPrice: responseData['maxPrice'],
    );
  }

  static Map<String, dynamic> toJson(OrderModel order) {
    return {
      "deliveryInstructions": order.deliveryInstructions,
      "deliveryLocation": order.deliveryLocation,
      "diningCourt": order.diningCourt,
      "isDelivery": order.isDelivery,
      "orderDetails": order.orderDetails,
      "orderStatus": order.orderStatus.toString(),
      "buyerId": order.buyerId,
      "sellerId": order.sellerId,
      "timeListed": order.timeListed,
    };
  }
}
