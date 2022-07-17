import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_dicoding_submission3/database/helper/date_time_helper.dart';
import 'package:restaurant_dicoding_submission3/utils/backgrounds_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<bool> scheduleReminder(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      Fluttertoast.showToast(msg: 'Jadwal Aktif');
      print('Scheduling Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      Fluttertoast.showToast(msg: 'Jadwal Tidak Aktif');
      print('Scheduling Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
