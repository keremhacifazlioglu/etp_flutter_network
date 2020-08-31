import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  MessageContainer(
      {Key key,
      @required this.child,
      this.message = "",
      this.actionText = "",
      this.icon,
      this.isShow = false,
      this.actionTap})
      : super(key: key);

  final Widget child;
  final bool isShow;
  final IconData icon;
  final String message;
  final String actionText;
  final Function actionTap;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      Visibility(
        visible: isShow,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: 100,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(onPressed: actionTap, child: Text(actionText),color: Theme.of(context).accentColor,)
            ],
          )))
    ]);
  }
}
