import 'package:flutter/material.dart';
import 'package:swipeswap/src/screens/home/swaps.dart';

/// A provider for handling navigation
///
/// @param selectedTab Takes on a [SelectedTab] value
class ScreenProvider extends ChangeNotifier {
  var selectedTab = SelectedTab.home;

  void setTab(int tab) {
    selectedTab = SelectedTab.values[tab];
    notifyListeners();
  }
}
