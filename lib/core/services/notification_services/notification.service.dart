import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nomo_app/firebase_options.dart';

class NotificationService {
  static void Function({String? status, String?orderId})? onOrderStatusUpdate;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeFCM() async {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Request permissions for iOS
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize local notifications for foreground display
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Listen to messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen(_onMessageHandler);

    // Handle messages when the app is opened from a background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle any navigation or deep-linking logic here if required
      print(
          "Opened from background notification: ${message.notification?.title}");
    });
  }

  // Function to handle foreground messages
  static Future<void> _onMessageHandler(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // Show a local notification in the foreground if there is a message and an Android notification payload
    if (notification != null && android != null) {
      if (message.data.containsKey('orderStatus') &&
          onOrderStatusUpdate != null) {
        String updatedStatus = message.data['orderStatus'];
        String orderId = message.data['orderId'];
        onOrderStatusUpdate?.call(
            orderId: orderId, status: updatedStatus); // Trigger the callback
      }

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  }

  // Background handler for FCM messages
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase
        .initializeApp(); // Necessary to initialize Firebase in the background
    print("Handling background message: ${message.messageId}");
  }

  // Optional function to retrieve FCM token for testing
  static Future<String?> getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }
}
