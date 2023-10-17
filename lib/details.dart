// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:heyflutter/domain/provider.dart';
import 'package:heyflutter/model/plant_model.dart';
import 'package:heyflutter/ui/details_bottom_navigation.dart';
import 'package:heyflutter/ui/details_content.dart';
import 'package:heyflutter/ui/scaffold_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magnifying_glass/magnifying_glass.dart';
import 'package:star_menu/star_menu.dart';
import 'package:universal_io/io.dart';

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
    final height = MediaQuery.sizeOf(context).height;
    final magnifyingGlassController = MagnifyingGlassController();
    var glassIsOpen = false;

    /// to prevent the child of MagnifyingGlass to be rebuilt
    final scaffoldKey = GlobalKey();

    return MagnifyingGlass(
      controller: magnifyingGlassController,
      glassPosition: GlassPosition.touchPosition,
      borderThickness: 8,
      borderColor: Colors.grey,
      glassParams: GlassParams(
        startingPosition: const Offset(150, 150),
        diameter: 200,
        distortion: 0.1,
        magnification: 1.6,
        padding: const EdgeInsets.all(10),
      ),
      child: Listener(
        key: scaffoldKey,
        onPointerDown: (event) {
          if (glassIsOpen) {
            magnifyingGlassController.closeGlass();
            glassIsOpen = false;
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            toolbarHeight: kToolbarHeight * 1.5,
            actions: [
              IconButton(
                iconSize: 40,
                onPressed: () {
                  if (!glassIsOpen) {
                    magnifyingGlassController.openGlass();
                    glassIsOpen = true;
                  }
                },
                icon: const Icon(Icons.search),
              ),
              const SizedBox(width: 24),
              IconButton(
                icon: Badge(
                  isLabelVisible: cartList.isNotEmpty,
                  label: Text(cartList.length.toString()),
                  largeSize: 20,
                  child: DropDown(
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
                iconSize: 40,

                /// The onPressed is managed by [DropDown] which opens StarMenu
                onPressed: () {},
              ),
              const SizedBox(width: 24),
            ],
          ),
          body: ScaffoldBuilder(
            child: DetailsContent(
              /// the height is the Scaffold height minus bottomNavigationBar
              height: height * (1 - 0.28),
              plant: plant,
            ),
          ),
          bottomNavigationBar: DetailsBottomNavigation(
            height: height * 0.28,
            plant: plant,
          ),
        ),
      ),
    );
  }
}

/// drop-down the StarMenu when pressing the cart
///
// ignore: must_be_immutable
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

  late double cartPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = StarMenuController();
    cl?.addAll(ref.read(cartProvider));
    cartPrice = ref.read(cartTotalPriceProvider);

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
          space: Platform.isAndroid || Platform.isIOS ? 0 : 13,
          alignment: LinearAlignment.left,
        ),
      ),
      lazyItems: cartItemsList,
      child: child,
    );
  }

  /// build the item list lazily
  Future<List<Widget>> cartItemsList() async {
    final ret = List<Widget>.generate(cl!.length, (index) {
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
              decoration: const BoxDecoration(color: Colors.white24),
              children: [
                /// Plant image
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    cl![index].imageName.first,
                    height: 60,
                  ),
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
          height: 40,
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
