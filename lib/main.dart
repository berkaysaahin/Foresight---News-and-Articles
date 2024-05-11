import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/app.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures that Flutter bindings are initialized before calling Firebase.initializeApp()

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
