import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../live_status/presentation/live_status_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../tickets/presentation/my_tickets_screen.dart';
import 'home_screen.dart';

class MainShell extends StatefulWidget {
  final int initialIndex;

  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    HomeScreen(),
    LiveStatusScreen(),
    MyTicketsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  Widget _buildDockItem({
    required int index,
    required String assetIcon,
    required String tooltip,
  }) {
    final isActive = _currentIndex == index;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Image.asset(
            assetIcon,
            width: 22,
            height: 22,
            color: isActive ? Colors.black : Colors.white70,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03140F),
      body: Stack(
        children: [
          // 1. Current Active Page
          IndexedStack(index: _currentIndex, children: _pages),

          // 2. Fixed Floating Bottom Navigation Dock
          Positioned(
            left: 28,
            right: 28,
            bottom: 22,
            child: SafeArea(
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF141A18).withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: const Color(0xFF2A3632),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildDockItem(
                      index: 0,
                      assetIcon: AppAssets.iconHome,
                      tooltip: 'Home',
                    ),
                    _buildDockItem(
                      index: 1,
                      assetIcon: AppAssets.iconCricketGround,
                      tooltip: 'Live status',
                    ),
                    _buildDockItem(
                      index: 2,
                      assetIcon: AppAssets.iconTicket,
                      tooltip: 'Tickets',
                    ),
                    _buildDockItem(
                      index: 3,
                      assetIcon: AppAssets.iconProfile,
                      tooltip: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
