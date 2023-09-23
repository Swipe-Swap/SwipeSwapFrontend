import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/src/provider/screen_provider.dart';
import 'package:swipeswap/src/utils/bottom_nav_bar.dart';
import 'package:swipeswap/src/utils/constants.dart';
import 'package:swipeswap/src/widgets/dining_court.dart';

/// Main application page
class Swaps extends StatefulWidget {
  const Swaps({super.key});

  @override
  State<Swaps> createState() => _SwapsState();
}

class _SwapsState extends State<Swaps> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: const CustomBottomNavBar(),
        appBar: AppBar(automaticallyImplyLeading: false),
        body: tabs[SelectedTab.values
            .indexOf(Provider.of<ScreenProvider>(context).selectedTab)],
      ),
    );
  }
}

enum SelectedTab { home, seller, profile }

Column swapsGrid() {
  return Column(
    children: [
      // const Orders(),
      Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Choose a Dining Court",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
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
                  assetPath: Asset.earhart.toString(), assetText: "Earhart"),
              DiningCourtWidget(
                  assetPath: Asset.wiley.toString(), assetText: "Wiley"),
              DiningCourtWidget(
                  assetPath: Asset.windsor.toString(), assetText: "Windsor"),
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
  );
}
