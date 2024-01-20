import 'package:flutter/material.dart';
import 'package:weather_app/Views/homescreen.dart';

void main() {
  debugPrint = (String? message, {int? wrapWidth}) {};
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: HomeScreen(),
    );
  }
}
