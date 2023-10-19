import 'package:flutter/foundation.dart';
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
/// ```
class ScaffoldBuilder extends StatelessWidget {
  const ScaffoldBuilder({
    required this.child,
    super.key,
  });

  /// The body of the Scaffold we want to assign the aspect ratio
  final Widget child;

  @override
  Widget build(BuildContext context) {
    /// To check if the app is run on the mobile browser
    final isWebOnMobile = kIsWeb && (Platform.isAndroid || Platform.isAndroid);

    if (!(Platform.isAndroid || Platform.isAndroid) && !isWebOnMobile) {
      return Center(
        child: AspectRatio(
          aspectRatio: 7 / 10,
          child: child,
        ),
      );
    }
    return child;
  }
}
