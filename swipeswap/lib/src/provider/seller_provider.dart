import 'package:flutter/material.dart';
import 'package:swipeswap/src/models/user_model.dart';
import 'package:swipeswap/src/utils/constants.dart';

/// A provider for handling and updating seller information
///
/// @param diningCourt Currently, the seller is limited to one [DiningCourt]
/// @param seller The seller's [UserModel] information
class SellerProvider extends ChangeNotifier {
  DiningCourt? diningCourt;
  UserModel? seller;

  void setDiningCourt(DiningCourt court) {
    diningCourt = court;
    notifyListeners();
  }

  void setSeller(UserModel swapUser) {
    seller = swapUser;
    notifyListeners();
  }
}
