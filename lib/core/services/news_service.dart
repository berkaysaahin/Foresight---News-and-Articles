import 'package:flutter/material.dart';

class NewsService with ChangeNotifier {
  List<Map<String, dynamic>> _newsItems = [];

  List<Map<String, dynamic>> get newsItems => _newsItems;

  void setNewsItems(List<Map<String, dynamic>> newsItems) {
    _newsItems = newsItems;
    notifyListeners();
  }

  void addNewsItem(Map<String, dynamic> newsItem) {
    _newsItems.add(newsItem);
    notifyListeners();
  }

  void updateNewsItem(int index, Map<String, dynamic> newsItem) {
    _newsItems[index] = newsItem;
    notifyListeners();
  }

  void removeNewsItem(int index) {
    _newsItems.removeAt(index);
    notifyListeners();
  }
}
