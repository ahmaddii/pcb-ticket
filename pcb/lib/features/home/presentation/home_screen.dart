import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/route_names.dart';
import 'widgets/featured_match_card.dart';
import 'widgets/match_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDateIndex = 2; // Default Tuesday selected like in screenshot

  final List<Map<String, String>> _calendarDays = const [
    {'day': 'S', 'date': '24'},
    {'day': 'M', 'date': '25'},
    {'day': 'T', 'date': '26'},
    {'day': 'W', 'date': '27'},
    {'day': 'T', 'date': '28'},
    {'day': 'F', 'date': '29'},
    {'day': 'S', 'date': '30'},
  ];

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF141A18),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF2A3632), width: 1.2),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    VoidCallback? onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'See all',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03140F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // 1. Top Header Row (Title on Left, Bell & Menu on Right)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Title
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LIVE SCORE',
                        style: TextStyle(
                          color: Color(0xFF8FA89B),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'CRICKET',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),

                  // Notification Bell & Hamburger Icons
                  Row(
                    children: [
                      _buildCircleButton(
                        icon: Icons.notifications_none,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RouteNames.notifications,
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildCircleButton(
                        icon: Icons.menu,
                        onTap: () {
                          // Drawer or Settings
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 2. Hero Headline
              const Text(
                'Your Ultimate Cricket\nMatch Companion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                  letterSpacing: -0.4,
                ),
              ),

              const SizedBox(height: 22),

              // 3. Weekly Date Strip (Matching Reference Screenshot)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_calendarDays.length, (index) {
                  final isSelected = index == _selectedDateIndex;
                  final item = _calendarDays[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDateIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 42,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : const Color(0xFF141A18),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isSelected ? Colors.white : const Color(0xFF24332D),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item['day']!,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white60,
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['date']!,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 28),

              // 4. Upcoming Matches Section Header
              _buildSectionHeader(
                title: 'Upcoming Matches',
                onSeeAll: () {
                  Navigator.of(context).pushNamed(RouteNames.matches);
                },
              ),

              const SizedBox(height: 14),

              // 5. Featured Live Match Card
              FeaturedMatchCard(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouteNames.matchDetails,
                    arguments: {
                      'team1': 'Pakistan',
                      'team2': 'New Zealand',
                      'format': 'ODI',
                      'venue': 'Rawalpindi Cricket Stadium',
                      'dateTime': DateTime.now().add(
                        const Duration(hours: 5, minutes: 20),
                      ),
                      'imageAsset': AppAssets.stadiumSplash,
                    },
                  );
                },
              ),

              const SizedBox(height: 28),

              // 6. Today Match Section Header
              _buildSectionHeader(
                title: 'Today Match',
                onSeeAll: () {
                  Navigator.of(context).pushNamed(RouteNames.matches);
                },
              ),

              const SizedBox(height: 14),

              // 7. Today Match Tiles
              MatchListTile(
                team1Name: 'Pakistan',
                team1Initials: 'PAK',
                team1Color: const Color(0xFFC5A059),
                team1LogoAsset: AppAssets.splashLogoOriginal,
                team2Name: 'England',
                team2Initials: 'ENG',
                team2Color: const Color(0xFF00247D),
                team2LogoAsset: AppAssets.flagEngland,
                time: 'Today 19:30',
                venue: 'Gaddafi Stadium, Lahore',
                onTap: () {
                  final now = DateTime.now();
                  Navigator.of(context).pushNamed(
                    RouteNames.matchDetails,
                    arguments: {
                      'team1': 'Pakistan',
                      'team2': 'England',
                      'format': 'T20I',
                      'venue': 'Gaddafi Stadium, Lahore',
                      'dateTime': DateTime(now.year, now.month, now.day, 19, 30),
                      'imageAsset': AppAssets.featuredBanner1,
                    },
                  );
                },
              ),

              MatchListTile(
                team1Name: 'Pakistan',
                team1Initials: 'PAK',
                team1Color: const Color(0xFFC5A059),
                team1LogoAsset: AppAssets.splashLogoOriginal,
                team2Name: 'Sri Lanka',
                team2Initials: 'SL',
                team2Color: const Color(0xFF8D153A),
                team2LogoAsset: AppAssets.flagSriLanka,
                time: 'Tomorrow 14:00',
                venue: 'National Stadium, Karachi',
                onTap: () {
                  final tomorrow = DateTime.now().add(const Duration(days: 1));
                  Navigator.of(context).pushNamed(
                    RouteNames.matchDetails,
                    arguments: {
                      'team1': 'Pakistan',
                      'team2': 'Sri Lanka',
                      'format': 'ODI',
                      'venue': 'National Stadium, Karachi',
                      'dateTime': DateTime(
                        tomorrow.year,
                        tomorrow.month,
                        tomorrow.day,
                        14,
                      ),
                      'imageAsset': AppAssets.featuredBanner2,
                    },
                  );
                },
              ),

              MatchListTile(
                team1Name: 'England',
                team1Initials: 'ENG',
                team1Color: const Color(0xFF00247D),
                team1LogoAsset: AppAssets.flagEngland,
                team2Name: 'Sri Lanka',
                team2Initials: 'SL',
                team2Color: const Color(0xFF8D153A),
                team2LogoAsset: AppAssets.flagSriLanka,
                time: 'Fri 15:00',
                venue: 'Rawalpindi Cricket Stadium',
                onTap: () {
                  final now = DateTime.now();
                  final daysUntilFriday = (DateTime.friday - now.weekday) % 7;
                  final friday = now.add(
                    Duration(days: daysUntilFriday == 0 ? 7 : daysUntilFriday),
                  );
                  Navigator.of(context).pushNamed(
                    RouteNames.matchDetails,
                    arguments: {
                      'team1': 'England',
                      'team2': 'Sri Lanka',
                      'format': 'Test',
                      'venue': 'Rawalpindi Cricket Stadium',
                      'dateTime': DateTime(
                        friday.year,
                        friday.month,
                        friday.day,
                        15,
                      ),
                      'imageAsset': AppAssets.onboarding1,
                    },
                  );
                },
              ),

              // Clean compact bottom padding without empty space
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
