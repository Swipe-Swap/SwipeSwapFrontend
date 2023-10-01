// Flutter imports
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeswap/firebase_options.dart';
import 'package:swipeswap/libraries/widgets.dart';
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
import 'package:flutter_config/flutter_config.dart';
import 'package:sizer/sizer.dart';
import 'package:rxdart/rxdart.dart';

// TODO: figure out handling interaction (https://firebase.flutter.dev/docs/messaging/notifications/#handling-interaction)

// Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Request permission
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // It requests a registration token for sending messages to users from your App server or other trusted server environment.

  // Set up foreground message handler
  // used to pass messages from event handler to the UI
  final _messageStreamController = BehaviorSubject<RemoteMessage>();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  });

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

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
        // Define custom exception page
        builder: (BuildContext context, Widget? widget) {
          // A custom error widget
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            // Should show a user-friendly error message
            throw Exception(errorDetails);
          };

          // Redirect to given widget or let the wrapper handle redirection
          return widget ?? const Wrapper();
        },
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
