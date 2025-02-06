import 'package:flutter/material.dart';
import 'package:movecare/models/searchModel.dart';
import 'package:movecare/screens/search_player_screen.dart';
import 'package:movecare/services/api_service.dart';
import 'package:movecare/widgets/my_appbar.dart';

class EyeScreen extends StatefulWidget {
  @override
  _EyeScreenState createState() => _EyeScreenState();
}

class _EyeScreenState extends State<EyeScreen> {
  final String searchKeyword = "eye"; // Sabit arama terimi
  final ScrollController _scrollController = ScrollController(); // Kaydırma kontrolcüsü

  List<SearchItems> search = [];
  String? nextPageToken;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchVideos(); // İlk veri yükleme

    // Scroll event'ini dinleyerek sonsuz kaydırmayı etkinleştir
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        fetchVideos(loadMore: true); // Sayfanın sonuna yaklaşıldığında yeni verileri yükle
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Bellek sızıntısını önlemek için kontrolcüyü temizle
    super.dispose();
  }

  Future<void> fetchVideos({bool loadMore = false}) async {
    if (isLoading) return; // Eğer zaten yükleme yapılıyorsa tekrar çağırma

    setState(() {
      isLoading = true;
    });

    try {
      SearchModel result = await ApiService.getVideosByKeyword(
        searchKeyword,
        loadMore ? nextPageToken : null,
      );

      // 🔹 SADECE "eye" KELİMESİNİ İÇERENLERİ AL
      List<SearchItems> filteredResults = (result.searchItems ?? []).where((video) {
        String title = video.search?.title?.toLowerCase() ?? "";
        String description = video.search?.description?.toLowerCase() ?? "";
        return title.contains("eye") || description.contains("eye"); // Sadece "eye" geçenleri al
      }).toList();

      setState(() {
        if (loadMore) {
          search.addAll(filteredResults); // Önceki listeye ekle
        } else {
          search = filteredResults; // Yeni liste olarak ata
        }
        nextPageToken = result.nextPageToken; // Yeni sayfa token'ı al
      });
    } catch (e) {
      print("Error fetching videos: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/eye.png',
              height: 200,
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // ScrollController ekledik
              itemCount: search.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == search.length) {
                  // Eğer yükleme yapılıyorsa son eleman yerine loading göster
                  return const Center(child: CircularProgressIndicator());
                }

                final video = search[index];
                return ListTile(
                  leading: video.search?.thumbnails?.medium?.url != null
                      ? Image.network(video.search!.thumbnails!.medium!.url!)
                      : const Icon(Icons.video_collection),
                  title: Text(video.search?.title ?? "No title"),
                  subtitle: Text(video.search?.channelTitle ?? "Unknown channel"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPlayerScreen(searchItems: search[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
