import "package:flutter/cupertino.dart";
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
                    height: 200,
                    decoration: const BoxDecoration(
                      color: AppColors.porcelain,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                authorImageAssetPath,
                              ),
                              radius: 55,
                            ),
                            const Positioned(
                              bottom: 1.0, // Adjust for desired position
                              right: 1.0, // Adjust for desired position
                              child: CircleAvatar(
                                backgroundColor: AppColors.azureRadiance,
                                radius: 16,
                                child: Icon(
                                  CupertinoIcons
                                      .photo_camera, // Replace with your desired icon
                                  color: Colors.white, // Adjust color as needed
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 15,
                    child: AppRoundedButton(
                      iconData: Icons.menu,
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ),
                  Positioned(
                    left: 92,
                    top: 28,
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
              child: Container(
                color: AppColors.porcelain,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const ListTile(
                          title: Text(
                            "Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Berkay Şahin",
                          ),
                          trailing: Icon(Icons.edit, color: AppColors.osloGray),
                        ),
                        const Divider(
                          height: 40,
                          color: AppColors.porcelain,
                          thickness: 3,
                        ),
                        const ListTile(
                          title: Text(
                            "Email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "berkaysaahin@gmail.com",
                          ),
                          trailing: Icon(Icons.edit, color: AppColors.osloGray),
                        ),
                        const Divider(
                          height: 40,
                          color: AppColors.porcelain,
                          thickness: 3,
                        ),
                        const ListTile(
                          title: Text(
                            "Password",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "************",
                          ),
                          trailing: Icon(Icons.edit, color: AppColors.osloGray),
                        ),
                        const Divider(
                          height: 40,
                          color: AppColors.porcelain,
                          thickness: 3,
                        ),
                        const ListTile(
                          title: Text(
                            "Country/Region",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Turkey",
                          ),
                          trailing: Icon(Icons.edit, color: AppColors.osloGray),
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
                              buttonText: "Sign Out",
                              buttonColor: AppColors.athenasGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
