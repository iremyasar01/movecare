import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movecare/constants/api_constant.dart';
import 'package:movecare/models/VideosModel.dart';
import 'package:movecare/models/channelModel.dart';
import 'package:movecare/models/searchModel.dart';



class ApiService {
  static const CHANNEL_ID ='UCmTe0LsfEbpkDpgrxKAWbRA'; 
  static const _baseUrl = 'youtube.googleapis.com';

  /*
  curl \
  'https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UCmTe0LsfEbpkDpgrxKAWbRA&q=shoulder%2C%20back%20pain%2C%20hands%2C%20legs%2C%20arms%2Cankle%2Ceye%2Cmuscle%2Cknee%2Cneck&access_token=AIzaSyBJoodBkJbdmkTUh-LhqKg5ctuBFRsbxks&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed
  */

  static Future<ChannelModel> getChannelVideos() async {
    Map<String,String> queryParameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': APIConstant.API_KEY,
    };
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader:'application/json',
      };

      Uri uri = Uri.https(_baseUrl, '/youtube/v3/channels', queryParameters);

    final response = await http.get(uri, headers: headers);
    //print(response.body);


   if (response.statusCode == 200) {
      return ChannelModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load channel videos');
    
    }
  }
  static Future<VideosModel> getVideos({required String playlistId, required String pageToken}) async{
    Map<String,String> Parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': APIConstant.API_KEY,
    };
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader:'application/json',
      };

      Uri uri = Uri.https(_baseUrl, '/youtube/v3/playlistItems', Parameters);

    final response = await http.get(uri, headers: headers);
    //print(response.body);

    VideosModel videosModel = VideosModel.fromJson(jsonDecode(response.body));
    return videosModel;

  }
  static Future<SearchModel> getVideosByKeyword( String keyword) async {
  Map<String, String> qParameters = {
    'part': 'snippet',
    'channelId': CHANNEL_ID,
    'q': keyword, // Burada "leg" gibi aramalar yapılacak
    'maxResults': '8',
    //'pageToken': pageToken,
    'key': APIConstant.API_KEY,
  };
 Map<String,String> headers = {
      HttpHeaders.contentTypeHeader:'application/json',
      };
  Uri uri = Uri.https(_baseUrl, '/youtube/v3/search', qParameters);
  final response = await http.get(uri,headers: headers);
   print("API Response: ${response.body}");

  if (response.statusCode == 200) {
    return SearchModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load videos');
  }
}

  
}