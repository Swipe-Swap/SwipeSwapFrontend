import 'package:flutter/material.dart';

/// Use a list of screens to handle forward and backward navigation
final List<String> routes = [];

void navigateToRoute(BuildContext context, String route) {
  routes.add(route);
  Navigator.pushNamed(context, route);
}

// Stack the current screen
// Pop the back button
void navigateBack(BuildContext context) {
  if (routes.length > 1) {
    routes.removeLast();
    Navigator.pop(context);
  }
}
