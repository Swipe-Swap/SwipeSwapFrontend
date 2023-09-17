// Flutter imports
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeswap/firebase_options.dart';
import 'package:swipeswap/provider/order_provider.dart';
import 'package:swipeswap/provider/user_provider.dart';

// Package imports
import 'package:swipeswap/screens/login.dart';
import 'package:swipeswap/screens/order.dart';
import 'package:swipeswap/screens/swaps.dart';
import 'package:swipeswap/screens/user.dart';
import 'package:swipeswap/screens/welcome.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:swipeswap/screens/wrapper.dart';

// Third-party dependency imports
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<OrderProvider>(
            create: (context) => OrderProvider()),
        // ChangeNotifierProvider<ListingProvider>(create: create),
      ],
      child: const SwipeSwap(),
    ),
    // const SwipeSwap(),
  );
}

class SwipeSwap extends StatelessWidget {
  const SwipeSwap({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SwipeSwap',
        theme: ThemeData(
          scaffoldBackgroundColor: kPrimaryColor1,
          textTheme: GoogleFonts.latoTextTheme(
              textTheme.apply(bodyColor: kPrimaryColor2)),
          appBarTheme: const AppBarTheme(
            backgroundColor: kPrimaryColor1,
          ),
          useMaterial3: true,
        ),
        home: const Wrapper(),
        routes: {
          Routes.welcome.toString(): (context) => const Welcome(),
          Routes.login.toString(): (context) => const Login(),
          Routes.swaps.toString(): (context) => const Swaps(),
          Routes.user.toString(): (context) => const User(),
          Routes.order.toString(): (context) => const Order(),
        },
      );
    });
  }
}
