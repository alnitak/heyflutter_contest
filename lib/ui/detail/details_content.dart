// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:heyflutter/model/plant_model.dart';
import 'package:heyflutter/ui/detail/detail_plant_image_page.dart';
import 'package:heyflutter/ui/detail/detail_plant_shader.dart';
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
  late ValueNotifier<int> currPage;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    currPage = ValueNotifier(0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const scale = 0.55;
    final imagePageViewHeight = widget.height * scale;
    return Stack(
      children: [
        /// plant shader
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: imagePageViewHeight,
            child: Transform.flip(
              flipX: true,
              flipY: true,
              child: Transform.translate(
                offset: Offset(0, -imagePageViewHeight + 20),
                child: Transform.scale(
                  alignment: Alignment.bottomCenter,
                  scaleY: 0.4,
                  child: ValueListenableBuilder(
                    valueListenable: currPage,
                    builder: (_, pageId, __) {
                      return PlantShader(
                        key: UniqueKey(),
                        imgAsset: widget.plant.imageName[pageId],
                        pageController: pageController,
                        scale: 0.55,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        /// Plant PageView images
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: imagePageViewHeight,
            child: PageView(
              controller: pageController,
              allowImplicitScrolling: true,
              scrollDirection: Axis.vertical,
              onPageChanged: (value) => currPage.value = value,
              children: pages(),
            ),
          ),
        ),

        /// Plant description
        Align(
          alignment: Alignment.bottomCenter,
          child: ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha(180),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 48, right: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
          ),
        ),

        /// images page indicator
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: PageIndicator(
              pageController: pageController,
              axis: Axis.vertical,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> pages() {
    return List.generate(
      widget.plant.imageName.length,
      (index) => DetailPlantImagePage(
        pageController: pageController,
        pageId: index,
        uiImage: index == 0
            ? Hero(
                tag: widget.plant.imageName.first,
                child: Image.asset(widget.plant.imageName[index]),
              )
            : Image.asset(widget.plant.imageName[index]),
      ),
    );
  }
}
