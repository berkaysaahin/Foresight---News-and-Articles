import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/pages/all_news_page.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user != null ? user.displayName ?? "" : "",
              style: const TextStyle(color: AppColors.black),
            ),
            accountEmail: Text(
              user != null ? user.email ?? "" : "",
              style: const TextStyle(color: AppColors.black08),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.white,
              child: ClipOval(
                child: user != null && user.photoURL != null
                    ? Image.network(
                        user.photoURL!,
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.person,
                        size: 55,
                        color: AppColors.porcelain,
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllNewsPage(
                    newsItems: [],
                  ),
                ),
              );
            },
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
          ExpansionTile(
            collapsedShape: const RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            shape: const RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            title: Text(
              "Categories",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            children: [
              ListTile(
                title: const Text("Business"),
                onTap: () {},
                leading: const Icon(
                  Icons.business_center_sharp,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Politics"),
                onTap: () {},
                leading: const Icon(
                  Icons.science,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Science"),
                onTap: () {},
                leading: const Icon(
                  Icons.sports_volleyball,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Technology"),
                onTap: () {},
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Health"),
                onTap: () {},
                leading: const Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Education"),
                onTap: () {},
                leading: const Icon(
                  Icons.science,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Travel"),
                onTap: () {},
                leading: const Icon(
                  Icons.sports_volleyball,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Art"),
                onTap: () {},
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Sports"),
                onTap: () {},
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Books"),
                onTap: () {},
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Movies"),
                onTap: () {},
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Fashion"),
                onTap: () {},
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text("Dining"),
                onTap: () {},
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
