import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/services/news_service.dart';
import 'package:foresight_news_and_articles/features/home/pages/all_news_page.dart';
import 'package:foresight_news_and_articles/features/home/pages/category_news_page.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      user = null;
    });
  }

  void _navigateToCategory(BuildContext context, String category) {
    final newsService = Provider.of<NewsService>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryNewsPage(
          category: category,
          newsService: newsService,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user != null ? user!.displayName ?? "" : "",
              style: const TextStyle(color: AppColors.black),
            ),
            accountEmail: Text(
              user != null ? user!.email ?? "" : "",
              style: const TextStyle(color: AppColors.black08),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.white,
              child: ClipOval(
                child: user != null && user!.photoURL != null
                    ? Image.network(
                        user!.photoURL!,
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
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
                  trailing: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16,
                    color: AppColors.osloGray,
                  ),
                ),
                ListTile(
                  title: Text(
                    "News",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {},
                  trailing: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16,
                    color: AppColors.osloGray,
                  ),
                ),
                ListTile(
                  title: const Text("Articles"),
                  onTap: () {},
                  trailing: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16,
                    color: AppColors.osloGray,
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
                      onTap: () => _navigateToCategory(context, "Business"),
                    ),
                    ListTile(
                      title: const Text("Politics"),
                      onTap: () => _navigateToCategory(context, "Politics"),
                    ),
                    ListTile(
                      title: const Text("Science"),
                      onTap: () => _navigateToCategory(context, "Science"),
                    ),
                    ListTile(
                      title: const Text("Technology"),
                      onTap: () => _navigateToCategory(context, "Technology"),
                    ),
                    ListTile(
                      title: const Text("Health"),
                      onTap: () => _navigateToCategory(context, "Health"),
                    ),
                    ListTile(
                      title: const Text("Education"),
                      onTap: () => _navigateToCategory(context, "Education"),
                    ),
                    ListTile(
                      title: const Text("Travel"),
                      onTap: () => _navigateToCategory(context, "Travel"),
                    ),
                    ListTile(
                      title: const Text("Art"),
                      onTap: () => _navigateToCategory(context, "Art"),
                    ),
                    ListTile(
                      title: const Text("Sports"),
                      onTap: () => _navigateToCategory(context, "Sports"),
                    ),
                    ListTile(
                      title: const Text("Books"),
                      onTap: () => _navigateToCategory(context, "Books"),
                    ),
                    ListTile(
                      title: const Text("Movies"),
                      onTap: () => _navigateToCategory(context, "Movies"),
                    ),
                    ListTile(
                      title: const Text("Fashion"),
                      onTap: () => _navigateToCategory(context, "Fashion"),
                    ),
                    ListTile(
                      title: const Text("Dining"),
                      onTap: () => _navigateToCategory(context, "Dining"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          user == null
              ? const SizedBox()
              : ListTile(
                  title: const Text("Sign Out"),
                  onTap: () async {
                    await _signOut();
                    if (user == null) {
                      // Optionally show a dialog or snackbar
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You have been signed out.'),
                          ),
                        );
                      }
                    }
                  },
                ),
        ],
      ),
    );
  }
}
