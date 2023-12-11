import 'package:flutter/material.dart';
import 'package:swipeswap/src/models/user_model.dart';
import 'package:swipeswap/src/utils/constants.dart';

/// A provider for updating and managing buyer information
///
/// @param DiningCourt? diningCourt The [DiningCourt] associated with the order
/// @param UserModel? buyer The buyer ([UserModel]) associated with the order
/// @param UserModel? seller The seller ([UserModel]) associated with the order
class OrderProvider extends ChangeNotifier {
  DiningCourt? diningCourt;
  UserModel? buyer;
  UserModel? seller;

  void setDiningCourt(DiningCourt court) {
    diningCourt = court;
    notifyListeners();
  }

  void setBuyer(UserModel user) {
    buyer = user;
    notifyListeners();
  }

  void setSeller(UserModel swapUser) {
    seller = swapUser;
    notifyListeners();
  }
}
