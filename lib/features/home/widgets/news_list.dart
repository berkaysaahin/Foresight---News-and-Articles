import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list_item.dart';

class NewsList extends StatefulWidget {
  final List<Map<String, dynamic>> newsItems;
  const NewsList({Key? key, required this.newsItems}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => NewsListItem(
          imageAssetPath: widget.newsItems[i]['imageAssetPath']!,
          authorImageAssetPath: widget.newsItems[i]['authorImageAssetPath']!,
          category: widget.newsItems[i]['category']!,
          title: widget.newsItems[i]['title']!,
          content: widget.newsItems[i]['content']!,
          author: widget.newsItems[i]['author']!,
          date: widget.newsItems[i]['date']!,
        ),
        childCount: widget.newsItems.length,
      ),
    );
  }
}
