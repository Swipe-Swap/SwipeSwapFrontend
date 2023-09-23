import 'package:swipeswap/src/services/auth.dart';
import 'package:swipeswap/src/utils/constants.dart';

import 'package:flutter/material.dart';

/// "By the students, for the students"
/// "Savor the flavor, fund the future"
/// "Start swapping!"
class Welcome extends StatefulWidget {
  final int currentPage;
  const Welcome({super.key, this.currentPage = 0});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late final AnimationController _buttonAnimationController;
  int currentPage = 0;
  final PageController controller = PageController(initialPage: 0);
  @override
  void initState() {
    currentPage = widget.currentPage;

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (controller.hasClients) {
        if (currentPage != 0) controller.jumpToPage(currentPage);
      }
    });
    _buttonAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
        lowerBound: 0,
        upperBound: 1)
      ..addListener(() {
        setState(() {});
      });
    _buttonAnimationController.forward();
  }

  void onNextTapped() {
    // use this to animate to the page
    setState(() {
      currentPage++;
    });
    controller.nextPage(
        duration: const Duration(milliseconds: 380), curve: Curves.easeOutQuad);
  }

  void onBackTapped() {
    // use this to animate to the page
    setState(() {
      if (currentPage != 0) currentPage--;
    });
    controller.previousPage(
        duration: const Duration(milliseconds: 380), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: -300,
              left: -300,
              child: Container(
                height: height * 0.7,
                width: height * 0.7,
                decoration: BoxDecoration(
                    color: kSurface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(-3, 2))
                    ]),
              )),
          Positioned(
              bottom: -300,
              right: -300,
              child: Container(
                height: height * 0.7,
                width: height * 0.7,
                decoration: BoxDecoration(
                    color: kSurface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(-3, 2))
                    ]),
              )),
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: [
              page1(context),
              page2(context),
            ],
          ),
          Positioned(bottom: 20, child: nextButton(context)),
          Visibility(
            visible: currentPage == 0 ? false : true,
            child: Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    onBackTapped();
                  },
                  icon: const Icon(Icons.arrow_back),
                )),
          )
        ],
      )),
    );
  }

  Column page1(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Image.asset("assets/images/logo.png"),
        SizedBox(height: height * 0.04),
        Text(
          'Welcome to SwipeSwap.',
          style: TextStyle(fontSize: width * 0.075),
        ),
        SizedBox(height: height * 0.07),
        SizedBox(
          width: width * 0.8,
          child: Text(
            'Repurpose your extra meal swipes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width * 0.055,
            ),
          ),
        ),
      ],
    );
  }

  Column page2(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(height: height * 0.05),
        Image.asset("assets/images/logo.png"),
        SizedBox(height: height * 0.065),
        Text(
          'How It Works',
          style: TextStyle(
            fontSize: width * 0.08,
          ),
        ),
        SizedBox(height: height * 0.06),
        Text(
          'Sell your extra meal swipes to other students or buy cheaper dining court meals.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: width * 0.055),
        ),
      ],
    );
  }

  GestureDetector nextButton(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onTapUp: onTapUp,
      //Sign In with email and pswd widget
      onTap: () async {
        if (currentPage != 1) {
          onNextTapped();
        } else {
          final login = await AuthService().signInWithGoogle();
          if (login != null) {
            // check if no login errors
            if (context.mounted) {
              Navigator.pushNamed(context, Routes.swaps.toString());
            }
          } else {
            // login error
            //TODO Snackbar
          }
        }
      },
      child: Transform.scale(
        scale: (0.9 + (_buttonAnimationController.value / 10)).abs(),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: kAccentGreen,
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    color: kAccentGreen
                        .withOpacity(0.35 * _buttonAnimationController.value),
                    offset: const Offset(0, 6)),
              ]),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                  visible: currentPage == 1 ? false : true,
                  child: const Positioned(
                      right: 20, child: Icon(Icons.arrow_forward))),
              Text(
                currentPage == 1 ? 'Get Started' : 'Next',
                style: const TextStyle(
                  fontSize: 21,
                  color: kPrimaryColor1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapDown(TapDownDetails tapDownDetails) {
    _buttonAnimationController.reverse();
  }

  void onTapUp(TapUpDetails tapUpDetails) {
    _buttonAnimationController.forward();
  }

  void onTapCancel() {
    _buttonAnimationController.forward();
  }
}
