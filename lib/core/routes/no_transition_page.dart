import 'package:flutter/material.dart';

class NoTransitionPage extends Page {
  final Widget child;

  const NoTransitionPage({
    required LocalKey key,
    required this.child,
  }) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
