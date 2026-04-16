import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/api_service.dart';

class NewsProvider with ChangeNotifier {
  List<News> _allNews = [];
  List<News> _filteredNews = [];
  List<News> _favorites = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<News> get news => _filteredNews;
  List<News> get favorites => _favorites;
  bool get isLoading => _isLoading;

  // Lấy dữ liệu
  Future<void> loadNews() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));

    try {
      _allNews = await ApiService().fetchTopHeadlines();
      _filteredNews = _allNews;
    } catch (e) {
      // Xử lý lỗi: Mất mạng hoặc API die
      _errorMessage = "Không thể tải tin tức. Vui lòng kiểm tra kết nối mạng!";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Tìm kiếm
  void searchNews(String query) {
    if (query.isEmpty) {
      _filteredNews = _allNews;
    } else {
      _filteredNews = _allNews
          .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Quản lý yêu thích
  void toggleFavorite(News item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }
}