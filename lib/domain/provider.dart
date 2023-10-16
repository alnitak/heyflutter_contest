// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:heyflutter/model/dummy.dart';
import 'package:heyflutter/model/plant_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

/// Dummy plants list
final dummyListProvider = StateProvider<List<PlantModel>>((ref) => dummyList);

/// provider to store the cart
final cartProvider = StateProvider<List<PlantModel>>((ref) => []);

/// provider to trigger the search
final searchTextProvider = StateProvider<String>((ref) => '');

/// provider that stores the search results
@Riverpod(keepAlive: false)
List<PlantModel> searchPlants(SearchPlantsRef ref) {
  final text = ref.watch(searchTextProvider);
  final plantList = ref.read(dummyListProvider);
  final pl = plantList.where(
    (element) {
      return element.name.toLowerCase().contains(text.toLowerCase()) ||
          element.shortDescr.toLowerCase().contains(text.toLowerCase());
    },
  ).toList();
  return pl;
}

/// provider that stores cart total price
@Riverpod(keepAlive: true)
double cartTotalPrice(CartTotalPriceRef ref) {
  final plantList = ref.watch(cartProvider);
  var cartPrice = 0.0;
  for (final element in plantList) {
    cartPrice += element.price;
  }
  return cartPrice;
}
