import 'package:swipeswap/screens/login.dart';
import 'package:swipeswap/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
                    color: kPrimaryColor2,
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
                    color: kPrimaryColor2,
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
              page3(context),
              page4(context),
              page5(context)
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
        SizedBox(height: height * 0.04),
        Text(
          'Hi,',
          style: TextStyle(fontSize: width * 0.088, color: kPrimaryColor1),
        ),
        Text(
          'This is Carora.',
          style: TextStyle(fontSize: width * 0.075, color: kPrimaryColor1),
        ),
        SizedBox(height: height * 0.07),
        SizedBox(
          width: width * 0.8,
          child: Text(
            'Your personal elderly care assistant.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.055, color: kPrimaryColor1),
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
        SizedBox(height: height * 0.065),
        Text(
          'Reminders',
          style: TextStyle(fontSize: width * 0.08, color: kPrimaryColor1),
        ),
        SizedBox(height: height * 0.06),
        Text(
          'Remind the elder for',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: width * 0.055, color: kPrimaryColor1),
        ),
        DefaultTextStyle(
          style: TextStyle(fontSize: width * 0.055, color: kPrimaryColor1),
          child: AnimatedTextKit(repeatForever: true, animatedTexts: [
            RotateAnimatedText('medicine.',
                duration: const Duration(milliseconds: 1500)),
            RotateAnimatedText('exercise.',
                duration: const Duration(milliseconds: 1500)),
            RotateAnimatedText('water.',
                duration: const Duration(milliseconds: 1500)),
            RotateAnimatedText('anything.',
                duration: const Duration(milliseconds: 2000)),
          ]),
        ),
      ],
    );
  }

  Column page3(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(height: height * 0.05),
        SizedBox(height: height * 0.065),
        Text(
          'Track Location',
          style: TextStyle(fontSize: width * 0.08, color: kPrimaryColor1),
        ),
        SizedBox(height: height * 0.06),
        SizedBox(
          width: width * 0.8,
          child: Text(
            'See if your elder is in a safe place. Anytime, anywhere.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.055, color: kPrimaryColor1),
          ),
        ),
      ],
    );
  }

  Column page4(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(height: height * 0.05),
        SizedBox(height: height * 0.065),
        Text(
          'Powerful Insights',
          style: TextStyle(fontSize: width * 0.08, color: kPrimaryColor1),
        ),
        SizedBox(height: height * 0.06),
        SizedBox(
          width: width * 0.8,
          child: Text(
            'Know about the elder’s day in one beautiful page.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.055, color: kPrimaryColor1),
          ),
        ),
      ],
    );
  }

  Column page5(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        SizedBox(height: height * 0.04),
        Text(
          'Easy to use',
          style: TextStyle(fontSize: width * 0.08, color: kPrimaryColor1),
        ),
        SizedBox(height: height * 0.055),
        SizedBox(
          width: width * 0.8,
          child: Text(
            'Use the app on 2 devices, one for elder and one for the care-taker. \nEffortless, easy to use UI for elders. \nThe caretaker can add, update or view anything over the air.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.055, color: kPrimaryColor1),
          ),
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ));
          },
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
                color: kAccentColor1,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                )),
            child: Center(
                child: Text('Already have an account?',
                    style: TextStyle(
                      color: kPrimaryColor2,
                      fontSize: width * 0.045,
                    ))),
          ),
        ),
        SizedBox(
          height: 60 + (height * 0.06),
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
      onTap: () {
        if (currentPage != 4) {
          onNextTapped();
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ));
        }
      },
      child: Transform.scale(
        scale: (0.9 + (_buttonAnimationController.value / 10)).abs(),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: kAccentColor2,
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    color: kAccentColor2
                        .withOpacity(0.35 * _buttonAnimationController.value),
                    offset: const Offset(0, 6)),
              ]),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Visibility(
                  visible: currentPage == 4 ? false : true,
                  child: const Positioned(
                      right: 20, child: Icon(Icons.arrow_forward))),
              Text(
                currentPage == 4 ? 'Get Started' : 'Next',
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
