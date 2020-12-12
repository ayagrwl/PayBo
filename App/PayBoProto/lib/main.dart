import 'package:PayBoProto/screens/SliderScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Bo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SliderScreen(),
    );
  }
}
