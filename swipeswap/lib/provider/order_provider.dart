import 'package:flutter/material.dart';
import 'package:swipeswap/models/user.dart';
import 'package:swipeswap/utils/constants.dart';

class OrderProvider extends ChangeNotifier {
  DiningCourt? diningCourt;
  SwapUser? buyer;
  SwapUser? seller;

  void setDiningCourt(DiningCourt court) {
    diningCourt = court;
    notifyListeners();
  }

  void setBuyer(SwapUser user) {
    buyer = user;
    notifyListeners();
  }

  void setSeller(SwapUser swapUser) {
    seller = swapUser;
    notifyListeners();
  }
}
