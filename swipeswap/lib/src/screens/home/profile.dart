import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: const LogoutButton(),
    );
  }
}
