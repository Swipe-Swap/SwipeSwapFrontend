import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:swipeswap/src/screens/home/profile.dart';
import 'package:swipeswap/src/screens/home/seller.dart';
import 'package:swipeswap/src/screens/home/swaps.dart';
// import 'package:swipeswap/screens/seller.dart';

final db = FirebaseFirestore.instance;
final CurrencyTextInputFormatter formatter =
    CurrencyTextInputFormatter(symbol: '');
final tabs = [swapsGrid(), const Seller(), const Profile()];

/// Enum containing routes
enum Routes {
  welcome,
  login,
  register,
  swaps,
  seller,
  user,
  order,
  orders,
  matching;

  @override
  String toString() {
    switch (this) {
      case welcome:
        return "/welcome";
      case login:
        return "/login";
      case seller:
        return "/seller";
      case register:
        return "/register";
      case swaps:
        return "/swaps";
      case user:
        return "/user";
      case order:
        return "/order";
      case orders:
        return "/orders";
      case matching:
        return "/matching";
      default:
        return "/swaps";
    }
  }
}

enum OrderStatus {
  listed,
  pending,
  completed,
  expired;

  @override
  String toString() {
    switch (this) {
      case listed:
        return "listed";
      case pending:
        return "pending";
      case completed:
        return "completed";
      case expired:
        return "expired";
    }
  }

  static OrderStatus fromString(String string) {
    string = string.toLowerCase();
    switch (string) {
      case "listed":
        return OrderStatus.listed;
      case "pending":
        return OrderStatus.pending;
      case "completed":
        return OrderStatus.completed;
      case "expired":
        return OrderStatus.expired;
      default:
        return OrderStatus.listed;
    }
  }
}

enum DiningCourt {
  earhart,
  hillenbrand,
  wiley,
  windsor,
  ford;

  @override
  String toString() {
    switch (this) {
      case earhart:
        return "earhart";
      case hillenbrand:
        return "hillenbrand";
      case wiley:
        return "wiley";
      case windsor:
        return "windsor";
      case ford:
        return "ford";
      default:
        return "";
    }
  }

  static DiningCourt fromString(String string) {
    string = string.toLowerCase();
    switch (string) {
      case "earhart":
        return DiningCourt.earhart;
      case "hillenbrand":
        return DiningCourt.hillenbrand;
      case "wiley":
        return DiningCourt.wiley;
      case "windsor":
        return DiningCourt.windsor;
      case "ford":
        return DiningCourt.ford;
      default:
        return DiningCourt.earhart;
    }
  }
}

enum Asset {
  earhart,
  ford,
  hillenbrand,
  windsor,
  wiley;

  @override
  String toString() {
    switch (this) {
      case earhart:
        return "assets/images/earhart.png";
      case ford:
        return "assets/images/ford.png";
      case hillenbrand:
        return "assets/images/hillenbrand.png";
      case windsor:
        return "assets/images/wiley.png";
      case wiley:
        return "assets/images/windsor.png";
    }
  }

  static String fromDiningCourt(DiningCourt diningCourt) {
    switch (diningCourt) {
      case DiningCourt.earhart:
        return "assets/images/earhart.png";
      case DiningCourt.ford:
        return "assets/images/ford.png";
      case DiningCourt.hillenbrand:
        return "assets/images/hillenbrand.png";
      case DiningCourt.windsor:
        return "assets/images/wiley.png";
      case DiningCourt.wiley:
        return "assets/images/windsor.png";
    }
  }
}

// Color themes
const Color kPrimaryColor1 = Color(0xFF1c1e20);
const Color kPrimaryColor2 = Color(0xFFF8F5F1);
const Color kSecondaryColor = Color(0xFFF8A488);
const Color kSurface = Color(0xFF23262b);
const Color kAccentGreen = Color(0xFFd1e2c3);
const Color kAccentColor3 = Color.fromARGB(255, 123, 141, 201);
const Color kAccentRed = Color(0xFFddc8c8);
