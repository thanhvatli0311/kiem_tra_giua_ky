import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/news_provider.dart';
import '../widgets/news_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin tức yêu thích'),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          // Kiểm tra nếu chưa có bài báo nào được yêu thích
          if (provider.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có bài viết yêu thích nào',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            );
          }

          // Hiển thị danh sách yêu thích sử dụng lại NewsCard
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              final item = provider.favorites[index];
              return NewsCard(news: item);
            },
          );
        },
      ),
    );
  }
}