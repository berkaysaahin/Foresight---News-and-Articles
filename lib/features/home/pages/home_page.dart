import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/pages/all_news_page.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_heading.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_slider.dart';
import 'package:foresight_news_and_articles/features/home/widgets/home_top_buttons.dart';
import 'package:foresight_news_and_articles/features/home/widgets/news_list.dart';
import 'package:foresight_news_and_articles/features/home/widgets/side_bar.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

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
              final newsItems = snapshot.data!.docs.map((doc) {
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

              return CustomScrollView(
                slivers: [
                  const HomeTopButtons(),
                  HomeHeading(
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
                              newsItems: newsItems,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  HomeSlider(newsItems: newsItems),
                  HomeHeading(
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
                              newsItems: newsItems,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  NewsList(newsItems: newsItems),
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
