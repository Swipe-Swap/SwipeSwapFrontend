// Flutter imports
import 'package:flutter/material.dart';

// Package imports
import 'package:swipeswap/screens/login.dart';
import 'package:swipeswap/screens/register.dart';
import 'package:swipeswap/screens/swaps.dart';
import 'package:swipeswap/screens/user.dart';
import 'package:swipeswap/screens/welcome.dart';
import 'package:swipeswap/utils/constants.dart';

// Third-party dependency imports
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<>(create: create),
      ChangeNotifierProvider<>(create: create),
      ChangeNotifierProvider<>(create: create),
    ],
    child: const SwipeSwap(),
  ));
}

class SwipeSwap extends StatelessWidget {
  const SwipeSwap({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwipeSwap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Welcome(),
      routes: {
        Routes.welcome.toString(): (context) => Welcome(),
        Routes.login.toString(): (context) => Login(),
        Routes.register.toString(): (context) => Register(),
        Routes.swaps.toString(): (context) => Swaps(),
        Routes.user.toString(): (context) => User(),
      },
    );
  }
}
