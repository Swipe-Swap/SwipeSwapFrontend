import 'package:flutter/material.dart';
import 'package:swipeswap/models/user.dart';

class UserProvider extends ChangeNotifier {
  SwapUser? user;

  void setUser(SwapUser swapUser) {
    user = swapUser;
    notifyListeners();
  }
}
