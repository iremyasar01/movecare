import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movecare/models/VideosModel.dart';
import 'package:movecare/widgets/my_appbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key, this.videoItems});
  VideoItems? videoItems;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late bool _isPlayerReady;

  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoItems?.video?.resourceId?.videoId ?? "",
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      if (_controller.value.isFullScreen) {
        // Tam ekrana geçince yatay moda al
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        // Tam ekrandan çıkınca dikey moda geri dön
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // Videodan çıkınca ekran yönünü varsayılana döndür
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
              widget.videoItems?.video?.title ?? "Video bulunamadı",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded( // 🛠️ Overflow'u önlemek için Expanded ekledik
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  print("Player is ready");
                  _isPlayerReady = true;
                },
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    Expanded(child: player), // 🛠️ YouTube Player'ı genişletiyoruz
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}