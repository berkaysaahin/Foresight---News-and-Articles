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
            title: const Text("All"),
            onTap: () {},
            leading: const Icon(Icons.library_books_outlined),
          ),
          ListTile(
            title: const Text("News"),
            onTap: () {},
            leading: const Icon(Icons.newspaper_outlined),
          ),
          ListTile(
            title: const Text("Articles"),
            onTap: () {},
            leading: const Icon(Icons.article_outlined),
          ),
          ListTile(
            title: const Text("Technology"),
            onTap: () {},
            leading: const Icon(Icons.phone_android_outlined),
          ),
          ListTile(
            title: const Text("Science"),
            onTap: () {},
            leading: const Icon(Icons.science_outlined),
          ),
          ListTile(
            title: const Text("Sports"),
            onTap: () {},
            leading: const Icon(Icons.sports_outlined),
          ),
          ListTile(
            title: const Text("Favorites"),
            onTap: () {},
            leading: const Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
