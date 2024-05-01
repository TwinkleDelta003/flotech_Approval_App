import 'package:flutter/material.dart';

import 'package:push_notification/push_notification.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Initialize FlutterLocalNotificationsPlugin
  Notificator notification;

  String notificationKey = 'key';

  String _bodyText = 'notification text';

  @override
  void initState() {
    notification = Notificator(
      onPermissionDecline: () {
        print('permission decline');
      },
      onNotificationTapCallback: (notificationData) {
        setState(
          () {
            _bodyText = 'notification open: '
                '${notificationData[notificationKey].toString()}';
          },
        );
      },
    )..requestPermissions(
        requestSoundPermission: true,
        requestAlertPermission: true,
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notification Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Notification Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              notification.show(
                1,
                'Leave Application',
                // 'Your Request From ${_textEditingController.text} to ${_textEditingController2.text} is Successfully Sent to Admin',
                'Your Leave is Succesfully Sent to Admin',
                data: {notificationKey: '[notification data]'},
                notificationSpecifics: NotificationSpecifics(
                  AndroidNotificationSpecifics(
                    autoCancelable: true,
                    icon: '@mipmap/ic_launcher',
                  ),
                ),
              );
              // Display notification
              // NotificationAPI.plugin.show(
              //     1,
              //     'Leave Application',
              //     // 'Your Request From ${_textEditingController.text} to ${_textEditingController2.text} is Successfully Sent to Admin',
              //     // 'Your Leave is Succesfully Sent to Admin From ${FrmDt.text} to ${ToDt.text}',
              //     'Your Leave is Succesfully Sent to Admin',
              //     NotificationDetails(
              //         android: AndroidNotificationDetails(
              //       NotificationAPI.channel.id,
              //       NotificationAPI.channel.name,
              //       channelDescription: NotificationAPI.channel.description,
              //       playSound: true,
              //       icon: '@mipmap/ic_launcher',
              //       // color: Colors.green,
              //     )));
            },
            child: Text('Approve message'),
          ),
        ),
      ),
    );
  }
}
