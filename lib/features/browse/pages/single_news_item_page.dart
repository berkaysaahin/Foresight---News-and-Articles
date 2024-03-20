import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/widgets/single_news_item_header_delegate.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class SingleNewsItemPage extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String category;
  final String authorImageAssetPath;
  final String imageAssetPath;
  final DateTime date;
  const SingleNewsItemPage(
      {super.key,
      required this.title,
      required this.content,
      required this.author,
      required this.category,
      required this.authorImageAssetPath,
      required this.imageAssetPath,
      required this.date});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final maxScreenSizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SingleNewsItemHeaderDelegate(
              title: title,
              category: category,
              date: date,
              imageAssetPath: imageAssetPath,
              minExtent: topPadding + 56,
              maxExtent: maxScreenSizeHeight / 2,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
