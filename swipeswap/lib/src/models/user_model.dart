/// A model for handling and working with user data; corresponds to the ```users``` Firebase collection
///
/// @param String currentLocation The address of the user; DOES NOT TRACK users except for delivery purposes
/// @param DateTime dateCreated The date the user created their account. SET AUTOMATICALLY.
/// @param DateTime? date A temporary variable to initialize dateCreated. SET AUTOMATICALLY.
/// @param String fullName The full name of the user
/// @param String? uuid The backend id of the user
/// @param String email The email of the user
/// @param String phoneNumber The phone number of the user
class UserModel {
  String currentLocation;
  DateTime dateCreated;
  DateTime? date;
  String fullName;
  String? uuid;
  String email;
  String phoneNumber;
  // int? sellerRating;

  UserModel({
    required this.currentLocation,
    required this.fullName,
    required this.email,
    this.uuid,
    this.date,
    required this.phoneNumber,
    // this.sellerRating,
  }) : dateCreated = date ?? DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> responseData) {
    return UserModel(
      currentLocation: responseData['currentLocation'],
      fullName: responseData['fullName'],
      email: responseData['email'],
      uuid: responseData['uuid'],
      phoneNumber: responseData['phoneNumber'],
      // sellerRating: responseData["sellerRating"],
    );
  }

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      "currentLocation": user.currentLocation,
      "fullName": user.fullName,
      "email": user.email,
      "userId": user.uuid,
      "phoneNumber": user.phoneNumber,
      // "sellerRating": user.sellerRating,
    };
  }
}
