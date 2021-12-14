import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';

class HomePage extends StatefulWidget {
  late ValueChanged<VideoModel>? onJumpToDetail;

  HomePage({this.onJumpToDetail});

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
              onPressed: () => widget.onJumpToDetail!(VideoModel(111)),
              child: const Text('跳转到详情吧'),
            )
          ],
        ),
      ),
    );
  }
}
