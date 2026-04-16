import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/news_model.dart';
import '../../viewmodels/news_provider.dart';

class DetailScreen extends StatelessWidget {
  final News news;

  const DetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    // Định dạng ngày
    DateTime? publishedDate = DateTime.tryParse(news.publishedAt);
    String formattedDate = publishedDate != null
        ? DateFormat('d MMMM, y HH:mm').format(publishedDate)
        : 'Không rõ ngày';

    return Scaffold(
      // Nút "Back"
      appBar: AppBar(
        title: const Text('Chi tiết tin tức'),
        actions: [
          // Nút "Yêu thích"
          Consumer<NewsProvider>(
            builder: (context, provider, child) {
              final isFav = provider.favorites.contains(news);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed: () {
                  provider.toggleFavorite(news);
                  // Hiện thông báo nhỏ khi nhấn
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isFav ? 'Đã xóa khỏi yêu thích' : 'Đã thêm vào yêu thích'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh lớn ở trên cùng
            Image.network(
              news.urlToImage,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => const SizedBox(
                height: 200,
                child: Center(child: Icon(Icons.broken_image, size: 100)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề bài báo
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Ngày đăng bài
                  Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.blueAccent, fontSize: 13),
                  ),

                  const Divider(height: 30),

                  // Nội dung đầy đủ
                  Text(
                    news.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}