import "package:flutter/material.dart";
import "package:foresight_news_and_articles/core/app_rounded_button.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/dummy.dart";
import "package:foresight_news_and_articles/features/profile/pages/signin_page.dart";
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
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      color: AppColors.porcelain,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          backgroundColor: AppColors.athenasGray,
                          radius: 60,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              authorImageAssetPath,
                            ),
                            radius: 55,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 15,
                    child: AppRoundedButton(
                      iconData: Icons.more_horiz,
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      "Profile",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text.rich(
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
                  ),
                  const Divider(
                    height: 40,
                    color: AppColors.black,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: RectangleRoundedButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ),
                            );
                          },
                          buttonText: "Sign Out"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
