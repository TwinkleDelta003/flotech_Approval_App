import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unnati/Contants/API_URL.dart';

import 'package:pinput/pinput.dart';
import 'package:unnati/Contants/PrefsConfig.dart';
import 'package:unnati/Widgets/ColorConfig.dart';
import 'package:unnati/Widgets/Helper.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../Controller/controller.dart';

class OTPSCreen extends StatefulWidget {
  const OTPSCreen({Key key}) : super(key: key);

  @override
  State<OTPSCreen> createState() => _OTPSCreenState();
}

class _OTPSCreenState extends State<OTPSCreen> {
  var data = Get.arguments;
  TextEditingController _otpCltr = TextEditingController();

  // String FCMId;
  String imei;
  String mobile;
  bool show = false;

  Timer _timer;
  int _countdown = 60; // in seconds

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        setState(() {
          if (_countdown > 0) {
            _countdown--;
          } else {
            _timer.cancel();
            show = true;
          }
        });
    });
  }

  //Resend OTP API
  Future resendOTP({String mobileNo, BuildContext context}) async {
    final response = await http.post(
      Uri.parse(rESEND_OTP),
      body: {
        "MobileNo": mobileNo,
      },
    );

    var data = json.decode(response.body);

    if (data['status'] == "200") {
      print(data);
      // Helper.snackBar(context, "Login Success",
      //     color:ColorConfig.primaryAppColor);
      // Get.offAll(() => OTPSCreen());
      setState(() {
        _otpCltr.text = data['result'][0]['OTP'];
      });

      return data;
    } else {
      Helper.snackBar(context, "No Record Found!",
          color: ColorConfig.primaryAppColor);
      return data;
    }
  }

  Future<void> getUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (mounted)
      setState(() {
        // FCMId = _prefs.getString('FCMId');
        imei = _prefs.getString('IMEI');
        mobile = _prefs.getString('MobileNo');
      });
  }

  Future<void> getImeiNumber() async {
    imei = await UniqueIdentifier.serial;
    print('IMEI: $imei');
  }

  // String FCMId;
  void initState() {
    _otpCltr.text = data[0];
    getUserId();
    getImeiNumber();
    _startTimer();

    setState(() {
      // FirebaseMessaging.instance.getToken().then((value) {
      //   FCMId = value;
      //   debugPrint("Your FCM Token" + FCMId);
      // });
    });
    super.initState();
  }

  @override
  void dispose() {
    _startTimer();
    super.dispose();
  }

  bool isDisable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.primaryAppColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 5,
            //   // width: 450,
            //   child: Align(
            //       alignment: Alignment.center,
            //       child: Image.asset("assets/images/ic_delta_ierp.png")),
            // ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "OTP Verification",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // height: SizeConfig.screenHeight,
              height: MediaQuery.of(context).size.height / 1.2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius:
                //     BorderRadius.vertical(top: Radius.circular(30.0))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "An OTP Send to your mobile number with",
                      style: TextStyle(fontSize: 18),
                    ),
                    // Text(data[0].toString()),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      data[1],
                      style: TextStyle(
                          fontSize: 20, color: ColorConfig.primaryAppColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "We will automatically detect OTP.",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ('Second remaining: $_countdown '),
                      style: TextStyle(
                          fontSize: 18, color: ColorConfig.primaryAppColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 110),
                      child: customPinPut(
                        controller: _otpCltr,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    show == true ? Text("Didn't get OTP?") : Text(""),
                    SizedBox(
                      height: 10,
                    ),
                    show == true
                        ? InkWell(
                            onTap: () {
                              resendOTP(mobileNo: data[1], context: context);
                              // setState(() {
                              //   _otpCltr.text = otp;
                              // });
                            },
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                  color: ColorConfig.primaryAppColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          )
                        : Text(""),
                    SizedBox(height: Get.height / 2.2),
                    isDisable == false
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 2.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: ColorConfig.primaryAppColor),
                              child: MaterialButton(
                                onPressed: () {
                                  isDisable == false
                                      ? errorLens()
                                      : print("Diasble");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // SizedBox(width: 5),
                                    Text(
                                      isDisable == false
                                          ? "Login".tr
                                          : "Loading",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 2.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: ColorConfig.primaryAppColor),
                              child: MaterialButton(
                                onPressed: () {
                                  Helper.snackBar(context, "Please Wait....",
                                      color: ColorConfig.primaryAppColor);
                                },
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customPinPut(
      {TextEditingController controller, Function(String) onCompleted}) {
    return Pinput(
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      length: 4,
      controller: controller,
      focusNode: FocusNode(),
      closeKeyboardWhenCompleted: true,
      hapticFeedbackType: HapticFeedbackType.mediumImpact,
      keyboardType: TextInputType.number,
      onCompleted: onCompleted,
      enabled: true,
      showCursor: true,
    );
  }
//FCM ID is static

  errorLens() {
    if (_otpCltr.text.isEmpty)
      Helper.snackBar(context, "Please Enter OTP");
    else {
      if (mounted) {
        setState(() {
          isDisable = true;
        });
      }
      otpVerify(
              context: context,
              imei: imei,
              FCMId:
                  "fUEsHOSxTPKKhTekzUjZhb:APA91bGlUi5TFzUjOAl5AK6BZGcJkCjxhqA1G-Hl8n0RvjwY30mH7XEZlI4GWhmm5vgulE1xzro4oXzrh21aupP84rKsgb1iuqgsOByCeIXI53cPJ1irlAzwqrEKsZLn2N9zV-D7aWI-",
              mobileNo: data[1],
              otp: _otpCltr.text)
          .then((value) {
        if (value.status == "200") {
          setState(() {
            isDisable = false;
          });

          Get.toNamed('/Dashboard');

          PrefsConfig.setMobileNo(data[1]);
        } else {
          setState(() {
            isDisable = false;
          });
        }
      });
    }
  }
}
