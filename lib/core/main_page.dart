import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/bookmarks/pages/bookmarks_page.dart';
import 'package:foresight_news_and_articles/features/browse/pages/browse_page.dart';
import 'package:foresight_news_and_articles/features/home/pages/home_page.dart';
import 'package:foresight_news_and_articles/features/profile/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          HomePage(),
          BrowsePage(),
          BookMarks(),
          ProfilePage(),
        ],
      ),
    );
  }
}
