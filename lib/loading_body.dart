import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingBody extends StatelessWidget {
  LoadingBody(
      {Key key,
      @required this.child,
      this.loadingText = "Loading...",
      this.isLoading = false,
      this.color = Colors.blue})
      : super(key: key);

  final Widget child;
  final bool isLoading;
  final String loadingText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
            visible: isLoading,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoActivityIndicator(
                        radius: 20,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        loadingText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
