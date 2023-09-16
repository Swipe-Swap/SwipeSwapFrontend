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
