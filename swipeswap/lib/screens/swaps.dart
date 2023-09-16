import 'package:flutter/material.dart';
import 'package:swipeswap/services/auth.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:swipeswap/utils/routing.dart';
import 'package:swipeswap/widgets/dining_court.dart';

/// Main application page
class Swaps extends StatefulWidget {
  const Swaps({super.key});

  @override
  State<Swaps> createState() => _SwapsState();
}

class _SwapsState extends State<Swaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () async {
              final logout = await AuthService().signOut();
              if (logout!) {
                navigateToRoute(context, Routes.login.toString());
              } else {
                //TODO:  Handle logout error snackbar
              }
              ;
            },
            child: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            )),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          DiningCourtWidget(
              assetPath: Assets.earhart.toString(), assetText: "Earhart"),
          DiningCourtWidget(
              assetPath: Assets.wiley.toString(), assetText: "Wiley"),
          DiningCourtWidget(
              assetPath: Assets.windsor.toString(), assetText: "Windsor"),
          DiningCourtWidget(
            assetPath: Assets.hillenbrand.toString(),
            assetText: "Hillenbrand",
          ),
          DiningCourtWidget(
              assetPath: Assets.ford.toString(), assetText: "Ford"),
        ],
      ),
    );
  }
}
