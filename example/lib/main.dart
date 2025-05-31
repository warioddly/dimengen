import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dimengen/dimengen.dart';

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
  final _dimengenPlugin = Dimengen();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Dimensions.zero;
    Insets.zero;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderDimensions.m,
          ),
          child: Text('Running on'),
        ),
      ),
    );
  }
}
