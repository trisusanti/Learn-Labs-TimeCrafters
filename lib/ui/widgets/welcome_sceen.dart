import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tubes1/ui/widgets/signin.dart';
import 'package:tubes1/ui/widgets/theme.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = LiquidController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: [
              Container(
                padding: const EdgeInsets.all(15),
                color: orangishClr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Welcome to LearnLabs!",
                      style: headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    Image.asset('images/container1.png'),
                    Text(
                      "Your tasks, your way.",
                      style: headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "1/3",
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                color: greenishClr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Step into productivity!",
                      style: headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    Image.asset('images/container2.png'),
                    Text(
                      "Let's make each day count",
                      style: headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "2/3",
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                color: pinkClr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Stay focused, stay organized.",
                      style: headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    Image.asset('images/container3.png'),
                    Text(
                      "Your journey to productivity continues here.",
                      style: headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "3/3",
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
            ],
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
            slideIconWidget: Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.grey),
                )),
          ),
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              count: 3,
              activeIndex: controller.currentPage,
              effect: const WormEffect(
                activeDotColor: Color(0xff272727),
                dotHeight: 5.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  void onPageChangedCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;

      if (currentPage == 2) {
        // Navigate to signin page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      }
    });
  }
}
