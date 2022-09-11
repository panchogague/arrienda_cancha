import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowConfirmHelper {
  String title;
  String subtitle;
  VoidCallback? onPressed;

  ShowConfirmHelper({
    required this.title,
    required this.subtitle,
    this.onPressed,
  });

  showAlert(BuildContext context) {
    if (kIsWeb || Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(title),
                content: Text(subtitle),
                actions: <Widget>[
                  MaterialButton(
                      elevation: 5,
                      textColor: Colors.blue,
                      onPressed: onPressed,
                      child: const Text('Ok')),
                  MaterialButton(
                      elevation: 5,
                      textColor: Colors.red,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'))
                ],
              ));
    }

    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: onPressed,
                    child: const Text('Ok')),
                CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'))
              ],
            ));
  }
}
