import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vinhcine/ui/components/app_context.dart';

import '../../router/routers.dart';

class FirebaseApi {
  // Create a singleton instance of FirebaseMessaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notification
  Future<void> initialize() async {
    // Request permission for notification
    await _firebaseMessaging.requestPermission();

    // Get the token
    final token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }

  // Function to handle notification
  void handleNotification(RemoteMessage? message) {
    if (message?.notification != null) {
      print('Message also contained a notification: ${message?.notification}');
      return;
    }

    AppContext.navigatorKey.currentState!
        .pushNamed(Routers.home, arguments: message?.data);
  }

  // Function to handle background notification
  Future initPushNotification() async {
    // Get the initial message
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleNotification(message);
    });
  }
}
