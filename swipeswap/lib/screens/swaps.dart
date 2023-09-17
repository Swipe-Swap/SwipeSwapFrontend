import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/screens/pendingOrder.dart';
import 'package:swipeswap/services/auth.dart';
import 'package:swipeswap/utils/constants.dart';
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
                if (context.mounted) {
                  Navigator.pushNamed(context, Routes.login.toString());
                }
              } else {
                // TODO:  Handle logout error snackbar
              }
              ;
            },
            child: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            )),
      ),
      body: Column(
        children: [
          PendingOrder(),
          Text("Choose a Dining Court"),
          Expanded(
            child: Center(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 5.h,
                crossAxisSpacing: 10.w,
                crossAxisCount: 2,
                children: [
                  DiningCourtWidget(
                      assetPath: Assets.earhart.toString(),
                      assetText: "Earhart"),
                  DiningCourtWidget(
                      assetPath: Assets.wiley.toString(), assetText: "Wiley"),
                  DiningCourtWidget(
                      assetPath: Assets.windsor.toString(),
                      assetText: "Windsor"),
                  DiningCourtWidget(
                    assetPath: Assets.hillenbrand.toString(),
                    assetText: "Hillenbrand",
                  ),
                  DiningCourtWidget(
                      assetPath: Assets.ford.toString(), assetText: "Ford"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
