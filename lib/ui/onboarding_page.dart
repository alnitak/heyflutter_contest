// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// onboarding PageView
/// 
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({
    required this.pageId,
    required this.uiImage,
    required this.pageController,
    super.key,
  });

  final int pageId;
  final Widget uiImage;
  final PageController pageController;

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late double scale;
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(pageListener);
    scale = 1;
  }

  @override
  void dispose() {
    widget.pageController.removeListener(pageListener);
    super.dispose();
  }

  void pageListener() {
    if (context.mounted) {
      setState(() {
        /// calculate the displayed percentage of the page with id [pageId]
        scale = 1 -
            (widget.pageId - (widget.pageController.page ?? 0))
                .toDouble()
                .abs()
                .clamp(0, 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.4,
              ),
              child: Opacity(
                opacity: scale,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 64,
                    right: 64,
                  ),
                  child: widget.uiImage,
                ),
              ),
            ),
            RichText(
              textScaleFactor: 3.5 * scale,
              text: TextSpan(
                text: 'Enjoy your\nLife with ',
                style: DefaultTextStyle.of(context).style.copyWith(
                  shadows: [
                    const Shadow(
                      blurRadius: 6,
                      offset: Offset(4, 4),
                      color: Colors.black54,
                    ),
                  ],
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: 'Plants',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
