import 'package:flutter/material.dart';
import 'package:heyflutter/model/dummy.dart';
import 'package:heyflutter/onboarding/onboarding_page.dart';
import 'package:heyflutter/search.dart';
import 'package:heyflutter/ui/arrows.dart';
import 'package:heyflutter/ui/page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pageController;

  final assets = [
    dummyList[0].imageName,
    dummyList[4].imageName,
    dummyList[7].imageName,
    dummyList[6].imageName,
    dummyList[5].imageName,
    dummyList[2].imageName,
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        actions: [
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
      body: PageView(
        controller: pageController,
        allowImplicitScrolling: true,
        onPageChanged: (value) {},
        children: pages(),
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
                if (pageController.page!.floor() == 5) {
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