import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:heyflutter/domain/provider.dart';

class SearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 4),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 18,
            child: TextField(
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'search',
                prefixIcon: const Icon(Icons.search),
                iconColor: Colors.black,
                filled: true,
                fillColor: const Color.fromARGB(255, 249, 249, 249),
                contentPadding: const EdgeInsets.symmetric(vertical: 25),
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
          const Flexible(
            child: SizedBox(width: 12),
          ),
          Flexible(
            flex: 3,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: const Color.fromARGB(255, 249, 249, 249),
              clipBehavior: Clip.antiAlias,
              child: IntrinsicHeight(
                child: MaterialButton(
                  height: 75,
                  child: const Icon(Icons.tune, size: 36),
                  onPressed: () {
                    // TODO settings?
                  },
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
