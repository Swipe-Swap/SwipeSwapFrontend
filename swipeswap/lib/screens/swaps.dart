import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/screens/pendingOrder.dart';
import 'package:swipeswap/services/auth.dart';
import 'package:swipeswap/utils/constants.dart';
import 'package:swipeswap/widgets/dining_court.dart';
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Container(
            child: DotNavigationBar(
              paddingR: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 3.w),
              marginR: EdgeInsets.all(0),
              backgroundColor: kAccentColor1,
              currentIndex: 0,
              onTap: (p0) {},
              dotIndicatorColor: Colors.black,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 12,
                  blurStyle: BlurStyle.outer,
                )
              ],
              // enableFloatingNavBar: false
              items: [
                DotNavigationBarItem(
                  icon: const Icon(
                    Icons.home,
                  ),
                  selectedColor: kAccentColor3,
                ),

                /// Likes
                DotNavigationBarItem(
                  icon: const Icon(
                    Icons.edit_note_outlined,
                  ),
                  selectedColor: kAccentColor3,
                ),

                /// Search
                DotNavigationBarItem(
                  icon: const Icon(
                    Icons.person,
                  ),
                  selectedColor: kAccentColor3,
                ),

                /// Profile
              ],
            ),
          ),
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
                        assetPath: Asset.earhart.toString(),
                        assetText: "Earhart"),
                    DiningCourtWidget(
                        assetPath: Asset.wiley.toString(), assetText: "Wiley"),
                    DiningCourtWidget(
                        assetPath: Asset.windsor.toString(),
                        assetText: "Windsor"),
                    DiningCourtWidget(
                      assetPath: Asset.hillenbrand.toString(),
                      assetText: "Hillenbrand",
                    ),
                    DiningCourtWidget(
                        assetPath: Asset.ford.toString(), assetText: "Ford"),
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
