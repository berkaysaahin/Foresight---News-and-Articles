import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/browse/pages/single_news_item_page.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class HomeSliderItem extends StatelessWidget {
  final bool isActive;
  final String imageAssetPath;
  final String category;
  final String title;
  final String content;
  final String author;
  final String date;
  final String authorImageAssetPath;
  final bool isBookmarked;
  const HomeSliderItem(
      {super.key,
      required this.isActive,
      required this.imageAssetPath,
      required this.category,
      required this.title,
      required this.author,
      required this.date,
      required this.content,
      required this.authorImageAssetPath,
      required this.isBookmarked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleNewsItemPage(
              title: title,
              content: content,
              author: author,
              category: category,
              authorImageAssetPath: authorImageAssetPath,
              imageAssetPath: imageAssetPath,
              date: date,
              isBookmarked: isBookmarked,
            ),
          ),
        );
      },
      child: FractionallySizedBox(
        widthFactor: 1.08,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 400),
          scale: isActive ? 1 : 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image.network(
                  imageAssetPath,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: double.maxFinite,
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Chip(
                    label: Text(
                      category,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Customize border radius
                      side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1), // Add border
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black08,
                        AppColors.black06,
                        AppColors.black00
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$author · $date',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                ),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.white,
                            ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
