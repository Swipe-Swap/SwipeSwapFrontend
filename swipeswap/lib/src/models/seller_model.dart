/// A model for seller preferences; uses the ```sellers``` Firebase collection
///
/// @param double basePrice The base
/// @param bool canDeliver Whether the seller is willing to deliver or not
/// @param String diningCourt Which diningCourt(s) the seller is willing to deliver from
/// @param DateTime? initialTime
/// @param DateTime? expirationTime
/// @param int milePrice How much the seller is charging per mile for delivery
/// @param int rangeMiles How far the seller is willing to travel to deliver
/// @param String? sellerId The backend id of the seller
///
class SellerModel {
  double basePrice;
  bool canDeliver;
  String diningCourt;
  DateTime? initialTime;
  DateTime? expirationTime;
  int milePrice;
  int rangeMiles;
  String? sellerId;

  SellerModel({
    this.basePrice = 10,
    this.canDeliver = false,
    DateTime? initialTime,
    DateTime? expirationTime,
    required this.diningCourt,
    this.milePrice = 5,
    this.rangeMiles = 1,
    this.sellerId,
  })  : initialTime = initialTime ?? DateTime.now(),
        expirationTime =
            expirationTime ?? DateTime.now().add(const Duration(hours: 1));

  factory SellerModel.fromJson(Map<String, dynamic> responseData) {
    return SellerModel(
      basePrice: responseData['basePrice'],
      canDeliver: responseData['canDeliver'],
      diningCourt: responseData['diningCourt'],
      expirationTime: responseData['expirationTime'],
      milePrice: responseData['milePrice'],
      rangeMiles: responseData['rangeMiles'],
      initialTime: responseData['initialTime'],
      sellerId: responseData['sellerId'],
    );
  }

  static Map<String, dynamic> toJson(SellerModel listing) {
    return {
      "basePrice": listing.basePrice,
      "canDeliver": listing.canDeliver,
      "diningCourt": listing.diningCourt,
      "expirationTime": listing.expirationTime,
      "milePrice": listing.milePrice,
      "rangeMiles": listing.rangeMiles,
      "initialTime": listing.initialTime,
      "sellerId": listing.sellerId,
    };
  }
}
