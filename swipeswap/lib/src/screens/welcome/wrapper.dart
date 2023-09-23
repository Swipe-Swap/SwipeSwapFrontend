import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipeswap/src/models/user_model.dart';
import 'package:swipeswap/src/screens/home/swaps.dart';
import 'package:swipeswap/src/screens/welcome/welcome.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late StreamSubscription<User?> user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        // TODO: partly mock data
        // TODO: come back to
        UserModel(
          email: user.email.toString(),
          uuid: user.uid.toString(),
          currentLocation: "0, 0",
          // sellerRating: null,
          fullName: user.displayName.toString(),
          date: null,
          phoneNumber: user.phoneNumber.toString(),
        );
        debugPrint('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null
        ? const Welcome()
        : const Swaps();
  }
}