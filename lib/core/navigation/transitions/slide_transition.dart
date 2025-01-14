import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page slideInTransition({required Widget child, required GoRouterState state}) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      var begin = const Offset(10, 0);
      var end = Offset.zero;
      var curve = Curves.easeInExpo;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: page);
    },
    child: child,
  );
}
