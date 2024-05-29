import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:foresight_news_and_articles/core/app_rounded_button.dart";
import "package:foresight_news_and_articles/core/rectangle_rounded_button.dart";
import "package:foresight_news_and_articles/dummy.dart";
import "package:foresight_news_and_articles/features/home/widgets/side_bar.dart";
import "package:foresight_news_and_articles/theme/app_colors.dart";

class NewArticlePage extends StatelessWidget {
  NewArticlePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String authorImageAssetPath = newsrItems[4]['authorImageAssetPath']!;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    AppRoundedButton(
                      iconData: Icons.menu,
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    Text(
                      "Post Your Article",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        color: AppColors.azureRadiance,
                        child: Image.asset(
                          authorImageAssetPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        "Dave Doe",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Spacer(),
                    RectangleRoundedButton(
                      onTap: () {},
                      buttonText: "Submit",
                      buttonColor: AppColors.athenasGray,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  color: AppColors.white,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.porcelain,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    height: 100,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.image,
                            size: 36,
                            color: AppColors.osloGray,
                          ), // You can change the icon and size as needed
                          const SizedBox(
                              width:
                                  8), // Adds space between the icon and the text
                          Text(
                            "Add Cover Photo",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.osloGray,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
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
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          maxLines: 1,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText:
                                'Enter a compelling title for your article.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.zero, // No top border radius
                                bottom: Radius.zero, // No bottom border radius
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.porcelain,
                          thickness: 3,
                        ),
                        TextField(
                          minLines: 8,
                          maxLines: null,
                          decoration: InputDecoration(
                              focusColor: AppColors.osloGray,
                              hoverColor: AppColors.azureRadiance,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.zero, // No top border radius
                                  bottom:
                                      Radius.zero, // No bottom border radius
                                ),
                              ),
                              hintText:
                                  'Write your article, include sections and paragraphs.',
                              contentPadding: EdgeInsets.only(
                                  top: 20.0, left: 10.0, right: 10.0),
                              alignLabelWithHint: true),
                        ),
                        TextField(
                          maxLines: 1,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Select a category for your article.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.zero, // No top border radius
                                bottom: Radius.zero, // No bottom border radius
                              ),
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
