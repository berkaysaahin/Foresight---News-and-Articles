import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class RectangleRoundedButton extends StatelessWidget {
  final Function() onTap;
  String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  IconData? buttonIcon;
  RectangleRoundedButton(
      {super.key,
      required this.onTap,
      this.buttonText,
      this.buttonColor,
      this.textColor,
      this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: SizedBox(
          width: 100,
          height: 40,
          child: Center(
            child: buttonIcon != null
                ? Icon(
                    buttonIcon,
                    color: AppColors.white,
                    size: 22,
                  )
                : Text(
                    buttonText!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: textColor,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
