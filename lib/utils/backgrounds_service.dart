import 'dart:isolate';
import 'dart:ui';
import 'package:http/http.dart';
import 'package:restaurant_dicoding_submission3/api/api.dart';
import 'package:restaurant_dicoding_submission3/database/helper/notification_helper.dart';
import 'package:restaurant_dicoding_submission3/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializedIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await Api().getTopHeadlines(Client());
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
