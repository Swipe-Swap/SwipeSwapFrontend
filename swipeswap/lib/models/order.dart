import 'package:swipeswap/utils/constants.dart';

class SwapOrder {
  String deliveryInstructions;
  String deliveryLocation;
  String diningCourt;
  bool isDelivery;
  String orderDetails;
  OrderStatus orderStatus;
  String? buyerId;
  String? sellerId;

  SwapOrder({
    required this.deliveryInstructions,
    required this.deliveryLocation,
    required this.diningCourt,
    this.isDelivery = false,
    required this.orderDetails,
    required this.orderStatus,
    this.buyerId,
    this.sellerId,
  });

  factory SwapOrder.fromJson(Map<String, dynamic> responseData) {
    return SwapOrder(
      deliveryInstructions: responseData['deliveryInstructions'],
      deliveryLocation: responseData['delivryLocation'],
      diningCourt: responseData['diningCourt'],
      isDelivery: responseData['isDelivery'],
      orderDetails: responseData['orderDetails'],
      orderStatus: OrderStatus.fromString(responseData['orderStatus']),
      buyerId: responseData['buyerId'],
      sellerId: responseData['sellerId'],
    );
  }

  static Map<String, dynamic> toJson(SwapOrder order) {
    return {
      "deliveryInstructions": order.deliveryInstructions,
      "deliveryLocation": order.deliveryLocation,
      "diningCourt": order.diningCourt,
      "isDelivery": order.isDelivery,
      "orderDetails": order.orderDetails,
      "orderStatus": order.orderStatus,
      "buyerId": order.buyerId,
      "sellerId": order.sellerId,
    };
  }
}
