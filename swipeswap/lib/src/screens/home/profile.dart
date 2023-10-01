import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/libraries/providers.dart';
import 'package:swipeswap/libraries/utils.dart';
import 'package:swipeswap/src/widgets/logout_button.dart';

/// User profile page
/// Users have:
/// - currentLocation
/// - dateCreated
/// - email
/// - fullName
/// - phoneNumber
/// - sellerRating
/// - LATER: profilePic
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<UserProvider>(context);
    debugPrint("Phone number: ${firebaseProvider.user!.phoneNumber}");
    String photoUrl = firebaseProvider.user!.photoUrl.toString();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              firebaseProvider.user!.fullName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3.h,
            ),
            CircleAvatar(
              radius: 40.sp, // Image radius
              backgroundImage: NetworkImage(photoUrl),
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.phoneCall,
                  color: kPrimaryColor2.withAlpha(150),
                  size: 15.sp,
                ),
                // Text(firebaseProvider.user!.phoneNumber)
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
