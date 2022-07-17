import 'package:flutter/material.dart';
import 'package:restaurant_dicoding_submission3/utils/navigations.dart';

customDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Coming Soon!'),
        content: const Text('Fitur ini akan segera hadir!'),
        actions: [
          TextButton(
            onPressed: () => Navigation.back(),
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
