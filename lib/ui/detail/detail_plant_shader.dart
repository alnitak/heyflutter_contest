import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class PlantShader extends StatefulWidget {
  const PlantShader({
    required this.imgAsset,
    required this.pageController,
    required this.scale,
    super.key,
  });

  final String imgAsset;
  final PageController pageController;
  final double scale;

  @override
  State<PlantShader> createState() => _PlantShaderState();
}

class _PlantShaderState extends State<PlantShader>
    with TickerProviderStateMixin {
  late Ticker ticker;
  late Stopwatch sw;
  ui.FragmentProgram? program;
  ui.FragmentShader? shader;
  late double opacity;
  late ui.Image image;

  @override
  void initState() {
    super.initState();

    sw = Stopwatch()..start();
    opacity = 1;
    ticker = createTicker(tick)..start();
    loadShader();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    sw.stop();
    ticker.dispose();
    super.dispose();
  }

  void tick(Duration elapsed) {
    setState(() {
      final pageId = ((widget.pageController.page ?? 0.0) + 0.5).toInt();

      /// the [opacity] value will go through 0.5~1.0.
      /// 0.5 means the page is half swiped
      opacity = 1 -
          (pageId - (widget.pageController.page ?? 0))
              .toDouble()
              .abs()
              .clamp(0, 1);
    });
  }

  Future<void> loadShader() async {
    try {
      program =
          await ui.FragmentProgram.fromAsset('assets/shaders/ripple.frag');
      final imageData = await rootBundle.load(widget.imgAsset);
      image = await decodeImageFromList(imageData.buffer.asUint8List());
      shader = program?.fragmentShader();
    } on Exception catch (e) {
      debugPrint('PlantShader: cannot load shader! $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) return const SizedBox.shrink();

    /// [maxOpacity] = 1 means it will reach 0.5 at max
    const maxOpacity = 1;
    return Opacity(
      opacity: (opacity - 0.5) * maxOpacity,
      child: CustomPaint(
        size: Size(
          image.width.toDouble() * widget.scale,
          image.height.toDouble() * widget.scale,
        ),
        painter: RipplePainter(
          shader!,
          image,
          sw.elapsedMilliseconds / 1000.0,
        ),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  RipplePainter(this.shader, this.image, this.time);

  final ui.FragmentShader shader;
  final ui.Image image;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setImageSampler(0, image)
      ..setFloat(0, size.width) // iResolution
      ..setFloat(1, size.height) // iResolution
      ..setFloat(2, time) // iTime
      ..setFloat(3, size.width / 2) // iMouse
      ..setFloat(4, size.height / 2) // iMouse
      ..setFloat(5, 0) // iMouse
      ..setFloat(6, 0); // iMouse
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
