import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/models/news_model.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list_item.dart';

class NewsList extends StatefulWidget {
  final List<News> newsItems;
  const NewsList({Key? key, required this.newsItems}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final News newsItem = widget.newsItems[index];
          return NewsListItem(
            imageAssetPath: newsItem.imageAssetPath,
            authorImageAssetPath: newsItem.authorImageAssetPath,
            category: newsItem.category,
            title: newsItem.title,
            content: newsItem.content,
            author: newsItem.author,
            date: newsItem.date,
            isBookmarked: newsItem.isBookmarked,
          );
        },
        childCount: widget.newsItems.length,
      ),
    );
  }
}
