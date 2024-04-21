import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationWidget {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init() async {
    try {
      final android = AndroidInitializationSettings('@mipmap/ic_launcher');
      final iOS = DarwinInitializationSettings();
      final settings = InitializationSettings(android: android, iOS: iOS);
      await _notifications.initialize(settings);
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  static Future showNotification(
      {var id = 0, var title, var body, var payload}) async {
    try {
      return _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  static Future _notificationDetails() async {
    try {
      return NotificationDetails(
        android: await _androidDetails(),
        iOS: await _iOSDetails(),
      );
    } catch (e) {
      print('Error creating notification details: $e');
    }
  }

  static Future _androidDetails() async {
    try {
      return AndroidNotificationDetails(
        'channel id 2',
        'channel name',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('sound'),
      );
    } catch (e) {
      print('Error creating Android notification details: $e');
    }
  }

  static Future _iOSDetails() async {
    try {
      return DarwinNotificationDetails(presentSound: true);
    } catch (e) {
      print('Error creating iOS notification details: $e');
    }
  }
}