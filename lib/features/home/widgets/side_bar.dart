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
              "Berkay Şahin",
              style: TextStyle(color: AppColors.black),
            ),
            accountEmail: const Text(
              "berkaaysaahin@gmail.com",
              style: TextStyle(color: AppColors.black08),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.athenasGray,
              child: ClipOval(
                child: Image.asset(
                  authorImageAssetPath,
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: AppColors.athenasGray,
              border: Border(
                  bottom: BorderSide(color: Colors.transparent, width: 0.0)),
            ),
          ),
          ListTile(
            title: Text(
              "All",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {},
            leading: const Icon(
              Icons.library_books,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: Text(
              "News",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {},
            leading: const Icon(
              Icons.newspaper,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: const Text("Articles"),
            onTap: () {},
            leading: const Icon(
              Icons.article,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: const Text("Technology"),
            onTap: () {},
            leading: const Icon(
              Icons.phone_android,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: const Text("Science"),
            onTap: () {},
            leading: const Icon(
              Icons.science,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: const Text("Sports"),
            onTap: () {},
            leading: const Icon(
              Icons.sports_volleyball,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: const Text("Favorites"),
            onTap: () {},
            leading: const Icon(
              Icons.favorite,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
