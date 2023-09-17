import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Screen while sellers and buyers are being matched
class Matching extends StatefulWidget {
  const Matching({super.key});

  @override
  State<Matching> createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/circle-1.png"),
              SizedBox(height: 5.h),
              Image.asset("assets/images/findingSeller.png"),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Finding a Seller",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
