import "package:flutter/material.dart";
import "package:foresight_news_and_articles/core/app_rounded_button.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/dummy.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";
import "package:foresight_news_and_articles/features/profile/pages/signin_page.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";

class ProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String authorImageAssetPath = newsrItems[2]['authorImageAssetPath']!;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideBar(),
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
                      iconData: Icons.menu,
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
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
                  ListTile(
                    title: Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Ongaku Koujou",
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  ListTile(
                    title: Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "OngakuKoujou@gmail.com",
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  ListTile(
                    title: Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "************",
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  ListTile(
                    title: Text(
                      "Country/Region",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Turkey",
                    ),
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
