import 'package:flutter/material.dart';

class BackgroundCurve extends StatelessWidget {
  const BackgroundCurve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white70,
      child: CustomPaint(
        painter: _CurvePainter(),
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    //Properties
    paint.color = Color(0xffF0EEEF);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    //Draw
    final path = Path();

    path.lineTo(size.width * 0.40, 0);

    path.quadraticBezierTo(
        size.width, size.height * 0.30, size.width * 0.30, size.height);

    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
