import 'package:flutter/material.dart';
import 'package:frontend/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(title: Text("logrizon")),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.scatter_plot_outlined,
                color: isDark ? null : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
