import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), navigate);
  }

  Future<void> navigate() {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SPORT',
              style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 35),
            ),
            Text(
              'O',
              style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: 35),
            ),
          ],
        ),
      ),
    );
  }
}
