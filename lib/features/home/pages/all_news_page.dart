import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list.dart';
import 'package:foresight_news_and_articles/features/home/widgets/secondary_top_buttons.dart';

class AllNewsPage extends StatelessWidget {
  final List<Map<String, dynamic>> newsItems;

  const AllNewsPage({Key? key, required this.newsItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SecondaryTopButtons(pageTitle: 'All News'),
            NewsList(newsItems: newsItems),
          ],
        ),
      ),
    );
  }
}
