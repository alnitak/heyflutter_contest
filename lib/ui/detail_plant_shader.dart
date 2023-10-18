import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class PlantShader extends StatefulWidget {
  const PlantShader({
    required this.img,
    required this.pageController,
    super.key,
  });

  final Image img;
  final PageController pageController;

  @override
  State<PlantShader> createState() => _PlantShaderState();
}

class _PlantShaderState extends State<PlantShader>
    with TickerProviderStateMixin {
  late Ticker ticker;
  late Stopwatch sw;
  late double opacity;

  @override
  void initState() {
    super.initState();

    sw = Stopwatch()..start();
    opacity = 1;
    ticker = createTicker(tick)..start();
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

  @override
  Widget build(BuildContext context) {
    /// [maxOpacity] = 1 means it will reach 0.5 at max
    const maxOpacity = 1;
    return Opacity(
      opacity: (opacity - 0.5) * maxOpacity,
      child: ShaderBuilder(
        (context, shader, child) {
          return AnimatedSampler(
            (image, size, canvas) {
              shader..setFloatUniforms((uniforms) {
                uniforms
                  ..setSize(size) // iResolution
                  ..setFloat(sw.elapsedMilliseconds / 1000.0) // iTime
                  ..setFloats(
                      [size.width / 2, size.height / 2, 0, 0],); // iMouse
              })

              ..setImageSampler(0, image);

              canvas.drawRect(
                Rect.fromLTWH(0, 0, size.width, size.height),
                Paint()..shader = shader,
              );
            },
            child: widget.img,
          );
        },
        assetKey: 'assets/shaders/ripple.frag',
      ),
    );
  }
}
