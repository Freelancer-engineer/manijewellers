import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  final Function(int) onItemSelected;

  const SidebarMenu({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFFFF8E1),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF8B4513)),
              child: Center(
                child: Text("Admin Panel",
                    style: TextStyle(fontSize: 22, color: Colors.white)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.brown),
              title: const Text("Update Rates"),
              onTap: () => onItemSelected(0),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.brown),
              title: const Text("Today's Rates"),
              onTap: () => onItemSelected(1),
            ),
            ListTile(
              leading: const Icon(Icons.video_library, color: Colors.brown),
              title: const Text("Upload Video"),
              onTap: () => onItemSelected(2),
            ),
          ],
        ),
      ),
    );
  }
}

