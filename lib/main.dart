import 'package:corona_tracker/screens/splash.dart';
import 'package:corona_tracker/utils/locator.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Tracker',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Ubuntu'),
      home: Splash(),
    );
  }
}
