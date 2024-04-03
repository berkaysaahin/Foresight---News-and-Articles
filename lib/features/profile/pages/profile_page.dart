import "package:flutter/material.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/dummy.dart";
import "package:foresight_news_and_articles/features/home/widgets/secondary_top_buttons.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String authorImageAssetPath = newsrItems[2]['authorImageAssetPath']!;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SecondaryTopButtons(
              pageTitle: 'Profile',
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: AppColors.porcelain,
                radius: 60,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    authorImageAssetPath,
                  ),
                  radius: 55,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        // with no TextStyle it will have default text style
                        text: 'Signed in as ',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.black,
                            ),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Ongaku Koujou',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 50,
                      color: AppColors.black,
                      thickness: 1,
                      indent: 25,
                      endIndent: 25,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RectangleRoundedButton(
                            onTap: () {}, buttonText: "Sign in"),
                        const SizedBox(
                          width: 20,
                        ),
                        RectangleRoundedButton(
                            onTap: () {}, buttonText: "Sign up")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
