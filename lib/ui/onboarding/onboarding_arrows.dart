// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Arrows extends StatefulWidget {
  const Arrows({
    required this.pageController,
    super.key,
    this.onBackPressed,
    this.onNextPressed,
  });

  final PageController pageController;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;

  @override
  State<Arrows> createState() => _ArrowsState();
}

class _ArrowsState extends State<Arrows> {
  late int pageCount;

  @override
  void initState() {
    super.initState();
    pageCount = 0;
    widget.pageController.addListener(pageListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// Get the number of pages
      pageCount = widget.pageController.position.extentTotal ~/
          widget.pageController.position.viewportDimension;
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.pageController.removeListener(pageListener);
    super.dispose();
  }

  void pageListener() {
    if (context.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pageCount == 0) return const SizedBox.shrink();
    final currentPage = (widget.pageController.page ?? 0).toInt();

    /// calculate the percentage of the current page
    final percentage = (widget.pageController.page ?? 0) -
        (widget.pageController.page ?? 0).floor();

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scaleX: currentPage == 0 ? percentage : 1,
            child: Opacity(
              opacity: currentPage == 0 ? percentage : 1,
              child: FloatingActionButton.large(
                heroTag: null,
                onPressed: widget.onBackPressed?.call,
                child: Transform.scale(
                  scale: 0.5,
                  child: Image.asset(
                    'assets/arrow_left.png',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
          FloatingActionButton.large(
            heroTag: null,
            onPressed: widget.onNextPressed?.call,
            child: Transform.scale(
              scale: 0.5,
              child: Image.asset(
                'assets/arrow_right.png',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
