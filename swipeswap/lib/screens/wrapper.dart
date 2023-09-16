import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipeswap/models/user.dart';
import 'package:swipeswap/screens/swaps.dart';
import 'package:swipeswap/screens/welcome.dart';

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
        SwapUser(
          email: user.email.toString(),
          userId: user.uid.toString(),
          rating: -1,
          fullName: user.displayName.toString(),
          timeCreated: DateTime(0),
        );
        debugPrint('User is signed in!');
        print(user);
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
    return FirebaseAuth.instance.currentUser == null ? Welcome() : Swaps();
  }
}
