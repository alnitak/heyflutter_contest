// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heyflutter/domain/provider.dart';

import 'package:heyflutter/model/plant_model.dart';
import 'package:heyflutter/ui/details_bottom_navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:star_menu/star_menu.dart';

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
        toolbarHeight: kToolbarHeight * 2.2,
        actions: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: IconButton(
              icon: Badge(
                isLabelVisible: cartList.isNotEmpty,
                label: Text(cartList.length.toString()),
                largeSize: 20,
                child: DropDown(
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
              iconSize: 40,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Image.asset(plant.imageName),
      bottomNavigationBar: DetailsBottomNavigation(plant: plant),
    );
  }
}

/// drop-down StarMenu when pressing the cart
///
class DropDown extends ConsumerWidget {
  DropDown({
    required this.child,
    super.key,
  })  : cl = [],
        deleteItemCallback = null;

  final Widget child;

  final List<PlantModel>? cl;

  /// The [StarMenu.lazyItems] callback needs to use [WidgetRef] to delete
  /// items, but it can't be passed as argument. So inside the lazyItem callback
  /// use this function
  void Function(int index)? deleteItemCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = StarMenuController();
    cl?.addAll(ref.read(cartProvider));

    deleteItemCallback = (int index) {
      ref.read(cartProvider.notifier).update((state) {
        cl!.removeAt(index);
        final newCart = [...cl!];
        return newCart;
      });
      /// refresh items by closing and opening again StarMenu
      controller.closeMenu!();
      Future.delayed(const Duration(milliseconds: 300), () {
        controller.openMenu!();
      });
    };

    return StarMenu(
      controller: controller,
      params: StarMenuParameters(
        shape: MenuShape.linear,
        centerOffset: const Offset(-160, 30),
        boundaryBackground: BoundaryBackground(
          color: Colors.green.withOpacity(0.1),
          blurSigmaX: 6,
          blurSigmaY: 6,
        ),
        linearShapeParams: LinearShapeParams(
          angle: -90,
          space: Platform.isAndroid || Platform.isIOS ? -10 : 10,
          alignment: LinearAlignment.left,
        ),
      ),
      lazyItems: cartList,
      child: child,
    );
  }

  /// build the item list lazily
  Future<List<Widget>> cartList() async {
    var cartPrice = 0.0;
    final ret = List<Widget>.generate(cl!.length, (index) {
      cartPrice += cl![index].price;
      return SizedBox(
        width: 280,
        height: 60,
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
            2: IntrinsicColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              children: [
                /// Plant image
                Image.asset(
                  cl![index].imageName,
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Plant name
                      Text(
                        cl![index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),

                      /// Plant price
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '\$${cl![index].price}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    deleteItemCallback?.call(index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    })

      /// add cart total price
      ..add(
        SizedBox(
          width: 280,
          height: 60,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Tot: \$${cartPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );

    return ret;
  }
}
