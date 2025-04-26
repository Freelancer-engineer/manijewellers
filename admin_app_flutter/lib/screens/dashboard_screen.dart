import 'package:flutter/material.dart';
import '../widgets/sidebar_menu.dart';
import 'rate_entry_screen.dart';
import 'daily_rate_screen.dart';
import 'video_upload_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const RateEntryScreen(),
    const DailyRateScreen(),
    const VideoUploadScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarMenu(
        onItemSelected: (index) {
          setState(() => currentIndex = index);
          Navigator.pop(context);
        },
      ),
      appBar: AppBar(
        title: const Text("Mani Jewellers"),
        backgroundColor: const Color(0xFF8B4513),
      ),
      body: pages[currentIndex],
    );
  }
}
