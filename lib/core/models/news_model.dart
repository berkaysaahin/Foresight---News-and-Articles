import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String imageAssetPath;
  String category;
  String author;
  String date;
  String title;
  String content;
  String authorImageAssetPath;
  bool isBookmarked;

  News({
    required this.imageAssetPath,
    required this.category,
    required this.author,
    required this.date,
    required this.title,
    required this.content,
    required this.authorImageAssetPath,
    this.isBookmarked = false,
  });
  factory News.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return News(
      imageAssetPath: data['imageAsset'] ?? '', // Provide default empty string
      category: data['category'] ?? '', // Provide default empty string
      author: data['author'] ?? '', // Provide default empty string
      date: data['date'] ?? '', // Provide default empty string
      title: data['title'] ?? '', // Provide default empty string
      content: data['content'] ?? '', // Provide default empty string
      authorImageAssetPath:
          data['authorImage'] ?? '', // Provide default empty string
      isBookmarked:
          data['isBookmarked'] ?? false, // Provide default value false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageAssetPath': imageAssetPath,
      'category': category,
      'author': author,
      'date': date,
      'title': title,
      'content': content,
      'authorImageAssetPath': authorImageAssetPath,
      'isBookmarked': isBookmarked,
    };
  }
}
