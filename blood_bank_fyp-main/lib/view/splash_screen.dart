
// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes/routes_name.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      login();
    });
  }

  void login(){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesName.home);
      });
    }else{
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesName.login);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/splash.jpg' ), fit: BoxFit.fill
              )
          ),
        ),
        DefaultTextStyle(
          style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
              color: Colors.red
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Give Blood Save Life',
                        speed: Duration(milliseconds: 200)),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        )
      ],
    );
  }
}
