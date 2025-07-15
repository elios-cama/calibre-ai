import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class TCMBackground extends StatelessWidget {
  const TCMBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.warmCream,
            AppColors.softBeige,
            AppColors.lightGold.withAlpha(30),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
      ),
      child: CustomPaint(size: Size.infinite, painter: TCMPatternPainter()),
    );
  }
}

class TCMPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryGold.withAlpha(5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw subtle traditional pattern
    const spacing = 100.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        _drawTraditionalSymbol(canvas, paint, Offset(x, y));
      }
    }
  }

  void _drawTraditionalSymbol(Canvas canvas, Paint paint, Offset center) {
    // Draw a subtle cloud-like pattern inspired by traditional Chinese art
    final path = Path();
    const radius = 20.0;

    // Create a flowing, organic shape
    path.moveTo(center.dx - radius, center.dy);
    path.quadraticBezierTo(
      center.dx - radius,
      center.dy - radius * 0.5,
      center.dx,
      center.dy - radius * 0.5,
    );
    path.quadraticBezierTo(
      center.dx + radius,
      center.dy - radius * 0.5,
      center.dx + radius,
      center.dy,
    );
    path.quadraticBezierTo(
      center.dx + radius,
      center.dy + radius * 0.5,
      center.dx,
      center.dy + radius * 0.5,
    );
    path.quadraticBezierTo(
      center.dx - radius,
      center.dy + radius * 0.5,
      center.dx - radius,
      center.dy,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
