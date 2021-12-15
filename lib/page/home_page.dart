import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            const Text('首页'),
            MaterialButton(
              onPressed: () {
                HiNavigator().onJumpTo(RouteStatus.detail,
                    args: {'videoMo': VideoModel(111)});
              },
              child: const Text('跳转到详情吧'),
            )
          ],
        ),
      ),
    );
  }
}
