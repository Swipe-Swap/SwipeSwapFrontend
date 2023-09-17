import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/screens/pendingOrder.dart';
import 'package:swipeswap/services/auth.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:swipeswap/widgets/dining_court.dart';
import 'package:sizer/sizer.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

/// Main application page
class Swaps extends StatefulWidget {
  const Swaps({super.key});

  @override
  State<Swaps> createState() => _SwapsState();
}

class _SwapsState extends State<Swaps> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: DotNavigationBar(
          backgroundColor: kAccentColor1,
          currentIndex: 0,
          onTap: (p0) {},
          dotIndicatorColor: Colors.black,
          // enableFloatingNavBar: false
          items: [
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Colors.purple,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              selectedColor: Colors.pink,
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.search),
              selectedColor: Colors.orange,
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Colors.teal,
            ),
          ],
        ),
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
            const PendingOrder(),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose a Dining Court",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Expanded(
              child: Center(
                child: GridView.count(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
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
      ),
    );
  }
}
