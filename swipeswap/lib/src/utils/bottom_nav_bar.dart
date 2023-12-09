import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/src/provider/screen_provider.dart';
import 'package:swipeswap/src/screens/home/swaps.dart';
import 'package:swipeswap/src/utils/constants.dart';

/// A custom bottom nav bar with three pages:
/// [Swaps]
/// [Seller]
/// [Profile]
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0, left: 5.w, right: 5.w),
      child: Container(
        child: DotNavigationBar(
          paddingR: EdgeInsets.symmetric(vertical: 0.65.h, horizontal: 8.w),
          marginR: const EdgeInsets.all(0),
          backgroundColor: kSurface,
          currentIndex: SelectedTab.values
              .indexOf(Provider.of<ScreenProvider>(context).selectedTab),
          borderRadius: 22,
          onTap: Provider.of<ScreenProvider>(context).setTab,
          dotIndicatorColor: kAccentColor3,
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 10, offset: Offset(0, 5))
          ],
          // enableFloatingNavBar: false

          items: [
            DotNavigationBarItem(
              icon: Icon(
                FeatherIcons.home,
                size: 14.sp,
              ),
              unselectedColor: kPrimaryColor2.withOpacity(0.7),
              selectedColor: kAccentColor3,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(
                FeatherIcons.edit,
                size: 14.sp,
              ),
              unselectedColor: kPrimaryColor2.withOpacity(0.7),
              selectedColor: kAccentColor3,
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(
                FeatherIcons.user,
                size: 14.sp,
              ),
              unselectedColor: kPrimaryColor2.withOpacity(0.7),
              selectedColor: kAccentColor3,
            ),

            /// Profile
          ],
        ),
      ),
    );
  }
}
