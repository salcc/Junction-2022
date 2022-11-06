import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/theme.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/social_screen.dart';
import 'screens/status_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: customTheme(),
        initialRoute: '/profile',
        getPages: [
          GetPage(name: '/status', page: () => const StatusScreen()),
          GetPage(name: '/profile', page: () => const ProfileScreen()),
          GetPage(name: '/social', page: () => const SocialScreen()),
          GetPage(name: '/chat', page: () => const ChatScreen()),
        ]);
  }
}
