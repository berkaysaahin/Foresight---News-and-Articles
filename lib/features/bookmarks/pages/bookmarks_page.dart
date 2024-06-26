import "package:flutter/material.dart";
import "package:foresight_news_and_articles/core/app_rounded_button.dart";
import "package:foresight_news_and_articles/core/models/news_model.dart";
import "package:foresight_news_and_articles/core/services/news_service.dart";
import "package:foresight_news_and_articles/features/home/widgets/news_list.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";

class BookMarks extends StatefulWidget {
  BookMarks({super.key});

  @override
  State<BookMarks> createState() => _BookMarksState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _BookMarksState extends State<BookMarks> {
  final NewsService _newsService = NewsService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideBar(),
      body: SafeArea(
        child: StreamBuilder<List<News>>(
          stream: _newsService.bookmarkedItemsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error occurred'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No bookmarked items'));
            }

            // Filter out only the bookmarked news items
            final List<News> bookmarkedNews =
                snapshot.data!.where((news) => news.isBookmarked).toList();

            if (bookmarkedNews.isEmpty) {
              return const Center(child: Text('No bookmarked items'));
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        AppRoundedButton(
                          iconData: Icons.menu,
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Text(
                          "Bookmarks",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                NewsList(newsItems: bookmarkedNews),
              ],
            );
          },
        ),
      ),
    );
  }
}
