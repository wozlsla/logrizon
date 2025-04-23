import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 48), // 상태바 영역 고려
        Expanded(
          child: Center(
            child: Text(
              "홈입니다",
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                // decoration: TextDecoration.underline,
                decorationColor: Colors.yellow,
                decorationThickness: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
