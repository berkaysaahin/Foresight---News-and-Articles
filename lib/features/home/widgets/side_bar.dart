import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/home/pages/all_news_page.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Expanded(
        child: ListView(
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
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Politics"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Science"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Technology"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Health"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Education"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Travel"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Art"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Sports"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Books"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Movies"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Fashion"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Dining"),
                  onTap: () {},
                ),
              ],
            ),
            const Spacer(),
            ListTile(
              title: const Text("Sign Out"),
              onTap: () async {
                await _signOut();
                if (user == null) {
                  // Optionally show a dialog or snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You have been signed out.'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
