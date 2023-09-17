import 'package:flutter/material.dart';
import 'package:swipeswap/utils/constants.dart';

class OrderProvider extends ChangeNotifier {
  DiningCourt? diningCourt;

  void setDiningCourt(DiningCourt court) {
    diningCourt = court;
    notifyListeners();
  }
}
