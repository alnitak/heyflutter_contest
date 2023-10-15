// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:heyflutter/domain/provider.dart';

import 'package:heyflutter/model/plant_model.dart';
import 'package:heyflutter/ui/details_bottom_navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Icons with descriptions for the [DetailsBottomNavigation]
class DetailsPage extends ConsumerWidget {
  const DetailsPage({
    required this.plant,
    super.key,
  });

  final PlantModel plant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartList = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: kToolbarHeight * 1.5,
        actions: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: IconButton(
              icon: Badge(
                isLabelVisible: cartList.isNotEmpty,
                label: Text(cartList.length.toString()),
                largeSize: 20,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              iconSize: 40,
              onPressed: () {},
            ),
          ),
        ],
      ),
      bottomNavigationBar: DetailsBottomNavigation(plant: plant),
    );
  }
}
