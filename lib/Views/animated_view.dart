import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_view.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate initialization (API calls, etc.)
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
      Duration(milliseconds: 6000),
    ); // Match your animation length
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF009688,
      ), // Must match native splash color
      body: Center(
        child: Lottie.asset(
          'assets/images/story icon.json',
          width: 400,
          height: 400,
          fit: BoxFit.fill,
          repeat: true,
        ),
      ),
    );
  }
}
