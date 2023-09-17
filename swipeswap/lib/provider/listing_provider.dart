import 'package:flutter/material.dart';
import 'package:swipeswap/models/user.dart';
import 'package:swipeswap/utils/constants.dart';

class ListingProvider extends ChangeNotifier {
  DiningCourt? diningCourt;
  SwapUser? seller;

  void setDiningCourt(DiningCourt court) {
    diningCourt = court;
    notifyListeners();
  }

  void setSeller(SwapUser swapUser) {
    seller = swapUser;
    notifyListeners();
  }
}
