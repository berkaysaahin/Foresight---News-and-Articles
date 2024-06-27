import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/app.dart';
import 'package:foresight_news_and_articles/core/services/news_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures that Flutter bindings are initialized before calling Firebase.initializeApp()

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<NewsService>(
          create: (_) => NewsService(),
        ),
      ],
      child: const App(),
    ),
  );
}
