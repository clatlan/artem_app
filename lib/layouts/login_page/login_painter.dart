import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassLoginContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: ShapesPainter(),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  static const double kHueR = 0.213;
  static const double kHueG = 0.715;
  static const double kHueB = 0.072;

  static List<double> matrixWithSat(double sat) {
    double r = kHueR * (1 - sat);
    double g = kHueG * (1 - sat);
    double b = kHueB * (1 - sat);

    return <double>[
      r + sat, g, b, 0, 0, //
      r, g + sat, b, 0, 0, //
      r, g, b + sat, 0, 0, //
      0, 0, 0, 1, 0, //
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.transparent;

    paint.color = Colors.grey.shade400.withOpacity(1);
    // create a path
    var path = Path();

    path.moveTo(size.width / 2 + 170, size.height / 2 - 220);
    path.lineTo(size.width / 2 + 170, size.height / 2 + 170);
    path.lineTo(size.width / 2 - 170, size.height / 2 + 170);
    path.lineTo(size.width / 2 - 170, size.height / 2 - 110);

    path.close();
    canvas.saveLayer(null, Paint()..blendMode=BlendMode.screen);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

