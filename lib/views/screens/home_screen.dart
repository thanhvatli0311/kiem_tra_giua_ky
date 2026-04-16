import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/news_provider.dart';
import '../widgets/news_card.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Xử lý gọi API và hiển thị lỗi ngay khi khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<NewsProvider>();
      await provider.loadNews();

      // Kiểm tra nếu có lỗi sau khi load thì hiển thị SnackBar
      if (provider.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Thử lại',
              textColor: Colors.white,
              onPressed: () => provider.loadNews(),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin Tức Mới'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm tin tức...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => context.read<NewsProvider>().searchNews(value),
            ),
          ),

          // Khu vực hiển thị danh sách, Loading và Thông báo lỗi
          Expanded(
            child: Consumer<NewsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Nếu có lỗi và không có dữ liệu để hiển thị
                if (provider.errorMessage.isNotEmpty && provider.news.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 60, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(provider.errorMessage),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => provider.loadNews(),
                          child: const Text('Tải lại trang'),
                        ),
                      ],
                    ),
                  );
                }

                // Nếu danh sách trống
                if (provider.news.isEmpty) {
                  return const Center(
                    child: Text('Không tìm thấy tin tức nào.'),
                  );
                }

                // Danh sách chính với tính năng Pull-to-refresh
                return RefreshIndicator(
                  onRefresh: () => provider.loadNews(),
                  child: ListView.builder(
                    itemCount: provider.news.length,
                    padding: const EdgeInsets.only(bottom: 20),
                    itemBuilder: (context, index) {
                      final item = provider.news[index];
                      return NewsCard(news: item);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}