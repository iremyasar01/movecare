import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movecare/models/searchModel.dart';
import 'package:movecare/screens/search_player_screen.dart';
import 'package:movecare/services/api_service.dart';
import 'package:movecare/widgets/my_appbar.dart';

class LegsScreen extends StatefulWidget {
  const LegsScreen({super.key});

  @override
  State<LegsScreen> createState() => _LegsScreenState();
}

class _LegsScreenState extends State<LegsScreen> {
  List<SearchItems> _searchItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchLegVideos();
  }

  Future<void> _fetchLegVideos() async {
    try {
      final SearchModel response = await ApiService.getVideosByKeyword("leg");
      if (response.searchItems == null) throw Exception("No videos found");
      
      setState(() {
        _searchItems = response.searchItems!;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Videolar yüklenirken hata oluştu: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _searchItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final search = _searchItems[index];
          return _VideoCard(search: search);
        },
      );
    }
  }
}

class _VideoCard extends StatelessWidget {
  final SearchItems search;

  const _VideoCard({required this.search});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _navigateToPlayer(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: search.search?.thumbnails?.medium?.url ?? 
                    'https://placehold.co/120x68',
                  width: 120,
                  height: 68,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const CircularProgressIndicator(),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 16),
              // Video Bilgileri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      search.search?.title ?? "Başlıksız Video",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      search.search?.channelTitle ?? "Bilinmeyen Kanal",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPlayer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPlayerScreen(searchItems: search),
    )
    );
  
  }
}




 

