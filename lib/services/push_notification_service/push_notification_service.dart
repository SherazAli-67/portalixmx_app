import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../core/res/firebase_constant.dart';

class PushNotificationService {
  PushNotificationService._();

  static final PushNotificationService instance = PushNotificationService._();
  static const String _channelId = 'portalixmx_app_notifications';
  static const String _channelName = 'Portalixmx Notifications';
  static const String _channelDescription = 'General notifications';
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.max,
      );

  GoRouter? _router;
  // String? _currentToken;
  bool _initialized = false;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize({required GoRouter router}) async {
    if (_initialized) {
      _router = router;
      return;
    }
    _router = router;
    await _initializeLocalNotifications();
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOpenedMessage);
    FirebaseMessaging.instance.onTokenRefresh.listen(_onTokenRefresh);
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
    await _handleInitialMessage();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _syncToken(user.uid);
    }
    _initialized = true;
  }

  Future<void> removeTokenForSignOut() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;
      await FirebaseFirestore.instance
          .collection(FirebaseConst.residentsCol)
          .doc(uid)
          .set({'token': FieldValue.delete()}, SetOptions(merge: true));
    } catch (_) {}
    // _currentToken = null;
  }

  Future<void> _handleInitialMessage() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateFromMessage(message);
      });
    }
  }

  void _handleOpenedMessage(RemoteMessage message) {
    _navigateFromMessage(message);
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    final route = message.data['route'] as String?;
    final title =
        message.notification?.title ?? message.data['title'] as String?;
    final body = message.notification?.body ?? message.data['body'] as String?;
    if ((title == null || title.isEmpty) && (body == null || body.isEmpty)) {
      return;
    }
    await _localNotificationsPlugin.show(
      title: title,
      body: body,
      notificationDetails:
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: route, id:
    message.hashCode,
    );
  }

  void _navigateFromMessage(RemoteMessage message) {
    final route = message.data['route'] as String?;
    if (route == null || route.isEmpty || _router == null) return;
    _router!.go(route);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    if (user == null) return;
    await _syncToken(user.uid);
  }

  Future<void> _onTokenRefresh(String token) async {
    // _currentToken = token;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    await FirebaseFirestore.instance
        .collection(FirebaseConst.residentsCol)
        .doc(uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  Future<void> _syncToken(String uid) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      // debugPrint("Token: $token");
      if (token == null) return;
      // _currentToken = token;
      await FirebaseFirestore.instance
          .collection(FirebaseConst.residentsCol)
          .doc(uid)
          .set({'token': token}, SetOptions(merge: true));
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final route = response.payload;
        if (route == null || route.isEmpty || _router == null) return;
        _router!.go(route);
      },
    );
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);
  }
}
