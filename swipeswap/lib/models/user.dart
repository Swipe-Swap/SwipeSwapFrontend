class SwapUser {
  String currentLocation;
  DateTime dateCreated;
  String fullName;
  String? userId;
  String phoneNumber;
  int? sellerRating;

  SwapUser({
    required this.currentLocation,
    this.dateCreated,
    required this.fullName,
    this.userId,
    required this.phoneNumber,
    this.sellerRating,
  }) : initialTime = initial ?? DateTime.now();

  factory SwapUser.fromJson(Map<String, dynamic> responseData) {
    return SwapUser(
        userId: responseData['id'],
        fullName: responseData['fullName'],
        timeCreated: responseData['timeCreated'],
        rating: responseData['rating']);
  }

  static Map<String, dynamic> toJson(SwapUser user) {
    return {
      "deliveryInstructions": order.deliveryInstructions,
      "deliveryLocation": order.deliveryLocation,
      "diningCourt": order.diningCourt,
      "isDelivery": order.isDelivery,
      "orderDetails": order.orderDetails,
      "orderStatus": order.orderStatus,
    };
  }
}
