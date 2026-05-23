import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../screens/home/home_screen.dart';

import '../screens/kawruh/kawruh_screen.dart';
import '../screens/serat/serat_screen.dart';
import '../screens/mustika/mustika_screen.dart';
import '../screens/pengaturan/pengaturan_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => MainShellState();
}

class MainShellState extends State<MainShell> {
  int _bottomNavIndex = 0;

  void setTab(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const KawruhScreen(),
    const SeratScreen(),
    const MustikaScreen(),
    const PengaturanScreen(), // profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: KeyedSubtree(
              key: ValueKey<int>(_bottomNavIndex),
              child: _screens[_bottomNavIndex],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildCustomBottomBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBottomBar() {
    return Container(
      height: 90,
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, 'BERANDA', Icons.home),
                  _buildNavItem(1, 'KAWRUH', Icons.menu_book),
                  _buildNavItem(2, 'SERAT', Icons.auto_stories),
                  _buildNavItem(3, 'MUSTIKA', Icons.diamond),
                  _buildNavItem(4, 'PROFIL', Icons.person_outline),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    bool isActive = _bottomNavIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _bottomNavIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        height: 70,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // indikator aktif
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              bottom: isActive ? 20 : -50,
              child: AnimatedScale(
                scale: isActive ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              bottom: isActive ? 33 : 25,
              child: Icon(
                icon,
                color: isActive ? AppColors.primary : AppColors.accent,
                size: 24,
              ),
            ),
            
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              bottom: 8,
              child: Text(
                label,
                style: AppTypography.labelText.copyWith(
                  color: isActive ? AppColors.secondary : AppColors.accent,
                  fontSize: 8,
                  letterSpacing: 0.5,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

