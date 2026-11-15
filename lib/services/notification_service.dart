import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      
  String? launchPayload;

  Future<void> initialize({
    Function(String?)? onNotificationClick,
  }) async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        debugPrint('DEBUG: Notification clicked. Payload: ${notificationResponse.payload}');
        if (onNotificationClick != null) {
          onNotificationClick(notificationResponse.payload);
        }
      },
    );

    // Check if app was launched from notification
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    
    debugPrint('DEBUG: App launched from notification: ${notificationAppLaunchDetails?.didNotificationLaunchApp}');
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      launchPayload = notificationAppLaunchDetails?.notificationResponse?.payload;
      debugPrint('DEBUG: Launch payload set: $launchPayload');
      if (onNotificationClick != null) {
        onNotificationClick(launchPayload);
      }
    }
  }

  String? consumeLaunchPayload() {
    final payload = launchPayload;
    launchPayload = null;
    debugPrint('DEBUG: Consuming launch payload: $payload');
    return payload;
  }

  Future<bool?> requestPermissions() async {
    final bool? androidGranted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    final bool? iosGranted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        
    return androidGranted ?? iosGranted;
  }

  Future<void> _safeZonedSchedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required NotificationDetails notificationDetails,
    required AndroidScheduleMode scheduleMode,
    DateTimeComponents? matchDateTimeComponents,
    String? payload,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: scheduleMode,
        matchDateTimeComponents: matchDateTimeComponents,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Error scheduling notification (mode: $scheduleMode): $e');
      // Fallback for permission errors (SecurityException)
      if (scheduleMode == AndroidScheduleMode.exactAllowWhileIdle) {
        debugPrint('Falling back to inexactAllowWhileIdle');
        try {
          await flutterLocalNotificationsPlugin.zonedSchedule(
            id,
            title,
            body,
            scheduledDate,
            notificationDetails,
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            matchDateTimeComponents: matchDateTimeComponents,
            payload: payload,
          );
        } catch (e2) {
          debugPrint('Error scheduling notification fallback: $e2');
        }
      }
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    String channelId = 'daily_prayer_channel',
    String channelName = 'Daily Prayers',
    String channelDescription = 'Notifications for scheduled daily prayers',
  }) async {
    debugPrint('DEBUG: Scheduling notification with payload: $payload');
    await _safeZonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      scheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
    String channelId = 'daily_prayer_channel',
    String channelName = 'Daily Prayers',
    String channelDescription = 'Notifications for scheduled daily prayers',
  }) async {
    debugPrint('DEBUG: Scheduling daily notification with payload: $payload');
    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _safeZonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      scheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int weekday,
    required TimeOfDay time,
    String? payload,
    String channelId = 'daily_prayer_channel',
    String channelName = 'Daily Prayers',
    String channelDescription = 'Notifications for scheduled daily prayers',
  }) async {
    debugPrint('DEBUG: Scheduling weekly notification for weekday $weekday at ${time.hour}:${time.minute}');
    
    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    // Adjust to the target weekday
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // If the calculated date is in the past, add 7 days
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    await scheduleRepeatingNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: payload,
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
    );
  }

  Future<void> scheduleRepeatingNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required DateTimeComponents? matchDateTimeComponents,
    String? payload,
    String channelId = 'daily_prayer_channel',
    String channelName = 'Daily Prayers',
    String channelDescription = 'Notifications for scheduled daily prayers',
  }) async {
    debugPrint('DEBUG: Scheduling repeating notification with payload: $payload');
    await _safeZonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      scheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: matchDateTimeComponents,
      payload: payload,
    );
  }

  Future<void> scheduleSpecificDateNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required TimeOfDay time,
    String? payload,
    String channelId = 'daily_prayer_channel',
    String channelName = 'Daily Prayers',
    String channelDescription = 'Notifications for scheduled daily prayers',
  }) async {
    final scheduledDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    await scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      payload: payload,
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
