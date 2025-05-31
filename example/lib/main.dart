import 'package:dimengen_example/insets.dart';
import 'package:dimengen_example/spaces.dart';
import 'package:flutter/material.dart';

import 'dimensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: Insets.m,
          margin: Insets.m,
          decoration: BoxDecoration(
            borderRadius: Borders.sTopLeft,
            color: Colors.blue.shade100,
          ),
          child: Column(
            children: [

              Text('Design Dimensions'),
              Spaces.mVertical,
              Text('M: ${Dimensions.m}'),
              Spaces.h(Dimensions.m),

            ],
          )
        ),
      ),
    );
  }
}
