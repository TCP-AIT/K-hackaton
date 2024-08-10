import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final double kOuterRadius;
  final double kInnerRadius;
  final Color color;

  const CustomRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.kOuterRadius,
    required this.kInnerRadius,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged(value);
        }
      },
      child: CustomPaint(
        painter: _RadioPainter(
          isSelected: value == groupValue,
          kOuterRadius: kOuterRadius,
          kInnerRadius: kInnerRadius,
          color: color
        ),
        child: SizedBox(
          width: kOuterRadius * 2,
          height: kOuterRadius * 2,
        ),
      ),
    );
  }
}

class _RadioPainter extends CustomPainter {
  final bool isSelected;
  final double kOuterRadius;
  final double kInnerRadius;
  final Color color;

  _RadioPainter({
    required this.isSelected,
    required this.kOuterRadius,
    required this.kInnerRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    // Draw outer circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      kOuterRadius,
      paint,
    );

    if (isSelected) {
      paint..style = PaintingStyle.fill;
      // Draw inner circle
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        kInnerRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
