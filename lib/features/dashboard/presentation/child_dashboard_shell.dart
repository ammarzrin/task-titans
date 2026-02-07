import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';

class ChildDashboardShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ChildDashboardShell({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.comicBlack, width: 2),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          selectedItemColor: AppColors.vigilanteRed,
          unselectedItemColor: AppColors.midnightGrey,
          selectedLabelStyle: const TextStyle(fontFamily: 'Bungee'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Bungee'),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'HQ'),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'MY MISSIONS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'REWARDS',
            ),
          ],
        ),
      ),
    );
  }
}
