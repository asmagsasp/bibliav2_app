import 'package:flutter/material.dart';
import 'widgets/splash_screen.dart';
void main() => runApp(new BibleApp());

class BibleApp extends StatelessWidget {
  // Esse é o root da aplicaçãod a Bíblia
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Bíblia Católica',
      theme: new ThemeData.dark(),
      home: new SplashScreen()
    );
  }
}
