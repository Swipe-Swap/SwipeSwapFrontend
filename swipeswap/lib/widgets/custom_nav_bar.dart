import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

/// A custom app bar that can be instantiated throughout screens
/// Includes:
/// Menu Dropdown:
///   - Home button (pendingOrder or swaps) (0)
///   - Listings (listings) (1)
///   - User Profile (user) (2)
///   - Logout (3)
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      currentIndex: index,
      // Handle index changed
      onTap: (value) {
        setState(() {
          index = value;
        });
      },
      items: [
        DotNavigationBarItem(icon: const Icon(Icons.home)),
        DotNavigationBarItem(icon: const Icon(Icons.attach_money)),
        DotNavigationBarItem(icon: const Icon(Icons.person)),
      ],
    );
  }
}
