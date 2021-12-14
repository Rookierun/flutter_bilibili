import 'package:flutter/material.dart';
import 'package:flutter_bilibili/dao/login_dao.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/util/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    _testLogin();
  }

  @override
  Widget build(BuildContext context) {
    HiCache.preInit();
    return MaterialApp(
      title: "FlutterDemo",
      theme: ThemeData(primarySwatch: white),
      home: LoginPage(),
    );
  }

  void _testLogin() async {
    try {
      var result = await LoginDao.login("jvadd", "dddd112002");
      // var result = await LoginDao.registration("123", "456", "123", "356");
      print("testLogin:$result");
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }
}
