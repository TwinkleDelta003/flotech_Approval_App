import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Auth/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => LoginScreen());
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Color.fromARGB(255, 121, 225, 223),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  // width: 450,
                  child: Image.asset("assets/images/ic_delta_ierp.png"),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  // width: 450,
                  child: Image.asset("assets/images/ic_unnati_logo.png"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.2,
                ),
                // Text(
                //   "Powered By:",
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 30,
                //   // width: 450,
                //   child: Image.asset("assets/images/ic_delta_logo.png"),
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 8,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Powered By:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/ic_delta_logo.png",
                height: 30,
              ),
              // add some spacing between the image and text
            ],
          ),
        ),
      ),
    );
  }
}
