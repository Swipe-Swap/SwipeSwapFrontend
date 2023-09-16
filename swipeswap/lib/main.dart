// Flutter imports
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swipeswap/firebase_options.dart';

// Package imports
import 'package:swipeswap/screens/login.dart';
import 'package:swipeswap/screens/swaps.dart';
import 'package:swipeswap/screens/user.dart';
import 'package:swipeswap/screens/welcome.dart';
import 'package:swipeswap/utils/constants.dart';

// Third-party dependency imports
import 'package:provider/provider.dart';
import 'package:swipeswap/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    // MultiProvider(
    // providers: [
    // ChangeNotifierProvider<>(create: create),
    // ChangeNotifierProvider<>(create: create),
    // ChangeNotifierProvider<>(create: create),
    // ],
    // child: const SwipeSwap(),
    // ),
    const SwipeSwap(),
  );
}

class SwipeSwap extends StatelessWidget {
  const SwipeSwap({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwipeSwap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Wrapper(),
      routes: {
        Routes.welcome.toString(): (context) => const Welcome(),
        Routes.login.toString(): (context) => const Login(),
        Routes.swaps.toString(): (context) => const Swaps(),
        Routes.user.toString(): (context) => const User(),
      },
    );
  }
}
