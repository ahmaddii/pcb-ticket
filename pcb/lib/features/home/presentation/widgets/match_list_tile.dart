import 'package:flutter/material.dart';

class MatchListTile extends StatelessWidget {
  final String team1Name;
  final String team1Initials;
  final Color team1Color;
  final String? team1LogoAsset;
  final String team2Name;
  final String team2Initials;
  final Color team2Color;
  final String? team2LogoAsset;
  final String time;
  final String venue;
  final VoidCallback? onTap;

  const MatchListTile({
    super.key,
    this.team1Name = 'Pakistan',
    this.team1Initials = 'PAK',
    this.team1Color = const Color(0xFFC5A059),
    this.team1LogoAsset,
    this.team2Name = 'England',
    this.team2Initials = 'ENG',
    this.team2Color = const Color(0xFF00247D),
    this.team2LogoAsset,
    this.time = '19:30',
    this.venue = 'Gaddafi Stadium, Lahore',
    this.onTap,
  });

  Widget _buildTeamBadge({
    required String initials,
    required Color color,
    String? logoAsset,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF141A18),
        border: Border.all(color: const Color(0xFF24332D), width: 1.5),
      ),
      child: ClipOval(
        child: logoAsset != null
            ? SizedBox.expand(
                child: Image.asset(
                  logoAsset,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: color,
                      alignment: Alignment.center,
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                color: color,
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF141A18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF24332D), width: 1.2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Team 1 Logo / Flag
              _buildTeamBadge(
                initials: team1Initials,
                color: team1Color,
                logoAsset: team1LogoAsset,
              ),

              const SizedBox(width: 14),

              // Match Details Center
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$team1Name VS $team2Name',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      venue,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Team 2 Logo / Flag
              _buildTeamBadge(
                initials: team2Initials,
                color: team2Color,
                logoAsset: team2LogoAsset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
