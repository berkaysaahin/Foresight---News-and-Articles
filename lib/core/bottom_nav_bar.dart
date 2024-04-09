import "package:flutter/material.dart";
import "package:foresight_news_and_articles/core/bottom_nav_bar_item.dart";

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int value) onTap;
  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1,
            thickness: 1,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavBarItem(
                text: "Home",
                activeIconData: Icons.home,
                iconData: Icons.home_outlined,
                isActive: currentIndex == 0,
                onTap: () {
                  onTap(0);
                },
              ),
              BottomNavBarItem(
                text: "Articles",
                isActive: currentIndex == 1,
                onTap: () {
                  onTap(1);
                },
                activeIconData: Icons.article,
                iconData: Icons.article_outlined,
              ),
              BottomNavBarItem(
                text: "Bookmarks",
                isActive: currentIndex == 2,
                onTap: () {
                  onTap(2);
                },
                activeIconData: Icons.bookmark,
                iconData: Icons.bookmark_outline,
              ),
              BottomNavBarItem(
                text: "Profile",
                isActive: currentIndex == 3,
                onTap: () {
                  onTap(3);
                },
                activeIconData: Icons.person,
                iconData: Icons.person_outline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//4.47