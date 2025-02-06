import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movecare/models/VideosModel.dart';
import 'package:movecare/models/channelModel.dart';
import 'package:movecare/screens/video_player_screen.dart';
import 'package:movecare/services/api_service.dart';
import 'package:movecare/widgets/my_appbar.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  ChannelModel? _channelModel;
  VideosModel? _videosModel;
   Items? _item;
  bool isLoading = true;
   String? _playlistId;
   String? _nextPageToken;
  late  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
     _videosModel = VideosModel();
     _videosModel!.videos = [];
     _nextPageToken = '';
    _getChannelVideos();
  }

  _getChannelVideos() async {
    try {
      final channelModel = await ApiService.getChannelVideos();
       _channelModel = channelModel;
        _item = _channelModel?.items?[0];
         _playlistId = _item?.contentDetails?.relatedPlaylists?.uploads;
        print(_playlistId);
        await _loadVideos();
      setState(() {
       // _channelModel = channelModel;
        //_item = _channelModel?.items?[0];
        isLoading = false;
        //_playlistId = _item?.contentDetails?.relatedPlaylists?.uploads;
        //print(_playlistId);
       
      });
    } catch (e) {
      setState(() => isLoading = false);
      // Hata yönetimi ekleyin
    }
  }
 _loadVideos() async{
    VideosModel tempVideos = await ApiService.getVideos(
      playlistId: _playlistId!,
      pageToken: _nextPageToken!,
   );
      _nextPageToken = tempVideos.nextPageToken;
      _videosModel!.videos!.addAll(tempVideos.videos!);
      //debugPrint('videos: ${_videosModel!.videos!.length}' );
      // Debug: Gelen videoların thumbnail URL'lerini kontrol edin
  // for (var video in _videosModel!.videos!) {
   // debugPrint('Video ID: ${video.id}');
    //debugPrint('Thumbnail URL: ${video.video?.thumbnails?.ThumbnailsDefault?.url}');
 // }

      setState(() {
        
      });
   
     }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Container(
        color: Colors.green,
        child: Column(
          children: [_buildInfoView(),
          Expanded(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollNotification notification){
                if(_videosModel!.videos!.length >= int.parse(_item!.statistics!.videoCount ?? '0')){
                  return true;
                }
                if(notification.metrics.pixels == notification.metrics.maxScrollExtent){
                  _loadVideos();
                }
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _videosModel!.videos!.length,
                itemBuilder: (context, index) {
                  VideoItems videoItems = _videosModel!.videos![index];
                  return  InkWell(onTap: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoItems: videoItems)));
                  },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                     child:  Row(
                        children: [CachedNetworkImage(
                                 imageUrl: videoItems.video?.thumbnails?.ThumbnailsDefault?.url ?? 'https://via.placeholder.com/120',
                       ),
                       const SizedBox(width: 20),
                       Flexible(child: Text(videoItems.video?.title ?? 'No title available')),
                        const SizedBox(width: 20),
                        ],
                      ),
                                
                    ),
                  );
                },
              ),
            ),
          )],
        ),
      ),
    );
  }

  Widget _buildInfoView() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
          padding: const EdgeInsets.all(20),
          child: Card(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      _item?.snippet?.thumbnails?.medium?.url ?? '',
                    ),
                  ),
                  const SizedBox(width: 20),
                 
                     Expanded(
                       child: Text(
                        _item?.snippet?.title ?? 'No title available',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                                           ),
                     ),
                  Text(_item?.statistics?.videoCount ?? 'No view count available'),
                   const SizedBox(width: 20),
                
                ],
              ),
            ),
        );
  }
}