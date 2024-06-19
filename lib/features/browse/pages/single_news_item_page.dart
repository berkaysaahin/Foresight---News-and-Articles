import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/widgets/single_news_item_header_delegate.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class SingleNewsItemPage extends StatefulWidget {
  final String title;
  final String content;
  final String author;
  final String category;
  final String authorImageAssetPath;
  final String imageAssetPath;
  final String date;
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
  State<SingleNewsItemPage> createState() => _SingleNewsItemPageState();
}

class _SingleNewsItemPageState extends State<SingleNewsItemPage> {
  double _borderRadiusMultiplier = 1;
  bool isBookmarked = false;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

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
              borderRadiusAnimationValue: (value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _borderRadiusMultiplier = value;
                  });
                });
              },
              isBookmarked: isBookmarked,
              onBookmarkToggle: toggleBookmark,
              title: widget.title,
              category: widget.category,
              date: widget.date,
              imageAssetPath: widget.imageAssetPath,
              minExtent: topPadding + 56,
              maxExtent: maxScreenSizeHeight / 2,
              topPadding: topPadding,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: AnimatedContainer(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(40 * _borderRadiusMultiplier),
                color: AppColors.white,
              ),
              duration: const Duration(milliseconds: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.author,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(widget.content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
