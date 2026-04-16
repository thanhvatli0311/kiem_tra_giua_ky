class News {
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;

  News({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'Không có tiêu đề',
      description: json['description'] ?? 'Không có mô tả',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? 'Nội dung đang cập nhật...',
    );
  }
}