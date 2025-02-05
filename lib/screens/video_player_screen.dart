import 'package:flutter/material.dart';
import 'package:movecare/models/VideosModel.dart';
import 'package:movecare/widgets/my_appbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerScreen extends StatefulWidget {
 VideoPlayerScreen({this.videoItems});
 final VideoItems? videoItems;
  //const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late bool _isPlayerReady;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(initialVideoId: widget.videoItems?.video?.resourceId?.videoId ??"",
    flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    )..addListener(_listener);
  }
  void _listener(){
    if(_isPlayerReady && mounted && !_controller.value.isFullScreen){
      // do something
    }
  }
  @override
  void deactivate() {
    _controller.pause();
    // TODO: implement deactivate
    super.deactivate();
  }
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const MyAppBar(),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.videoItems?.video?.title ?? "Başlık bulunamadı",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
         Container(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print("player is ready");
              _isPlayerReady = true;
            },
          ),
        ),
      ],
    ),
  );
}

}