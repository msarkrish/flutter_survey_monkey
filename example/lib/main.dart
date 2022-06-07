import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_survey_monkey/flutter_survey_monkey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _isSurveyCompleted = {};
  final _flutterSurveyMonkeyPlugin = FlutterSurveyMonkey();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Map isSurveyCompleted = {};
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      bool isSurveyCompleted = await _flutterSurveyMonkeyPlugin.openSurvey(
            surveyHash: "",
          ) ??
          false;
    } catch (e, s) {
      isSurveyCompleted = {};
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isSurveyCompleted = isSurveyCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: ${_isSurveyCompleted.toString()} \n'),
        ),
      ),
    );
  }
}
