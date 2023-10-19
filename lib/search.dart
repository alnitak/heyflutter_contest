import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:heyflutter/domain/provider.dart';
import 'package:heyflutter/ui/scaffold_builder.dart';
import 'package:heyflutter/ui/search/plant_card.dart';
import 'package:heyflutter/ui/search/search_appbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantList = ref.watch(searchPlantsProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 160),
        child: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              Image.asset('assets/avatar.png', width: kToolbarHeight),
              const SizedBox(width: 32),
            ],
            // toolbarHeight: kToolbarHeight * 2.2,
            bottom: const SearchAppBar(),
            title: const Text(
              'Search Products',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: ScaffoldBuilder(
        child: MasonryGridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(32),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: plantList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return resultsCount(plantList.length);
            return PlantCard(plantIndex: index - 1);
          },
        ),
      ),
    );
  }
}

Widget resultsCount(int count) {
  return Center(
    child: Text(
      count == 0
          ? 'Nothing\nFound'
          : (count == 1 ? 'Found\n$count Result' : 'Found\n$count Results'),
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    ),
  );
}
