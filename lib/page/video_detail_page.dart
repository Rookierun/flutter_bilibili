import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/app_bar.dart';
import 'package:flutter_bilibili/widget/bili_navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  VideoModel videoModel;

  VideoDetailPage(this.videoModel, {Key? key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: Platform.isIOS,
        context: context,
        child: Scaffold(
            body: Column(
          children: [
            BiLiNavigationBar(
              height: Platform.isIOS ? 46 : 0,
              statusStyle: StatusStyle.LIGHT_CONTENT,
              color: Colors.black,
            ),
            _videoView(),
            Text('视频详情页，vid:${widget.videoModel.vid}'),
            Text('视频详情页，title:${widget.videoModel.title}'),
          ],
        )));
  }

  _videoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url!,
      cover: model.cover,
      overLayUI: videoAppBar(),
    );
  }
}
