import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/app_rounded_button.dart';

class SecondaryTopButtons extends StatelessWidget {
  final String pageTitle;
  const SecondaryTopButtons({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            AppRoundedButton(
              iconData: CupertinoIcons.left_chevron,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 17,
            ),
            Text(
              pageTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            AppRoundedButton(
              iconData: Icons.menu,
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }
}
