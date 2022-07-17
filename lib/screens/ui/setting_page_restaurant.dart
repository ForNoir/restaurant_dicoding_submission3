import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/preference_provider.dart';
import 'package:restaurant_dicoding_submission3/api/provider/scheduling_provider.dart';

class SettingPageRestaurant extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  static const String routeName = '/settings_page_restaurant';

  const SettingPageRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                    value: provider.isDarkTheme,
                    onChanged: (value) {
                      provider.enableDarkTheme(value);
                    }),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Notification Daily Restaurant'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                        value: scheduled.isScheduled,
                        onChanged: (value) async {
                          scheduled.scheduleReminder(value);
                        });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
