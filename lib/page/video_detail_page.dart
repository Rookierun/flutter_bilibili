import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/app_bar.dart';
import 'package:flutter_bilibili/widget/bili_navigation_bar.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  VideoModel videoModel;

  VideoDetailPage(this.videoModel, {Key? key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  List<String> tabs = ["简介", "评论"];
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
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
            _buildVideoView(),
            _buildTabView()
          ],
        )));
  }

  _buildVideoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url!,
      cover: model.cover,
      overLayUI: videoAppBar(),
    );
  }

  _buildTabView() {
    return Material(
      elevation: 5,
      shadowColor: Colors.red,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        color: Colors.white,
        height: 39,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((tab) {
        return Tab(
          text: tab,
        );
      }).toList(),
      controller: _controller,
    );
  }
}
