import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/dummy.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_slider_item.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  late final PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: 1000,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 235,
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              _pageIndex = value % newsrItems.length;
            });
          },
          controller: _pageController,
          itemBuilder: (context, index) {
            final i = index % newsrItems.length;
            return HomeSliderItem(
              isActive: _pageIndex == i,
              imageAssetPath: newsrItems[i]['imageAssetPath']!,
              category: newsrItems[i]['category']!,
              title: newsrItems[i]['title']!,
              author: newsrItems[i]['author']!,
              date: DateTime.parse(newsrItems[i]['date']!),
            );
          },
        ));
  }
}
