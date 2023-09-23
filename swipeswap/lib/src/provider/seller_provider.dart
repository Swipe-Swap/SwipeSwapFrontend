import 'package:flutter/material.dart';
import 'package:swipeswap/src/models/user_model.dart';
import 'package:swipeswap/src/utils/constants.dart';

/// A provider
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
