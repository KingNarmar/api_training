import 'package:api_training/repos/navigator_helper.dart';
import 'package:api_training/repos/shared_helper.dart';
import 'package:api_training/screens/login_screen.dart';
import 'package:api_training/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        bool isLogin = SharedHelper.prefs.getBool("isLogin") ?? false;
        NavigatorHelper.goToAndOff(
            context, isLogin ? const HomeScreen() : const LoginScreen());
      },
    );
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.category,
              size: 150,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
