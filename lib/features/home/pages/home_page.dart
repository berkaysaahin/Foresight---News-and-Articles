import "package:flutter/material.dart";
import "package:foresight_news_and_articles/features/home/widgets/home_heading.dart";
import "package:foresight_news_and_articles/features/home/widgets/home_slider.dart";
import "package:foresight_news_and_articles/features/home/widgets/home_top_buttons.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeTopButtons(),
            HomeHeading(
              title: 'Breaking News',
              trailing: TextButton(
                child: Text('View All'),
                onPressed: () {},
              ),
            ),
            HomeSlider(),
            Center(
              child: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
