import 'package:estate_app/real-estate/pages/real_explore.dart';
import 'package:estate_app/real-estate/pages/real_favourite.dart';
import 'package:estate_app/real-estate/pages/real_home_screen.dart';
import 'package:estate_app/real-estate/pages/real_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class RealNavbar extends StatefulWidget {
  const RealNavbar({super.key});

  @override
  State<RealNavbar> createState() => _RealNavbarState();
}

class _RealNavbarState extends State<RealNavbar> {
  int _selectedIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final Color primaryBlue = Colors.blue;

  final List<Widget> _pages = [
    const RealHomeScreen(),
    const RealExplore(),
    const RealFavourite(),
    const RealProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: 30,
        ),

        child: GNav(
          backgroundColor: Colors.white,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          selectedIndex: _selectedIndex,
          onTabChange: _changeIndex,

          gap: 8,
          color: Colors.grey.shade500,
          activeColor: primaryBlue,
          tabBackgroundColor: primaryBlue.withValues(alpha: 0.12),
          tabBorderRadius: 12,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

          tabs: [
            GButton(
              icon: Icons.home,
              leading: HugeIcon(
                icon: HugeIcons.strokeRoundedHome01,
                color: _selectedIndex == 0 ? primaryBlue : Colors.grey.shade500,
                size: 24,
              ),
              text: 'Home',
            ),

            GButton(
              icon: Icons.search,
              leading: HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                color: _selectedIndex == 1 ? primaryBlue : Colors.grey.shade500,
                size: 24,
              ),
              text: 'Explore',
            ),

            GButton(
              icon: Icons.search,
              leading: HugeIcon(
                icon: HugeIcons.strokeRoundedFavourite,
                color: _selectedIndex == 2 ? primaryBlue : Colors.grey.shade500,
                size: 24,
              ),
              text: 'Favourite',
            ),

            GButton(
              icon: Icons.person,
              leading: HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: _selectedIndex == 3 ? primaryBlue : Colors.grey.shade500,
                size: 24,
              ),
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
