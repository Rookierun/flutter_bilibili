import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/util/format_util.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoModel;

  VideoCard(this.videoModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HiNavigator()
            .onJumpTo(RouteStatus.detail, args: {'videoMo': videoModel});
      },
      child: SizedBox(
        height: 200,
        child: Card(
          margin: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_itemImage(context), _infoText()],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        FadeInImage.memoryNetwork(
          height: 120,
          width: size.width / 2 - 20,
          placeholder: kTransparentImage,
          image: videoModel.cover!,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 3),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.transparent])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.ondemand_video, videoModel.view),
                _iconText(Icons.favorite_border, videoModel.favorite),
                _iconText(null, videoModel.duration),
              ],
            ),
          ),
        )
      ],
    );
  }

  _iconText(IconData? iconData, int? count) {
    String views = "";
    if (iconData != null) {
      views = countFormat(count ?? 0);
    } else {
      views = durationTransform(videoModel.duration ?? 0);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: Colors.white,
            size: 12,
          ),
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Text(
            views,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        )
      ],
    );
  }

  _infoText() {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            videoModel.title ?? "标题为空",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          _owner(),
        ],
      ),
    ));
  }

  _owner() {
    var owner = videoModel.owner;
    var faceUrl = owner?.face ?? "";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                faceUrl,
                width: 24,
                height: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                owner?.name ?? "名字是空的",
                style: const TextStyle(fontSize: 11, color: Colors.black87),
              ),
            ),

          ],
        ),
        const Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        )
      ],
    );
  }
}
