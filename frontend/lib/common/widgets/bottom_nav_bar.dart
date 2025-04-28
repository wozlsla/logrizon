import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      // Icons.radar_outlined,
      Icons.switch_left,
      // Icons.view_in_ar_sharp,
      // Icons.eject,
      Icons.commit_rounded,
      Icons.share_location_rounded,
      // Icons.control_camera,
      // Icons.explore_outlined
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Color(0xFF209BC4).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.cyanAccent, width: 0.5),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.white10,
          //     blurRadius: 10,
          //     offset: Offset(0, 2),
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            icons.length,
            (index) => _NavIcon(
              icon: icons[index],
              selected: selectedIndex == index,
              onTap: () => onTap(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selected ? Colors.black87 : Colors.black45,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: Colors.white.withValues(alpha: selected ? 1.0 : 0.5),
        ),
      ),
    );
  }
}
