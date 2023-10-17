import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

/// Set an aspect ratio to a Scaffold body in the case
/// we run the app on desktop or web env
/// ```dart
/// Scaffold(
///   body: ScaffoldBuilder(
///     child: [our original scaffold body],
///   ),
/// )
class ScaffoldBuilder extends StatelessWidget {
  const ScaffoldBuilder({
    required this.child,
    super.key,
  });

  /// The body of the Scaffold we want to assign the aspect ratio
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!(Platform.isAndroid || Platform.isAndroid)) {
      return Center(
        child: AspectRatio(
          aspectRatio: 520 / 1000,
          child: child,
        ),
      );
    }
    return child;
  }
}
