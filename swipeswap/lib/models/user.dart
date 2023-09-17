class SwapUser {
  String currentLocation;
  DateTime dateCreated;
  DateTime? date;
  String fullName;
  String? userId;
  String email;
  String phoneNumber;
  // int? sellerRating;

  SwapUser({
    required this.currentLocation,
    required this.fullName,
    required this.email,
    this.userId,
    this.date,
    required this.phoneNumber,
    // this.sellerRating,
  }) : dateCreated = date ?? DateTime.now();

  factory SwapUser.fromJson(Map<String, dynamic> responseData) {
    return SwapUser(
      currentLocation: responseData['currentLocation'],
      fullName: responseData['fullName'],
      email: responseData['email'],
      userId: responseData['userId'],
      phoneNumber: responseData['phoneNumber'],
      // sellerRating: responseData["sellerRating"],
    );
  }

  static Map<String, dynamic> toJson(SwapUser user) {
    return {
      "currentLocation": user.currentLocation,
      "fullName": user.fullName,
      "email": user.email,
      "userId": user.userId,
      "phoneNumber": user.phoneNumber,
      // "sellerRating": user.sellerRating,
    };
  }
}
