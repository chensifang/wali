import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wali/feedback.dart';
import 'package:wali/feedback_debug.dart';
import 'package:wali/share.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Prefs.initSharedPreferences();
      runApp(MyApp());
    },
    (error, st) => print(error),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Tool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pages = [FeedbackPage(), FeedbackPageDebug()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(currentIndex);
    print(pages[currentIndex]);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        onTap: (index) {
          changePage(index);
        },
      ),
      body: pages[this
          .currentIndex], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      label: "反馈工具",
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.message),
      label: "反馈调试",
    ),
  ];
}
