import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/instructors_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/bottom_nav.dart';

class TeachmateCoApp extends StatefulWidget {
  const TeachmateCoApp({super.key});

  @override
  State<TeachmateCoApp> createState() => _TeachMateCOAppState();
}

class _TeachMateCOAppState extends State<TeachmateCoApp> {
  String _activeTab = 'dashboard';

  Widget _renderScreen() {
    switch (_activeTab) {
      case 'tasks':
        return const TasksScreen();
      case 'courses':
        return const CoursesScreen();
      case 'dashboard':
        return const DashboardScreen();
      case 'instructors':
        return const InstructorsScreen();
      case 'profile':
        return const ProfileScreen();
      default:
        return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teach Mate CO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade900),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Teach Mate CO',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Academic Coordinator Portal',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: _renderScreen()),
          ],
        ),
        bottomNavigationBar: BottomNav(
          activeTab: _activeTab,
          onTabChange: (tab) {
            setState(() {
              _activeTab = tab;
            });
          },
        ),
      ),
    );
  }
}
