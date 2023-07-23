import 'dart:io';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoMessageItem extends StatefulWidget {
  final String path;
  const VideoMessageItem({Key? key, required this.path}) : super(key: key);

  @override
  State<VideoMessageItem> createState() => _VideoMessageItemState();
}

class _VideoMessageItemState extends State<VideoMessageItem> {

  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    if(widget.path.contains("http")){
      videoPlayerController =
      VideoPlayerController.networkUrl(Uri.parse(widget.path))
        ..initialize().then((value) => setState(() {
          isPlay = true;
        }));
    }else{
      videoPlayerController =
      VideoPlayerController.file(File(widget.path))
        ..initialize().then((value) => setState(() {
          isPlay = true;
        }));
    }

    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isPlay ? SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: SafeArea(
        child : CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController,
        ),
      ),
    ) : Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
          color:  Colors.grey.withOpacity(0.5)
      ),
      width: 100.w,
      height: 100.h,
      alignment: Alignment.center,
      child: const CupertinoActivityIndicator(),
    );
  }
}
