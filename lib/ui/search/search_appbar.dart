// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:heyflutter/domain/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:star_menu/star_menu.dart';

/// Search bar for the [SearchPage] AppBar
class SearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.read(searchTextProvider);
    final controller = TextEditingController(text: text);
    final smController = StarMenuController();
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 4),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 15,
            child: TextField(
              controller: controller,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'search',
                prefixIcon: const Icon(Icons.search),
                iconColor: Colors.black,
                filled: true,
                fillColor: const Color.fromARGB(255, 249, 249, 249),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => ref
                  .read(searchTextProvider.notifier)
                  .update((state) => value),
            ),
          ),
          const SizedBox(width: 12),
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color.fromARGB(255, 249, 249, 249),
            clipBehavior: Clip.antiAlias,
            child: IntrinsicHeight(
              child: StarMenu(
                controller: smController,
                params: StarMenuParameters(
                  shape: MenuShape.linear,
                  centerOffset: const Offset(-160, 30),
                  boundaryBackground: BoundaryBackground(
                    color: Colors.green.withOpacity(0.1),
                    blurSigmaX: 6,
                    blurSigmaY: 6,
                  ),
                  linearShapeParams: const LinearShapeParams(
                    angle: -90,
                    alignment: LinearAlignment.left,
                  ),
                ),
                items: const [PriceRange()],
                child: MaterialButton(
                  minWidth: 60,
                  height: 60,
                  child: const Icon(Icons.tune, size: 36),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(15, 200);
}

/// Price range slider for the button in the SearchBar
class PriceRange extends ConsumerWidget {
  const PriceRange({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceRange = ref.watch(priceRangeProvider);
    final width = MediaQuery.sizeOf(context).width;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width*0.7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                color: Colors.white60,
                child: Text(
                  '\$${priceRange.min.toInt()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Text(
                'Price Range',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                color: Colors.white60,
                child: Text(
                  '\$${priceRange.max.toInt()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          RangeSlider(
            values: RangeValues(priceRange.min, priceRange.max),
            max: 150,
            divisions: 30,
            onChanged: (range) {
              ref
                  .read(priceRangeProvider.notifier)
                  .update((state) => (min: range.start, max: range.end));
            },
          ),
        ],
      ),
    );
  }
}
