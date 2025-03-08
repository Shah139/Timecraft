import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final double percentage;
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;
  final TextStyle? textStyle;

  const CircularProgressIndicatorWidget({
    Key? key,
    required this.percentage,
    this.size = 70,
    this.backgroundColor = Colors.white30,
    this.progressColor = Colors.white,
    this.strokeWidth = 8,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Today's Progress",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CircularPercentIndicator(
          radius: 150.0,
          lineWidth: 40.0,
          percent: percentage.clamp(0.0, 1.0), // progress%
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(percentage*100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Task Completed Today",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              

            ],
          ),
          progressColor: Colors.purple,
          backgroundColor: Colors.grey[300]!,
          circularStrokeCap: CircularStrokeCap.round,
          arcType: ArcType.HALF, // Makes it a semi-circle
        ),
      ],
    );
  }
}

class LinearProgressIndicatorWidget extends StatelessWidget {
  final double percentage;
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final BorderRadius? borderRadius;

  const LinearProgressIndicatorWidget({
    Key? key,
    required this.percentage,
    this.height = 10,
    this.backgroundColor = Colors.white30,
    this.progressColor = Colors.white,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: percentage / 100,
        minHeight: height,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
      ),
    );
  }
}

class ProgressBadge extends StatelessWidget {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final double size;
  final Widget? child;

  const ProgressBadge({
    Key? key,
    required this.percentage,
    this.backgroundColor = Colors.purple,
    this.progressColor = Colors.white,
    this.size = 200,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: CircularProgressIndicatorWidget(
          percentage: percentage,
          size: size * 0.6,
          backgroundColor: backgroundColor.withOpacity(0.3),
          progressColor: progressColor,
          strokeWidth: size * 0.05,
          textStyle: TextStyle(
            color: progressColor,
            fontSize: size * 0.15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}