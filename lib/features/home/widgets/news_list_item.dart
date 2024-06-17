import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/features/browse/pages/single_news_item_page.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class NewsListItem extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String category;
  final String authorImageAssetPath;
  final String imageAssetPath;
  final String date;
  const NewsListItem(
      {super.key,
      required this.title,
      required this.author,
      required this.category,
      required this.authorImageAssetPath,
      required this.imageAssetPath,
      required this.date,
      required this.content});

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
                date: date),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imageAssetPath, // Replace with your image URL field
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 20.0, // Adjust width for desired size
                    height: 20.0, // Adjust height for desired size
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.osloGray,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          authorImageAssetPath, // Replace with your image URL field
                        ),
                        radius: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          '$author · $date',
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
      ),
    );
  }
}
