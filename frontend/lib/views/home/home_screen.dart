import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 42,
                foregroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/62599036?s=48&v',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 40.0,
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: List.generate(8, (index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCCCCC).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('-'),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
