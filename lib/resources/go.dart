import 'package:flutter/material.dart';

class Go {
  final BuildContext context;
  Go(this.context);

  void push(Widget widget) => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
        ),
      );

  Size get size => MediaQuery.of(context).size;

  double get appbarTitleSize => size.height * 0.032;
}
