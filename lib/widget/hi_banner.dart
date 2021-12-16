import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo>? bannerList;
  final double? bannerHeight;
  final EdgeInsetsGeometry? padding;

  const HiBanner(
      {Key? key, this.bannerList, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var rightPadding = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList?.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _bannerItem(bannerList?[index]);
      },
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: rightPadding, bottom: 10),
          builder: const DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 8)),
    );
  }

  _bannerItem(BannerMo? bannerMo) {
    return InkWell(
      onTap: () {
        _handleClick(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            bannerMo?.cover ?? "",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _handleClick(BannerMo? bannerMo) {
    if (bannerMo == null) {
      return;
    }
    if (bannerMo.type == 'video') {
      var model = VideoModel();
      model.vid = bannerMo.url;
      HiNavigator().onJumpTo(RouteStatus.detail, args: {'videoMo': model});
    } else {
      print("不是视频类型");
    }
  }
}
