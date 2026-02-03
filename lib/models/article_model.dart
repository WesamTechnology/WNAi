class ArticleModel {
  final String? image;
  final String title;
  final String? subtitle;
  final String? content;
  final String? url;
  final String? source;
  final String? publishedAt;

  ArticleModel({
    required this.image,
    required this.title,
    required this.subtitle,
    this.content,
    this.url,
    this.source,
    this.publishedAt,
  });
}
