import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:unnati/Controller/NotificationController.dart';
import 'package:unnati/Screen/SuccessScreen.dart';
import 'Auth/OTPSCreen.dart';
import 'Contants/PrefsConfig.dart';
import 'Screen/Dashboard.dart';
import 'Screen/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsConfig.init();
  await Firebase.initializeApp();
  await PushNotificationService().setupInteractedMessage();
  await NotificationAPI.backgroundMessage();
  await NotificationAPI.initilizeNotification();
  // await NotificationAPI().requestNotificationPermissionForIOS();
// todo permission for notifications
  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  (error, stack) =>
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  RemoteMessage initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {}
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var mobile = prefs.getString('MobileNo');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
            child,
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: DESKTOP)
            ],
          ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/OTPSCreen', page: () => OTPSCreen()),
        GetPage(name: '/Dashboard', page: () => Dashboard()),
        GetPage(name: '/success', page: () => SuccessScreen()),
      ],
      theme: ThemeData(
        // appBarTheme: AppBarTheme(
        //   iconTheme: IconThemeData(color: Colors.black),
        // ),
        textTheme: GoogleFonts.nunitoSansTextTheme(),
      ),
      title: "Unnati-iERP",
      home: PrefsConfig.getUserId() == "" ? SplashScreen() : Dashboard()
      // home: SplashScreen(),
      ));
}
