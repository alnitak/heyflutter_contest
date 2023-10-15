// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:heyflutter/details.dart';
import 'package:heyflutter/domain/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yoda/yoda.dart';

/// Plant card for the [SearchPage]
/// 
class PlantCard extends ConsumerStatefulWidget {
  const PlantCard({
    required this.plantIndex,
    super.key,
  });

  final int plantIndex;

  @override
  ConsumerState<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends ConsumerState<PlantCard> {
  @override
  Widget build(BuildContext context) {
    final plant = ref.read(dummyListProvider).elementAt(widget.plantIndex);
    ref.watch(
      dummyListProvider.select((value) => value[widget.plantIndex].favourite),
    );

    final yodaController = YodaController()
      ..addStatusListener((status, context) {
        if (status == AnimationStatus.forward) {}
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          ref.read(dummyListProvider.notifier).update((state) {
            final pl = [...ref.read(dummyListProvider)];
            pl[widget.plantIndex] = plant.copyWith(favourite: !plant.favourite);
            return pl;
          });
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
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(plant.imageName),
              const SizedBox(height: 12),
              Text(
                plant.name,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(
                plant.shortDescr,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${plant.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  yodaFx(yodaController, plant.favourite),
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
        iconSize: 40,
        icon: isFavourite
            ? Image.asset('assets/like_selected.png')
            : Image.asset('assets/like.png'),
      ),
    );
  }
}
