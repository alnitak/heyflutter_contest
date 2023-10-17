import 'package:flutter/material.dart';
import 'package:heyflutter/model/dummy.dart';
import 'package:heyflutter/search.dart';
import 'package:heyflutter/ui/onboarding_arrows.dart';
import 'package:heyflutter/ui/onboarding_page.dart';
import 'package:heyflutter/ui/page_indicator.dart';
import 'package:heyflutter/ui/scaffold_builder.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pageController;

  final assets = [
    dummyList[0].imageName.first,
    dummyList[4].imageName.first,
    dummyList[7].imageName.first,
    dummyList[6].imageName.first,
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        actions: [
          /// Skip button
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: TextButton(
              child: const Text(
                'skip',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ScaffoldBuilder(
        child: PageView(
          controller: pageController,
          allowImplicitScrolling: true,
          onPageChanged: (value) {},
          children: pages(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Arrows(
              pageController: pageController,
              onBackPressed: () {
                pageController.animateToPage(
                  pageController.page!.floor() - 1,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.decelerate,
                );
              },
              onNextPressed: () {
                if (pageController.page!.floor() >= assets.length-1) {
                  /// next button pressed in the last page
                  Navigator.popUntil(context, (predicate) => predicate.isFirst);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                } else {
                  pageController.animateToPage(
                    pageController.page!.floor() + 1,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.decelerate,
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            PageIndicator(pageController: pageController),
          ],
        ),
      ),
    );
  }

  List<Widget> pages() {
    return List.generate(
      assets.length,
      (index) => OnBoardingPage(
        pageId: index,
        uiImage: Image.asset(assets[index]),
        pageController: pageController,
      ),
    );
  }
}
