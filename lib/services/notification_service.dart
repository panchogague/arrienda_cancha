import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, {ScaffoldMessengerState? scaffold}) {
    final snackbar = SnackBar(
        content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ));

    if (scaffold != null) {
      scaffold.showSnackBar(snackbar);
    } else {
      messengerKey.currentState!.showSnackBar(snackbar);
    }
  }
}
