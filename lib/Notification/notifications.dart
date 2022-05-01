import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> scheduledNotification(int day, String? body, int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      largeIcon: 'resource://drawable/res_notification_app_icon',
      category: NotificationCategory.Recommendation,
      locked: false,
      id: id,
      channelKey: 'scheduled_channel',
      title:
          '${Emojis.money_money_bag} Payment Reminder ${Emojis.money_money_bag}',
      body:
          'Finish this payment today ${Emojis.smile_face_with_raised_eyebrow} $body',
      bigPicture: 'asset://assets/notification_map_1.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
    schedule: NotificationCalendar(
        allowWhileIdle: true,
        day: day,
        hour: 08,
        minute: 30,
        second: 0,
        millisecond: 0,
        repeats: true,
        preciseAlarm: true),
  );
}

Future<void> scheduledNotificationRepeat(int day, String? body, int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      largeIcon: 'resource://drawable/res_notification_app_icon',
      category: NotificationCategory.Recommendation,
      locked: false,
      id: id,
      channelKey: 'scheduled_channel',
      title:
          '${Emojis.money_money_bag} Payment Reminder ${Emojis.money_money_bag}',
      body: 'Payment Finished? - $body',
      bigPicture: 'asset://assets/notification_map_2.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
    schedule: NotificationCalendar(
        allowWhileIdle: true,
        day: day,
        hour: 20,
        minute: 00,
        second: 0,
        millisecond: 0,
        repeats: true,
        preciseAlarm: true),
  );
}

Future<void> scheduledNotificationEveryday(String name) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      largeIcon: 'resource://drawable/res_notification_app_icon',
      category: NotificationCategory.Recommendation,
      locked: false,
      id: 10111,
      channelKey: 'scheduled_channel',
      title: ' Hello $name! ${Emojis.smile_grinning_face_with_big_eyes}',
      body:
          "Don't forget to add today's income and expense ${Emojis.money_money_bag}",
      bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
    schedule: NotificationCalendar(
        allowWhileIdle: true,
        hour: 21,
        minute: 00,
        second: 0,
        millisecond: 0,
        repeats: true,
        preciseAlarm: true),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> cancelScheduledNotificationsOne(int id) async {
  await AwesomeNotifications().cancelSchedule(id);
}
