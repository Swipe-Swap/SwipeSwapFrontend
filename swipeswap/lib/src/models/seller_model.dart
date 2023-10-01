import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipeswap/libraries/models.dart';

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
  DateTime? timeListed;
  DateTime? expirationTime;
  int milePrice;
  int rangeMiles;
  String? sellerPrefId;
  Map<String, dynamic>? userInstance;

  /// Retrieve user
  Future<UserModel?> getUser(String? sellerId) async {
    if (sellerId == null) {
      return null;
    }

    DocumentSnapshot sellerDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(sellerId)
        .get();

    if (sellerDoc.exists) {
      return UserModel.fromJson(sellerDoc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  SellerModel({
    this.basePrice = 10,
    this.canDeliver = false,
    DateTime? initialTime,
    DateTime? expirationTime,
    required this.diningCourt,
    this.milePrice = 5,
    this.rangeMiles = 1,
    this.sellerPrefId,
  })  : timeListed = initialTime ?? DateTime.now(),
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
      initialTime: responseData['timeListed'],
      sellerPrefId: responseData['sellerPrefId'],
    );
  }

  static Map<String, dynamic> toJson(SellerModel sellerPref) {
    return {
      "basePrice": sellerPref.basePrice,
      "canDeliver": sellerPref.canDeliver,
      "diningCourt": sellerPref.diningCourt,
      "expirationTime": sellerPref.expirationTime,
      "milePrice": sellerPref.milePrice,
      "rangeMiles": sellerPref.rangeMiles,
      "initialTime": sellerPref.timeListed,
      "sellerPrefId": sellerPref.sellerPrefId,
    };
  }
}
