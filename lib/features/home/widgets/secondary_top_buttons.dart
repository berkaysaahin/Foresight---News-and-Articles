import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/app_rounded_button.dart';

class SecondaryTopButtons extends StatelessWidget {
  const SecondaryTopButtons({super.key});

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
            const Spacer(),
            AppRoundedButton(
              iconData: Icons.menu,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
