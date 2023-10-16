import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heyflutter/onboarding.dart';
import 'package:heyflutter/search.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      // darkTheme: ThemeData.light(useMaterial3: true),
      theme: ThemeData(
        // useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 120, 150, 75),
          secondary: const Color.fromARGB(255, 120, 150, 75),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 236, 236, 236),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        // enable mouse dragging
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      // home: const SearchPage(),
      home: OnBoarding(),
    );
  }
}
