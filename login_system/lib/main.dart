// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:login_system/screens/home_screen.dart';
import 'package:login_system/screens/logii_screen.dart';
import 'package:login_system/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await getToken();
  runApp(MyApp(token));
}

class MyApp extends StatefulWidget {
  String? token;
  MyApp(this.token);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget.token == null
          ? LoginScreen((String token) {
              setState(() {
                widget.token = token;
              });
            })
          : HomeScreen(() {
              setState(() {
                widget.token = null;
              });
            }),
    );
  }
}
