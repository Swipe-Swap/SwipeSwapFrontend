import 'package:flutter/material.dart';
import 'package:swipeswap/utils/constants.dart';

/// A custom app bar that can be instantiated throughout screens
/// Includes:
/// Forward arrow
/// Back arrow
/// Menu Dropdown:
///   - User profile (0)
///   - Pending Orders (1)
///   - Home button (2)
///   - Logout (3)
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          tooltip: "Back Button",
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        PopupMenuButton(
          icon: const Icon(Icons.menu),
          tooltip: "Menu Icon",
          itemBuilder: (context) {
            return const [
              PopupMenuItem<int>(
                value: 0,
                child: Text("User"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Orders"),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text("Home"),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text("Logout"),
              ),
            ];
          },
          onSelected: (value) {
            /// Navigate based on the selected options
            switch (value) {
              case 0:
                Navigator.pushNamed(context, Routes.user.toString());
              case 1:
                Navigator.pushNamed(context, Routes.swaps.toString());
              case 2:
                // TODO: Logout user

                // Redirect user to login screen
                Navigator.pushNamed(context, Routes.login.toString());
            }
          },
        ),
      ],
    );
  }
}
