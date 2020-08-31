import 'package:flutter/material.dart';

class ProgressDialog {
  static Future<void> show(
      BuildContext context, GlobalKey key,{bool isCancelable = false}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: isCancelable,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async {
                Navigator.of(key.currentContext, rootNavigator: true).pop();
                return false;
              },
              child: SimpleDialog(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                key: key,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange)),
                  )
                ],
              ));
        });
  }

  static Future<void> hide(GlobalKey key) async {
    Navigator.of(key.currentContext,rootNavigator: true).pop();
  }
}
