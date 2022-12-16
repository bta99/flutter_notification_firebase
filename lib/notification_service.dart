import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificationService {
  static final notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  static Future initNotification({bool? scheduled = false}) async {
    AndroidInitializationSettings initAndroidSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    IOSInitializationSettings iosInitializationSettings =
        const IOSInitializationSettings();
    final settings = InitializationSettings(
        android: initAndroidSettings, iOS: iosInitializationSettings);
    return notification.initialize(settings,
        onSelectNotification: (String? payload) {
      onNotification.add(payload);
    });
  }

  static Future showNotification(
      {int? id, String? title, String? body, String? payload}) async {
    return notification.show(id!, title, body, await notificationDetails(),
        payload: payload);
  }

  static notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        enableLights: true,
        importance: Importance.max,
        icon: '@mipmap/launcher_icon',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
        // channelDescription: 'description',
        // maxProgress: 1,
      ),
      iOS: IOSNotificationDetails(),
    );
  }
}
