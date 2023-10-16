// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:heyflutter/domain/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Search bar for the [SearchPage] AppBar
class SearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.read(searchTextProvider);
    final controller = TextEditingController(text: text);
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
              child: MaterialButton(
                minWidth: 60,
                height: 60,
                child: const Icon(Icons.tune, size: 36),
                onPressed: () {
                  // TODO settings?
                },
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
