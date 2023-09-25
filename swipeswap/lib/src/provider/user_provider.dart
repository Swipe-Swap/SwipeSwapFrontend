import 'package:flutter/material.dart';
import 'package:swipeswap/src/models/user_model.dart';

/// Provider for updating the users information
///
/// @param user The user's [UserModel] object
class UserProvider extends ChangeNotifier {
  UserModel? user;

  void setUser(UserModel userObj) {
    user = userObj;
    notifyListeners();
  }
}
