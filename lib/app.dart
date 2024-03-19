import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/main_page.dart';
import 'package:foresight_news_and_articles/theme/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foresight - News and Articles',
      theme: ThemeData(
        primarySwatch: AppColors.azureRadianceSwatch,
        primaryColor: AppColors.azureRadiance,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const MainPage(),
    );
  }
}
