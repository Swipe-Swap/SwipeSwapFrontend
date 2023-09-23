import 'package:flutter/material.dart';
import 'package:swipeswap/src/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;

  void setUser(UserModel swapUser) {
    user = swapUser;
    notifyListeners();
  }
}
