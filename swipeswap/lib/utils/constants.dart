import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

/// Enum containing routes
enum Routes {
  welcome,
  login,
  register,
  swaps,
  user,
  order,
  listing,
  pendingOrders;

  @override
  String toString() {
    switch (this) {
      case welcome:
        return "/welcome";
      case login:
        return "/login";
      case register:
        return "/register";
      case swaps:
        return "/swaps";
      case user:
        return "/user";
      case order:
        return "/order";
      case listing:
        return "/listing";
      case pendingOrders:
        return "/pendingOrders";
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
const Color kAccentColor1 = Color(0xFF23262b);
const Color kAccentColor2 = Color(0xFF22C39A);
const Color kAccentColor3 = Color.fromARGB(255, 123, 141, 201);
