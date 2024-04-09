import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/dummy.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    String authorImageAssetPath = newsrItems[2]['authorImageAssetPath']!;
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Kasane Teto",
              style: TextStyle(color: AppColors.black),
            ),
            accountEmail: const Text(
              "kasaneteto@vmail.com",
              style: TextStyle(color: AppColors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  authorImageAssetPath,
                  width: 85,
                  height: 85,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: AppColors.athenasGray,
              border:
                  Border(bottom: BorderSide(color: AppColors.azureRadiance)),
            ),
          ),
          ListTile(
            title: Text("All"),
            onTap: () {},
            leading: Icon(Icons.library_books_outlined),
          ),
          ListTile(
            title: Text("News"),
            onTap: () {},
            leading: Icon(Icons.newspaper_outlined),
          ),
          ListTile(
            title: Text("Articles"),
            onTap: () {},
            leading: Icon(Icons.article_outlined),
          ),
          ListTile(
            title: Text("Technology"),
            onTap: () {},
            leading: Icon(Icons.phone_android_outlined),
          ),
          ListTile(
            title: Text("Science"),
            onTap: () {},
            leading: Icon(Icons.science_outlined),
          ),
          ListTile(
            title: Text("Sports"),
            onTap: () {},
            leading: Icon(Icons.sports_outlined),
          ),
          ListTile(
            title: Text("Favorites"),
            onTap: () {},
            leading: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
