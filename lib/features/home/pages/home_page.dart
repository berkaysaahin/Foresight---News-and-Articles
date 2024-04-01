import "package:flutter/material.dart";
import "package:foresight_news_and_articles/features/home/pages/all_news_page.dart";
import "package:foresight_news_and_articles/features/home/widgets/home_heading.dart";
import "package:foresight_news_and_articles/features/home/widgets/home_slider.dart";
import "package:foresight_news_and_articles/features/home/widgets/home_top_buttons.dart";
import "package:foresight_news_and_articles/features/home/widgets/news_list.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const HomeTopButtons(),
            HomeHeading(
              title: 'Breaking News',
              trailing: TextButton(
                child: const Text('View All'),
                onPressed: () {},
              ),
            ),
            const HomeSlider(),
            HomeHeading(
              title: 'Recommendation',
              trailing: TextButton(
                child: const Text('View All'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllNewsPage(),
                    ),
                  );
                },
              ),
            ),
            const NewsList(),
          ],
        ),
      ),
    );
  }
}
