import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _rotation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotation.value * 2 * 3.14159,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryGold, width: 2),
                  ),
                  child: CustomPaint(painter: YinYangPainter()),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          Text(
            AppStrings.loadingMessage,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.darkBrown.withAlpha(70),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class YinYangPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Draw yin (dark) half
    paint.color = AppColors.darkBrown;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      3.14159,
      true,
      paint,
    );

    // Draw yang (light) half
    paint.color = AppColors.lightGold;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159,
      3.14159,
      true,
      paint,
    );

    // Draw small circles
    paint.color = AppColors.lightGold;
    canvas.drawCircle(
      Offset(center.dx, center.dy - radius / 2),
      radius / 6,
      paint,
    );

    paint.color = AppColors.darkBrown;
    canvas.drawCircle(
      Offset(center.dx, center.dy + radius / 2),
      radius / 6,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
