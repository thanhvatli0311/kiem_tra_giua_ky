import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/news_model.dart';
import '../screens/detail_screen.dart';

class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    // Chuyển đổi chuỗi ISO ngày tháng sang dạng d/M/y
    DateTime? publishedDate;
    try {
      publishedDate = DateTime.parse(news.publishedAt);
    } catch (e) {
      publishedDate = null;
    }
    String formattedDate = publishedDate != null
        ? DateFormat('d/M/y HH:mm').format(publishedDate)
        : 'Không rõ ngày';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(news: news),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh minh họa
            if (news.urlToImage != null && news.urlToImage.startsWith('http'))
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  news.urlToImage,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image, size: 50),
                ),
              )
            else
            // Hiển thị Placeholder nếu ảnh lỗi
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
              ),

            const SizedBox(height: 12),

            // Tiêu đề
            Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            // Tóm tắt
            Text(
              news.description ?? 'Không có tóm tắt.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 10),

            // Ngày đăng
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blueAccent,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}