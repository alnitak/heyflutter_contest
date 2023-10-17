// ignore_for_file: avoid_positional_boolean_parameters, comment_references

import 'package:flutter/material.dart';
import 'package:heyflutter/details.dart';
import 'package:heyflutter/domain/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoda/yoda.dart';

/// Plant card for the [SearchPage]
///
class PlantCard extends ConsumerWidget {
  const PlantCard({
    required this.plantIndex,
    super.key,
  });

  final int plantIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plant = ref.read(searchPlantsProvider).elementAt(plantIndex);
    final favourite = ValueNotifier(plant.favourite);
    
    final yodaController = YodaController()
      ..addStatusListener((status, context) {
        if (status == AnimationStatus.forward) {}
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          final dummyIndex = ref.read(dummyListProvider).indexWhere(
                (element) => element == plant,
              );

          /// update "remote db" (here only on [dummy.dart])
          if (dummyIndex != -1) {
            ref.read(dummyListProvider.notifier).update((state) {
              final pl = [...ref.read(dummyListProvider)];
              pl[dummyIndex] = plant.copyWith(favourite: !plant.favourite);
              return pl;
            });
          }

          // update current search list
          favourite.value = !favourite.value;
        }
      });

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => DetailsPage(plant: plant),
        ),
      ),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              Image.asset(plant.imageName.first),
              const SizedBox(height: 12),

              /// Plant name
              Text(
                plant.name,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),

              /// plant descr
              Text(
                plant.shortDescr,
              ),
              const SizedBox(height: 24),

              /// price & fav icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${plant.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: favourite,
                    builder: (_, isFavourite, __) {
                      return yodaFx(yodaController, isFavourite);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget yodaFx(
    YodaController yodaController,
    bool isFavourite,
  ) {
    return Yoda(
      yodaEffect: isFavourite ? YodaEffect.Flakes : YodaEffect.Explosion,
      controller: yodaController,
      duration: const Duration(milliseconds: 800),
      animParameters: AnimParameters(
        // yodaBarrier:
        //   YodaBarrier(bottom: true, left: true, right: true),
        fractionalCenter: const Offset(0.5, 1),
        hTiles: 15,
        vTiles: 15,
        effectPower: 0.82,
        blurPower: 2,
        gravity: 3,
        randomness: 10,
      ),
      startWhenTapped: true,
      child: IconButton(
        onPressed: null,
        iconSize: 36,
        icon: isFavourite
            ? Image.asset('assets/like_selected.png')
            : Image.asset('assets/like.png'),
      ),
    );
  }
}
