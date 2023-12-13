import 'package:flutter/material.dart';
import 'package:plateron_app/providers/orders.dart';
import 'package:plateron_app/screens/checkout_screen.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  var routes = {
    HomeScreen.routeName: (context) => const HomeScreen(),
    CheckOutScreen.routeName: (context) => const CheckOutScreen(),
  };

  var initialRoute = HomeScreen.routeName;

  @override
  Widget build(BuildContext context) {
    initialRoute = initialRoute;
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Orders())],
      child: MaterialApp(
        initialRoute: initialRoute,
        routes: routes,
        debugShowCheckedModeBanner: true,
      ),
    );
  }
}
