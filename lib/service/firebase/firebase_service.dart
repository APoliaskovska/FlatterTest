import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/files/files/files_page.dart';
import 'package:sample/routes/routes.dart';

class FirebaseService extends GetxService {
  static final FirebaseService _instance = new FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  Future<void> start() async {
    await Firebase.initializeApp();

    //MESSAGING
    await FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
          print("FCM TOKEN = $fcmToken");
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    });
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    _setupInteractedMessage();
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM TOKEN = $token");
  }

  Future<void> _setupInteractedMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("_handleMessage = $message");
    if (message.data['type'] == 'files') {
      BuildContext? context = Get.context;
      BottomNavigationBar? navigationBar = AppGlobalKeys.bottomNavBar.currentWidget as BottomNavigationBar?;
      if (navigationBar != null && context != null) {
        Navigator.popUntil(context, ModalRoute.withName(Routes.MENU));
        navigationBar.onTap!(3);
      }
    }
  }
}