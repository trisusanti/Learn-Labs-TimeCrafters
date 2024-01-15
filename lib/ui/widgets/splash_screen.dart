import 'package:flutter/material.dart';
import 'package:tubes1/ui/widgets/home_page.dart';
import 'package:tubes1/ui/widgets/theme.dart';
import 'package:tubes1/ui/widgets/welcome_sceen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[300],
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: 80,
            left: animate ? 30 : -30,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LearnLabs",
                    style: titleStyle,
                  ),
                  Text(
                    "this is an app",
                    style: headingStyle,
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 2400),
            bottom: animate ? 10 : -20,
            left: 10,
            child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: animate ? 1 : 0,
                child: Image.asset('images/splashscreen.png')),
          ),
        ],
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => animate = true);
    await Future.delayed(Duration(milliseconds: 5000));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }
}
