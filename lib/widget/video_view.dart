import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/hi_video_controls.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String? cover;
  final bool? autoPlay;
  final bool? looping;
  double aspectRatio;
  Widget? overLayUI;
  VideoView(this.url,
      {Key? key,
      this.cover = "",
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overLayUI})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController; //video_player播放器Controller
  late ChewieController _chewieController; //chewie播放器Controller
  //封面
  get _placeHolder => FractionallySizedBox(
        widthFactor: 1,
        child: cachedImage(widget.cover!),
      );
  get _progressColor => ChewieProgressColors(
        playedColor: primary,
        handleColor: primary,
        backgroundColor: Colors.grey,
        bufferedColor: primary[50]!,
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化播放器设置
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay ?? false,
        looping: widget.looping ?? false,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        placeholder: _placeHolder,
        materialProgressColors: _progressColor,
        customControls: MaterialControls(
          showLoadingOnInitialize: false,
          showBigPlayIcon: false,
          bottomGradient: blackLinearGradient(fromTop: false),
          overlayUI: widget.overLayUI,
        ));
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    // print("$screenWidth,$playerHeight");
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    _chewieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
