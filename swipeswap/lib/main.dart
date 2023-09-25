// Flutter imports
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeswap/firebase_options.dart';
import 'package:swipeswap/src/provider/order_provider.dart';
import 'package:swipeswap/src/provider/screen_provider.dart';
import 'package:swipeswap/src/provider/user_provider.dart';
import 'package:swipeswap/src/screens/home/seller.dart';

// Package imports
import 'package:swipeswap/src/screens/order/order.dart';
import 'package:swipeswap/src/screens/home/swaps.dart';
import 'package:swipeswap/src/screens/home/profile.dart';
import 'package:swipeswap/src/screens/welcome/welcome.dart';
import 'package:swipeswap/src/utils/constants.dart';
import 'package:swipeswap/src/screens/welcome/wrapper.dart';

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
        ChangeNotifierProvider<ScreenProvider>(
            create: (context) => ScreenProvider()),
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
            iconTheme: IconThemeData(
              color: kPrimaryColor2,
            ),
            backgroundColor: kPrimaryColor1,
          ),
          iconTheme: const IconThemeData(color: kPrimaryColor1),
          useMaterial3: true,
        ),
        home: const Wrapper(),
        routes: {
          Routes.welcome.toString(): (context) => const Welcome(),
          Routes.swaps.toString(): (context) => const Swaps(),
          Routes.user.toString(): (context) => const Profile(),
          Routes.order.toString(): (context) => const Order(),
          Routes.seller.toString(): (context) => const Seller(),
        },
      );
    });
  }
}
