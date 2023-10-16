// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:heyflutter/domain/provider.dart';
import 'package:heyflutter/model/plant_model.dart';
import 'package:heyflutter/ui/plant_feature.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Bottom sheet of the plant detail page
///
class DetailsBottomNavigation extends ConsumerWidget {
  const DetailsBottomNavigation({
    required this.height,
    required this.plant,
    super.key,
  });

  final double height;
  final PlantModel plant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// Plant features (height, temp, pot)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlantFeature(
                assetImage: 'assets/height.png',
                title: 'Height',
                subTitle: '${plant.height.min}cm - '
                    '${plant.height.max}cm',
              ),
              PlantFeature(
                assetImage: 'assets/temperature.png',
                title: 'Temperature',
                subTitle: '${plant.temp.min}°C - '
                    '${plant.temp.max}°C',
              ),
              PlantFeature(
                assetImage: 'assets/pot.png',
                title: 'Pot',
                subTitle: plant.pot,
              ),
            ],
          ),

          /// Price &  add to cart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${plant.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              /// Add to Cart
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Material(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.black45,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.black12,
                    onTap: () {
                      ref.read(cartProvider.notifier).update((state) {
                        final addedPlant = [
                          ...ref.read(cartProvider)..add(plant)
                        ];
                        return addedPlant;
                      });
                    },
                    child: Container(
                      width: 230,
                      height: 90,
                      margin: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
