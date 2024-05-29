class News {
  String imageAssetPath;
  String category;
  String author;
  String date;
  String title;
  String content;
  String authorImageAssetPath;

  News({
    required this.imageAssetPath,
    required this.category,
    required this.author,
    required this.date,
    required this.title,
    required this.content,
    required this.authorImageAssetPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageAssetPath': imageAssetPath,
      'category': category,
      'author': author,
      'date': date,
      'title': title,
      'content': content,
      'authorImageAssetPath': authorImageAssetPath,
    };
  }
}
