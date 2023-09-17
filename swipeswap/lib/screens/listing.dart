import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeswap/utils/constants.dart';

class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.exchange.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          kAccentGreen,
                          Color(0xffC1C9E4),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text(
                      "Create Listing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: kPrimaryColor1,
                      ),
                    ),
                  ),
                  height: 8.h,
                  width: 80.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
