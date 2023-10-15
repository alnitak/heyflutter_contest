// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:heyflutter/model/dummy.dart';
import 'package:heyflutter/model/plant_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

final dummyListProvider = StateProvider<List<PlantModel>>((ref) => dummyList);

final searchTextProvider = StateProvider<String>((ref) => '');

@riverpod
List<PlantModel> searchPlants(SearchPlantsRef ref) {
  final text = ref.watch(searchTextProvider);
  final plantList = ref.read(dummyListProvider);
  return plantList
      .where(
        (element) => element.name.contains(text),
      )
      .toList();
}
