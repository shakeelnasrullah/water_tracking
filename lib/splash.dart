import 'package:flutter/material.dart';
import 'package:water_tracker/boarding/boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const BoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash_screen.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/splash_img.png",
              width: 200,
            ),
            const SizedBox(height: 20,),
            const Text(
              'Drops Water Tracker',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Colors.white,
                  //fontFamily: "Anton",
                  fontSize: 26),
            ),
            const Center(
              child:  Text(
                'Stay hydrated and track your\ndaily water intake',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.0,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
