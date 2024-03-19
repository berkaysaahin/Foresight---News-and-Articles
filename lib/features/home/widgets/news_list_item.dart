import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/utils/app_date_formatters.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class NewsListItem extends StatelessWidget {
  final String title;
  final String author;
  final String category;
  final String authorImageAssetPath;
  final String imageAssetPath;
  final DateTime date;
  const NewsListItem(
      {super.key,
      required this.title,
      required this.author,
      required this.category,
      required this.authorImageAssetPath,
      required this.imageAssetPath,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imageAssetPath,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.osloGray,
                      ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        authorImageAssetPath,
                      ),
                      radius: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        '$author · ${AppDateFormatters.mdY(date)}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
