import 'dart:ui';

/// Enum containing routes
enum Routes {
  welcome,
  login,
  register,
  swaps,
  user;

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
      default:
        return "/swaps";
    }
  }
}

// Color themes
const Color kPrimaryColor1 = Color(0xFF222831);
const Color kPrimaryColor2 = Color(0xFFF8F5F1);
const Color kSecondaryColor = Color(0xFFF8A488);
const Color kAccentColor1 = Color(0xFF45526C);
const Color kAccentColor2 = Color(0xFF22C39A);
const Color kAccentColor3 = Color(0xFFDB5757);
