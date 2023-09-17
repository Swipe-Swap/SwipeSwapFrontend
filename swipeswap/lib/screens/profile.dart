import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/services/auth.dart';
import 'package:swipeswap/utils/constants.dart';

/// User profile page
/// Users have:
/// - currentLocation
/// - dateCreated
/// - fullName
/// - phoneNumber
/// - sellerRating
/// - TODO: profilePic
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30.w,
        height: 5.h,
        child: InkWell(
            onTap: () async {
              final logout = await AuthService().signOut();
              if (logout!) {
                if (context.mounted) {
                  Navigator.pushNamed(context, Routes.login.toString());
                }
              } else {
                // TODO:  Handle logout error snackbar
              }
              ;
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
            )),
      ),
    );
  }
}
