// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

/// Plant PageView in [DetailsPage]
/// 
class DetailPlantImagePage extends StatefulWidget {
  const DetailPlantImagePage({
    required this.pageId,
    required this.uiImage,
    required this.pageController,
    super.key,
  });

  final int pageId;
  final Widget uiImage;
  final PageController pageController;

  @override
  State<DetailPlantImagePage> createState() => _DetailPlantImagePageState();
}

class _DetailPlantImagePageState extends State<DetailPlantImagePage> {
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
        Transform.scale(
          scale: 0.5 + scale/2,
          child: Opacity(
            opacity: scale,
            child: widget.uiImage,
          ),
        ),
      ],
    );
  }
}
