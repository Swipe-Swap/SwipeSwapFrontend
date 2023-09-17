class SwapListing {
  int basePrice;
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
    DateTime? initial,
    DateTime? expiration,
    required this.diningCourt,
    this.milePrice = 5,
    this.rangeMiles = 1,
    this.sellerId,
  })  : initialTime = initial ?? DateTime.now(),
        expirationTime =
            expiration ?? DateTime.now().add(const Duration(hours: 1));

  factory SwapListing.fromJson(Map<String, dynamic> responseData) {
    return SwapListing(
      basePrice: responseData['basePrice'],
      canDeliver: responseData['canDeliver'],
      diningCourt: responseData['diningCourt'],
      expiration: responseData['expirationTime'],
      milePrice: responseData['milePrice'],
      rangeMiles: responseData['rangeMiles'],
      initial: responseData['initialTime'],
      sellerId: responseData['sellerId'],
    );
  }

  static Map<String, dynamic> toJson(SwapListing listing) {
    return {
      "basePrice": listing.basePrice,
      "canDeliver": listing.canDeliver,
      "diningCourt": listing.diningCourt,
      "expiration": listing.expirationTime,
      "milePrice": listing.milePrice,
      "rangeMiles": listing.rangeMiles,
      "initial": listing.initialTime,
      "sellerId": listing.basePrice,
    };
  }
}
