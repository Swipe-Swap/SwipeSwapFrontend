import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/src/services/auth.dart';
import 'package:swipeswap/src/utils/constants.dart';

/// A button for logging out; uses [AuthService] to expire the users credentials
/// Currently redirects the user to the welcome page
class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _ProfileState();
}

class _ProfileState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      height: 5.h,
      child: InkWell(
        onTap: () async {
          final logout = await AuthService().signOut();
          if (logout!) {
            if (context.mounted) {
              Navigator.pushNamed(context, Routes.welcome.toString());
            }
          } else {
            // Handle logout error snackbar
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("That's an error!")));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Log Out",
              style: TextStyle(color: Colors.redAccent),
            ),
            SizedBox(width: 1.w),
            const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
