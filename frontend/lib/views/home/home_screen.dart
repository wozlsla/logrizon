import 'package:flutter/material.dart';
import 'package:frontend/common/utils/utils.dart';
import 'package:frontend/views/note/note_list_screen.dart';
import 'package:frontend/views/note/note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(title: Text("logrizon")),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NoteScreen()),
                );
              },
              icon: Icon(
                Icons.scatter_plot_outlined,
                color: isDark ? null : Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NoteListScreen()),
                );
              },
              icon: Icon(Icons.list, color: isDark ? null : Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
