import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/utils/app_date_formatters.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class HomeSliderItem extends StatelessWidget {
  final bool isActive;
  final String imageAssetPath;
  final String category;
  final String title;
  final String author;
  final DateTime date;
  const HomeSliderItem(
      {super.key,
      required this.isActive,
      required this.imageAssetPath,
      required this.category,
      required this.title,
      required this.author,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.08,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 400),
        scale: isActive ? 1 : 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                color: Colors.red,
              ),
              Image.asset(
                imageAssetPath,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: double.maxFinite,
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text(
                    category,
                    style: const TextStyle(color: AppColors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
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
                      '$author · ${AppDateFormatters.mdY(date)}',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: AppColors.white,
                          ),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: AppColors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
