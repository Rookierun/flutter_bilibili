import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_state.dart';
import 'package:flutter_bilibili/dao/home_dao.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';
import 'package:flutter_bilibili/widget/video_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  String? name;
  List<BannerMo>? bannerList;

  HomeTabPage({Key? key, this.name, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends HiState<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  List<VideoModel> videoList = [];
  int pageIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            crossAxisCount: 2,
            itemCount: videoList.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.bannerList != null && index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _banner(),
                );
              } else {
                return VideoCard(videoList[index]);
              }
            },
            staggeredTileBuilder: (int index) {
              if (widget.bannerList != null && index == 0) {
                return const StaggeredTile.fit(2);
              }
              return const StaggeredTile.fit(1);
            }));
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: HiBanner(
        bannerList: widget.bannerList,
      ),
    );
  }

  void loadData({loadMore = false}) async {
    try {
      if (loadMore) {
        pageIndex = 1;
      }
      var currentIndex = pageIndex + (loadMore ? 1 : 0);
      HomeMo result = await HomeDao.get(widget.name!,
          pageIndex: currentIndex, pageSize: 50);
      setState(() {
        if (loadMore) {
          if (result.videoList != null && result.videoList!.isNotEmpty) {
            pageIndex++;
            videoList = [...videoList, ...result.videoList!];
          }
        } else {
          videoList = result.videoList ?? [];
        }
      });
    } on NeedAuth catch (e) {
      print("loadData exception:$e");
      showWarnToast(e.toString());
    } on HiNetError catch (e) {
      print("loadData hiNetError exception:$e");
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
