import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  final String asset;
  final bool? shouldRepeat;

  const MyVideoPlayer(
    this.asset, {
    this.shouldRepeat,
    Key? key,
  }) : super(key: key);

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  VideoPlayerController? _controller;
  VideoPlayerOptions? _videoPlayerOptions;

  @override
  void initState() {
    _videoPlayerOptions = VideoPlayerOptions(mixWithOthers: true);

    _controller = VideoPlayerController.asset(
      widget.asset,
      videoPlayerOptions: _videoPlayerOptions,
    )..initialize().then((_) => setState(() {}));

    if (widget.shouldRepeat ?? true) {
      _controller?.setLooping(true);
    } else {
      _controller?.setLooping(false);
    }
    _controller?.setVolume(0);
    _controller?.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: VideoPlayer(_controller!),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
