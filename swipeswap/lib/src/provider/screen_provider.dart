import 'package:flutter/material.dart';
import 'package:swipeswap/src/screens/home/profile.dart';
import 'package:swipeswap/src/screens/home/seller.dart';
import 'package:swipeswap/src/screens/home/swaps.dart';

class ScreenProvider extends ChangeNotifier {
  var selectedTab = SelectedTab.home;
  late final pages = [swapsGrid(), const Seller(), const Profile()];

  void setTab(int tab) {
    selectedTab = SelectedTab.values[tab];
    notifyListeners();
  }
}
