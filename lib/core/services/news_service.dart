import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresight_news_and_articles/core/models/news_model.dart';

class NewsService {
  final CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('news');
  final CollectionReference _bookmarksCollection =
      FirebaseFirestore.instance.collection('bookmarks');
  // Filter by bookmarked items

  Stream<List<News>> getNewsStream() {
    return _newsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => News.fromFirestore(doc)).toList();
    });
  }

  Stream<List<News>> bookmarkedItemsStream() {
    return _bookmarksCollection
        .where('isBookmarked', isEqualTo: true) // Filter on the server-side
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => News.fromFirestore(doc)).toList();
    });
  }
}
