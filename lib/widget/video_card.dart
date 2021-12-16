import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoModel;

  VideoCard(this.videoModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("点击了${videoModel.vid}");
      },
      child: Image.network(videoModel.cover!),
    );
  }
}
