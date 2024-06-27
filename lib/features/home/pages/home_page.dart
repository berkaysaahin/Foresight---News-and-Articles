import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/models/news_model.dart';
import 'package:foresight_news_and_articles/core/services/news_service.dart';
import 'package:foresight_news_and_articles/features/home/pages/all_news_page.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_heading.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_slider.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_top_buttons.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list.dart';
import 'package:foresight_news_and_articles/features/home/widgets/side_bar.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> _newsItems = [];
  String _searchText = '';
  void updateSearchResults(String query) {
    // Update UI in HomePage based on the search query
    setState(() {
      _searchText = query;
      // Update specific state variables here
    });
  }

  void toggleBookmark(News newsItem) {
    setState(() {
      newsItem.isBookmarked = !newsItem.isBookmarked;
      // Optionally, update the Firestore document with the new bookmark status
      FirebaseFirestore.instance
          .collection('news')
          .doc(newsItem.title)
          .update(newsItem.toJson());
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      drawer: const SideBar(),
      body: SafeArea(
        child: StreamBuilder<List<News>>(
          stream: newsService.getNewsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return const Center(child: Text('Error occurred'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              _newsItems = snapshot.data!;
              List<News> filteredNewsItems = _searchText.isEmpty
                  ? _newsItems
                  : _newsItems.where((newsItem) {
                      return newsItem.title
                          .toLowerCase()
                          .contains(_searchText.toLowerCase());
                    }).toList();

              return CustomScrollView(
                slivers: [
                  HomeTopButtons(
                    onSearchSubmitted: updateSearchResults,
                    onSearchTextChanged: (String searchText) {
                      setState(() {
                        _searchText = searchText;
                      });
                    },
                  ),
                  _searchText.isEmpty
                      ? HomeHeading(
                          title: 'Breaking News',
                          trailing: TextButton(
                            child: const Text(
                              'View All',
                              style: TextStyle(color: AppColors.azureRadiance),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllNewsPage(
                                    newsItems: _newsItems,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : HomeHeading(
                          title: 'Filtered News',
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _searchText = ''; // Clear search text
                              });
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                  _searchText.isEmpty
                      ? HomeSlider(newsItems: _newsItems)
                      : const SliverToBoxAdapter(child: SizedBox()),
                  _searchText.isEmpty
                      ? HomeHeading(
                          title: 'Recommendation',
                          trailing: TextButton(
                            child: const Text(
                              'View All',
                              style: TextStyle(color: AppColors.azureRadiance),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllNewsPage(
                                    newsItems: _newsItems,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const SliverToBoxAdapter(
                          child: SizedBox(),
                        ),
                  NewsList(newsItems: filteredNewsItems),
                ],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
