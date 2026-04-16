import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class ApiService {
  static const String apiKey = '4748ad20052e4114a3e9385e83ba4863';
  static const String baseUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

  Future<List<News>> fetchTopHeadlines() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      return body.map((item) => News.fromJson(item)).toList();
    } else {
      throw ("Không thể lấy dữ liệu từ Server");
    }
  }
}