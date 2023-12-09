import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoMatchFound extends StatefulWidget {
  const NoMatchFound({super.key});

  @override
  State<NoMatchFound> createState() => _NoMatchFoundState();
}

class _NoMatchFoundState extends State<NoMatchFound> {
  @override
  Widget build(BuildContext context) {
    // TODO: just made this a really simple page, we can change it later
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning,
                color: Colors.yellow,
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "No Match Found",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              // TODO: could add redirect functionality here; not entirely sure about the
              // user flow of the app yet
              // ElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }
}
