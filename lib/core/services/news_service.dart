import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresight_news_and_articles/core/models/news_model.dart';

class NewsService {
  final CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('news');

  Stream<List<News>> getNewsStream() {
    return _newsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => News.fromFirestore(doc)).toList();
    });
  }
}
