// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  const PageIndicator({
    required this.pageController,
    super.key,
    this.axis = Axis.horizontal,
  });

  final PageController pageController;
  final Axis? axis;

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  late double pageCount;

  @override
  void initState() {
    super.initState();
    pageCount = 0;
    widget.pageController.addListener(pageListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// Get the number of pages
      pageCount = widget.pageController.position.extentTotal /
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

    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Flex(
        direction: widget.axis!,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageCount.toInt(),
          (index) {
            /// calculate the displayed percentage of the page with id [index]
            var increment = index - (widget.pageController.page ?? 0);
            increment = 1 - increment.abs().clamp(0, 1);

            final width = 10.0 + increment * 20;
            final height = 10.0+ sin(increment * pi) * 5;
            return Container(
              width: widget.axis == Axis.horizontal ? width : height,
              height: widget.axis == Axis.horizontal ? height : width,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),
      ),
    );
  }
}
