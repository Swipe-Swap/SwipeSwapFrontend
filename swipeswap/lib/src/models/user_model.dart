import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:swipeswap/firebase_options.dart';
import 'package:swipeswap/libraries/utils.dart';

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
  String? messagingToken;
  // int? sellerRating;

  UserModel({
    required this.currentLocation,
    required this.fullName,
    required this.email,
    this.uuid,
    this.date,
    required this.phoneNumber,
    this.messagingToken,
    // this.sellerRating,
  }) : dateCreated = date ?? DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> responseData) {
    return UserModel(
        currentLocation: responseData['currentLocation'],
        fullName: responseData['fullName'],
        email: responseData['email'],
        uuid: responseData['uuid'],
        phoneNumber: responseData['phoneNumber'],
        messagingToken: responseData['messagingToken']
        // sellerRating: responseData["sellerRating"],
        );
  }

  static Future<Map<String, dynamic>> toJson(UserModel user) async {
    return {
      "currentLocation": user.currentLocation,
      "fullName": user.fullName,
      "email": user.email,
      "userId": user.uuid,
      "phoneNumber": user.phoneNumber,
      "messagingToken": user.messagingToken ?? await getMessagingToken(),
      // "sellerRating": user.sellerRating,
    };
  }

  /// Blocking function for retrieving the messaging token of the user
  /// Required for notifications
  static Future<String?> getMessagingToken() async {
    String? token = await messaging.getToken();

    // Register with FCM
    var vapidKey = FlutterConfig.get("VAPID_KEY");

    // use the registration token to send messages to users from your trusted server environment
    if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
      token = await messaging.getToken(
        vapidKey: vapidKey,
      );
    } else {
      token = await messaging.getToken();
    }

    if (kDebugMode) {
      print('Registration Token=$token');
    }

    return token;
  }
}
