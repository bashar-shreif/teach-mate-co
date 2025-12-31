import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final String activeTab;
  final Function(String) onTabChange;

  const BottomNav({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> tabs = [
    {'id': 'tasks', 'label': 'Tasks', 'icon': Icons.check_box_outlined},
    {'id': 'courses', 'label': 'Courses', 'icon': Icons.menu_book_outlined},
    {'id': 'dashboard', 'label': 'Dashboard', 'icon': Icons.dashboard_outlined},
    {'id': 'instructors', 'label': 'Instructors', 'icon': Icons.people_outline},
    {'id': 'profile', 'label': 'Profile', 'icon': Icons.person_outline},
  ];

  @override
  void initState() {
    super.initState();
    final initialIndex = tabs.indexWhere(
      (tab) => tab['id'] == widget.activeTab,
    );
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: initialIndex >= 0 ? initialIndex : 0,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        widget.onTabChange(tabs[_tabController.index]['id'] as String);
      }
    });
  }

  @override
  void didUpdateWidget(BottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeTab != oldWidget.activeTab) {
      final newIndex = tabs.indexWhere((tab) => tab['id'] == widget.activeTab);
      if (newIndex >= 0 && newIndex != _tabController.index) {
        _tabController.animateTo(newIndex);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        top: false,
        child: TabBar(
          controller: _tabController,
          tabs: tabs.map((tab) {
            return Tab(
              icon: Icon(tab['icon'] as IconData),
              text: tab['label'] as String,
              height: 65,
            );
          }).toList(),
          labelColor: Colors.grey.shade900,
          unselectedLabelColor: Colors.grey.shade400,
          indicatorColor: Colors.grey.shade900,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
