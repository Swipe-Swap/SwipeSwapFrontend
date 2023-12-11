import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:swipeswap/libraries/providers.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      user = FirebaseAuth.instance.authStateChanges().listen((user) async {
        if (user == null) {
          debugPrint('User is currently signed out!');
        } else {
          // TODO: partly mock data
          // TODO: come back to
          final CollectionReference userRef =
              FirebaseFirestore.instance.collection('/users');
          var userDoc = await userRef.doc(user.uid).get();
          var firebaseUser;
          if (userDoc.exists) {
            firebaseUser = UserModel(
              photoUrl: user.photoURL,
              email: user.email.toString(),
              uuid: user.uid.toString(),
              currentLocation: "0, 0",
              // sellerRating: null,
              fullName: user.displayName.toString(),
              date: null,
              phoneNumber: user.phoneNumber.toString(),
            );
          } else {
            debugPrint('Document, does not exist, creating user document...');

            firebaseUser = UserModel(
              photoUrl: user.photoURL,
              email: user.email.toString(),
              uuid: user.uid.toString(),
              currentLocation: "0, 0",
              // sellerRating: null,
              fullName: user.displayName.toString(),
              date: null,
              phoneNumber: user.phoneNumber.toString(),
            );
            await userRef.doc(user.uid).set(UserModel.toJson(firebaseUser));
            debugPrint("Created User Document in Firestore!");
          }
          Provider.of<UserProvider>(context, listen: false)
              .setUser(firebaseUser);
          debugPrint('User is signed in!');
        }
      });
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
