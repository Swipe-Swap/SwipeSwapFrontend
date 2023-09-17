import 'package:flutter/material.dart';
import 'package:swipeswap/widgets/logout_button.dart';

/// User profile page (TODO: not worth doing)
/// Users have:
/// - currentLocation
/// - dateCreated
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
    return const Center(child: LogoutButton());
  }
}
