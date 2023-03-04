import 'package:flutter/material.dart';
import 'package:weather/screens/loadingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Weather",
        debugShowCheckedModeBanner: false,
        home: LoadingScreen());
  }
}
