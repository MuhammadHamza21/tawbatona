import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
  );
  Future firebaseInitialize() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.getInitialMessage().then((message) {});
    FirebaseAnalytics.instance;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("all");
    String? token = await messaging.getToken();
    print("Token: $token");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _getNotificationInForground(_flutterLocalNotificationsPlugin);
    _notificationSettings(messaging);
    _androidNotificationChannel();
    _initLocalNotifications();
  }

  void _getNotificationInForground(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    // The below setForegroundNotificationPresentationOptions only for IOS
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("Event is: ${message.data}");
        _showNotificationInForeground(message);
      },
    );
    _getNotificationInOpenedApp();
  }

  void _getNotificationInOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("App Opened: ${event.data}");
    }).onError((error) {});
  }

  void _notificationSettings(FirebaseMessaging messaging) async {
    // ignore: unused_local_variable
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void _androidNotificationChannel() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  void _initLocalNotifications() async {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialize,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        if (details.payload != null && details.payload!.isNotEmpty) {}
      },
    );
  }

  Future<void> _showNotificationInForeground(RemoteMessage message) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: _channel.importance,
      priority: Priority.max,
      // ticker: "ticker",
      playSound: _channel.playSound,
      // sound: const RawResourceAndroidNotificationSound('notification'),
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      int.parse(message.notification!.android!.channelId!),
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data}");
}