import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/theme.dart';
import 'screens/chat_screen.dart';
import 'screens/home_screen.dart';

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
        home: const HomeScreen(),
        getPages: [
          GetPage(name: '/', page: () => const HomeScreen()),
          GetPage(name: '/chat', page: () => const ChatScreen()),
        ]);
  }
}
