import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_archive_info/package_archive_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PackageArchiveInfo _info;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    PackageArchiveInfo info;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      info = await PackageArchiveInfo.fromPath("Your path");
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _info = info;
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
          child: Text('Running on: info\n'
              "appName = ${_info?.appName}\n"
              "packageName = ${_info?.packageName}\n"
              "version = ${_info?.version}\n"
              "buildNumber = ${_info?.buildNumber}\n"),
        ),
      ),
    );
  }
}
