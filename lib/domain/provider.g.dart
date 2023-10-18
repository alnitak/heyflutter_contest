// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchPlantsHash() => r'2dd623b7e19a8c43608ed6f7bf2623b69dfa9da3';

/// provider that stores the search results by name
///
/// Copied from [searchPlants].
@ProviderFor(searchPlants)
final searchPlantsProvider = AutoDisposeProvider<List<PlantModel>>.internal(
  searchPlants,
  name: r'searchPlantsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchPlantsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchPlantsRef = AutoDisposeProviderRef<List<PlantModel>>;
String _$cartTotalPriceHash() => r'0c0c161114dc30e962b84d9bd635680664424e41';

/// provider that stores cart total price
///
/// Copied from [cartTotalPrice].
@ProviderFor(cartTotalPrice)
final cartTotalPriceProvider = Provider<double>.internal(
  cartTotalPrice,
  name: r'cartTotalPriceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartTotalPriceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartTotalPriceRef = ProviderRef<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
