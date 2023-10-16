// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:heyflutter/model/plant_model.dart';
import 'package:heyflutter/ui/page_indicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsContent extends ConsumerStatefulWidget {
  const DetailsContent({
    required this.height,
    required this.plant,
    super.key,
  });

  final double height;
  final PlantModel plant;

  @override
  ConsumerState<DetailsContent> createState() => _DetailsContentState();
}

class _DetailsContentState extends ConsumerState<DetailsContent> {
  late PageController pageController;

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
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Plant image
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: widget.height * 0.6,
                  child: PageView(
                    controller: pageController,
                    allowImplicitScrolling: true,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {},
                    children: pages(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
        
              /// Plant description
              Padding(
                padding: const EdgeInsets.only(left: 48, right: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.plant.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.plant.descr,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        
          /// images page indicator
          Positioned(
            right: 50,
            top: widget.height * 0.6 - 80,
            child: PageIndicator(
              pageController: pageController,
              axis: Axis.vertical,
            ),
          ),
        
        ],
      ),
    );
  }

  List<Widget> pages() {
    return List.generate(
      widget.plant.imageName.length,
      (index) => Image.asset(widget.plant.imageName[index]),
    );
  }
}
