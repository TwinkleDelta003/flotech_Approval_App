import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:unnati/Controller/controller.dart';
import 'package:unnati/Widgets/ColorConfig.dart';
import 'package:unnati/Widgets/Helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phone = TextEditingController();

  String FCMId;
  String imei;

  Future<void> getImeiNumber() async {
    imei = await UniqueIdentifier.serial;
    print('IMEI: $imei');
  }

  @override
  void initState() {
    getImeiNumber();
    setState(() {
      FirebaseMessaging.instance.getToken().then((value) {
        FCMId = value;
        print("Your FCM Token" + FCMId);
      });
    });
    super.initState();
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              // width: 450,
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/ic_delta_ierp.png")),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign In",
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
              height: MediaQuery.of(context).size.height / 1.6,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.0))),
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
                      "Enter your Mobile No",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _phone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Color.fromARGB(255, 121, 225, 223),
                        ),
                        hintText: 'Enter Phone Number',
                        hintStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0)
                      ),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      // maxLengthEnforcement: MaxLengthEnforcement.none,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isDisable == false
                        ? Align(
                            alignment: Alignment.centerRight,
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
                                          ? "Get OTP".tr
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
                    SizedBox(height: 100),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Powered By:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "assets/images/ic_delta_logo.png",
                        height: 30,
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Help & Support : 07940371010",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  errorLens() {
    if (_phone.text.isEmpty)
      Helper.snackBar(context, "Mobile number is Empty");
    else if (_phone.text.length != 10)
      Helper.snackBar(context, "Phone number must be exactly 10 digits");
    else {
      if (mounted) {
        setState(() {
          isDisable = true;
        });
      }
      loginAPI(
        context: context,
        fcmid:
            "fUEsHOSxTPKKhTekzUjZhb:APA91bGlUi5TFzUjOAl5AK6BZGcJkCjxhqA1G-Hl8n0RvjwY30mH7XEZlI4GWhmm5vgulE1xzro4oXzrh21aupP84rKsgb1iuqgsOByCeIXI53cPJ1irlAzwqrEKsZLn2N9zV-D7aWI-",
        imei: imei,
        mobileNo: _phone.text,
      ).then((value) {
        if (value.status == "200") {
          setState(() {
            isDisable = false;
          });

          Get.toNamed('/OTPSCreen',
              arguments: [value.result[0].oTP, _phone.text]);
        } else {
          setState(() {
            isDisable = false;
          });
        }
      });
    }
  }
}
