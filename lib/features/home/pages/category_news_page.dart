import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/models/news_model.dart';
import 'package:foresight_news_and_articles/core/services/news_service.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list.dart';
import 'package:foresight_news_and_articles/features/home/widgets/secondary_top_buttons.dart';

class CategoryNewsPage extends StatelessWidget {
  final String category;
  final NewsService newsService;

  const CategoryNewsPage(
      {Key? key, required this.category, required this.newsService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SecondaryTopButtons(pageTitle: ''),
        StreamBuilder<List<News>>(
          stream: newsService.getNewsByCategory(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return const SliverFillRemaining(
                  child: Center(child: Text('Error occurred')));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SliverFillRemaining(
                  child: Center(child: Text('No news available')));
            }

            final List<News> newsItems = snapshot.data!;

            return NewsList(newsItems: newsItems);
          },
        ),
      ]),
    );
  }
}
