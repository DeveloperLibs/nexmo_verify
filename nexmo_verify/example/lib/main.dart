import 'package:flutter/material.dart';
import 'package:nexmo_verify_example/mobile_register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MobileRegisterScreenState(),
    );
  }

}
