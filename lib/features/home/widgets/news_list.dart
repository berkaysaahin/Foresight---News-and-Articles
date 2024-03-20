import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/dummy.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list_item.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => NewsListItem(
          imageAssetPath: newsrItems[i]['imageAssetPath']!,
          category: newsrItems[i]['category']!,
          title: newsrItems[i]['title']!,
          content: newsrItems[i]['content']!,
          author: newsrItems[i]['author']!,
          authorImageAssetPath: newsrItems[i]['authorImageAssetPath']!,
          date: DateTime.parse(newsrItems[i]['date']!),
        ),
        childCount: newsrItems.length,
      ),
    );
  }
}


//1.20