import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/news_provider.dart';
import 'views/screens/home_screen.dart';

void main() {
  runApp(
    // Khởi tạo Provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,

      // Thiết lập Theme theo phong cách Clean Minimalism & Card-based
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Màu nền xám nhạt cực sạch

        // Cấu hình Card mặc định cho toàn app
        cardTheme: CardThemeData(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),

        // Cấu hình AppBar gọn gàng
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 1,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      home: const HomeScreen(),
    );
  }
}