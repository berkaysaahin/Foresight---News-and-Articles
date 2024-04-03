import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list.dart';

class AllNewsPage extends StatelessWidget {
  const AllNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // SecondaryTopButtons(
            //   pageTitle: 'All News',
            //  ),
            NewsList(),
          ],
        ),
      ),
    );
  }
}
