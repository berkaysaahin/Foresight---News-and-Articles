import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/pages/all_news_page.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_heading.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_slider.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_top_buttons.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list.dart';
import 'package:foresight_news_and_articles/features/home/widgets/side_bar.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _newsItems = [];
  String _searchText = '';
  void updateSearchResults(String query) {
    // Update UI in HomePage based on the search query
    setState(() {
      // Update specific state variables here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('news').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error occurred'));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              _newsItems = snapshot.data!.docs.map((doc) {
                return {
                  'imageAssetPath': doc['imageAsset'],
                  'category': doc['category'],
                  'title': doc['title'],
                  'content': doc['content'],
                  'author': doc['author'],
                  'authorImageAssetPath': doc['authorImage'],
                  'date': doc['date'],
                };
              }).toList();
              List<Map<String, dynamic>> filteredNewsItems = _searchText.isEmpty
                  ? _newsItems
                  : _newsItems.where((newsItem) {
                      // Filter based on search query
                      return newsItem['title']
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
