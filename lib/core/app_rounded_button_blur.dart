import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class AppRoundedButtonBlur extends StatelessWidget {
  final Function() onTap;
  final IconData iconData;
  const AppRoundedButtonBlur(
      {super.key, required this.onTap, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white02,
      borderRadius: BorderRadius.circular(56),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(56),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(56),
            onTap: onTap,
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                iconData,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
