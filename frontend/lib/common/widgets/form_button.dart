import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FormButton extends StatelessWidget {
  final bool disabled;
  final String payload;

  const FormButton({super.key, required this.disabled, required this.payload});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.3,
      child: AnimatedContainer(
        padding: EdgeInsets.all(10),
        duration: 500.ms,
        decoration: BoxDecoration(
          color: Colors.tealAccent[700]?.withValues(alpha: 0.5),
          // color: Color(0xFF209BC4),
          borderRadius: BorderRadius.circular(4),
        ),
        child: AnimatedDefaultTextStyle(
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          duration: 500.ms,
          child: Text(payload, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
