import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../home/presentation/widgets/match_list_tile.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final canPop = Navigator.of(context).canPop();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    if (canPop) const DarkBackButton(),
                    if (canPop) const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'All Fixtures',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  children: [
                    MatchListTile(
                      team1Name: 'Pakistan',
                      team2Name: 'New Zealand',
                      team2Initials: 'NZ',
                      time: 'Today 14:00',
                      venue: 'Rawalpindi Cricket Stadium',
                      team1LogoAsset: AppAssets.splashLogoOriginal,
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
                    MatchListTile(
                      team1Name: 'Pakistan',
                      team2Name: 'England',
                      team2LogoAsset: AppAssets.flagEngland,
                      time: 'Today 19:30',
                      venue: 'Gaddafi Stadium, Lahore',
                      team1LogoAsset: AppAssets.splashLogoOriginal,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteNames.matchDetails,
                          arguments: {
                            'team1': 'Pakistan',
                            'team2': 'England',
                            'format': 'T20I',
                            'venue': 'Gaddafi Stadium, Lahore',
                            'dateTime': DateTime(
                              now.year,
                              now.month,
                              now.day,
                              19,
                              30,
                            ),
                            'imageAsset': AppAssets.featuredBanner1,
                          },
                        );
                      },
                    ),
                    MatchListTile(
                      team1Name: 'Pakistan',
                      team2Name: 'Sri Lanka',
                      team2Initials: 'SL',
                      team2Color: const Color(0xFF8D153A),
                      team2LogoAsset: AppAssets.flagSriLanka,
                      time: 'Tomorrow 14:00',
                      venue: 'National Stadium, Karachi',
                      team1LogoAsset: AppAssets.splashLogoOriginal,
                      onTap: () {
                        final tomorrow =
                            DateTime.now().add(const Duration(days: 1));
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
                        final daysUntilFriday =
                            (DateTime.friday - now.weekday) % 7;
                        final friday = now.add(
                          Duration(
                            days: daysUntilFriday == 0 ? 7 : daysUntilFriday,
                          ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
