import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  var listener;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HiNavigator().addListener(listener = (current, pre) {
      if (widget == current.page || current.page is HomePage) {
        print("homepage onresume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("homepage onPause");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    HiNavigator().removeListener((current, pre) => listener);
  }

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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
