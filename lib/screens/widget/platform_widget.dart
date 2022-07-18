import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  final WidgetBuilder androidBuilder;
  final WidgetBuilder iOSBuilder;

  const PlatformWidget(
      {Key? key, required this.androidBuilder, required this.iOSBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iOSBuilder(context);
      default:
        return androidBuilder(context);
    }
  }
}
