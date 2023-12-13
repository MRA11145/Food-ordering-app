import 'package:flutter/material.dart';
import 'package:plateron_app/screens/home_screen.dart';
import '../screens/checkout_screen.dart';

class ScreenTrans {
  static Route checkOutScreen() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: CheckOutScreen.routeName),
      pageBuilder: (context, animation, secondaryAnimation) => const CheckOutScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route homeScreen() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: HomeScreen.routeName),
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
