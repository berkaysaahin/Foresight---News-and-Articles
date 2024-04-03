import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class RectangleRoundedButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  const RectangleRoundedButton(
      {super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.porcelain,
      borderRadius: BorderRadius.circular(56),
      child: InkWell(
        borderRadius: BorderRadius.circular(56),
        onTap: onTap,
        child: SizedBox(
          width: 100,
          height: 40,
          child: Center(child: Text(buttonText)),
        ),
      ),
    );
  }
}
