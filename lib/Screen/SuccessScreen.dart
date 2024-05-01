import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unnati/Widgets/CustomText.dart';

class SuccessScreen extends StatefulWidget {
  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  var status = Get.arguments;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Get.offAllNamed('/Dashboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset('assets/images/success.json'),
          ),
          CustomText(
            data: "Your PO Number ${status[0]} is Successfully ${status[1]}!!",
            fSize: 28,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
