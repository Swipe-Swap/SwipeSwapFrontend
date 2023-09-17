class SwapListing {
  double basePrice;
  bool canDeliver;
  String diningCourt;
  DateTime? initialTime;
  DateTime? expirationTime;
  int milePrice;
  int rangeMiles;
  String? sellerId;

  SwapListing({
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

  factory SwapListing.fromJson(Map<String, dynamic> responseData) {
    return SwapListing(
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

  static Map<String, dynamic> toJson(SwapListing listing) {
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
