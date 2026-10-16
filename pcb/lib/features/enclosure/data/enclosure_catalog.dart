import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class EnclosureOption {
  final String id;
  final String name;
  final double price;
  final int availableSeats;
  final Color color;
  final String coverAsset;
  final List<String> panoramaAssets;
  final String standType;
  final String seatingType;
  final String distanceFromGate;

  const EnclosureOption({
    required this.id,
    required this.name,
    required this.price,
    required this.availableSeats,
    required this.color,
    required this.coverAsset,
    required this.panoramaAssets,
    required this.standType,
    required this.seatingType,
    required this.distanceFromGate,
  });

  bool get isLimited => availableSeats < 500;
}

class EnclosureCatalog {
  const EnclosureCatalog._();

  static const List<EnclosureOption> all = [
    EnclosureOption(
      id: 'general',
      name: 'General Enclosure',
      price: 1000,
      availableSeats: 2500,
      color: Color(0xFF22C55E),
      coverAsset: AppAssets.stadiumSplash,
      panoramaAssets: [
        AppAssets.onboarding1,
        AppAssets.featuredBanner1,
        AppAssets.onboarding2,
        AppAssets.featuredBanner2,
      ],
      standType: 'Open Stand',
      seatingType: 'Unreserved',
      distanceFromGate: '1.2 km',
    ),
    EnclosureOption(
      id: 'first_class',
      name: 'First Class Enclosure',
      price: 2000,
      availableSeats: 1800,
      color: Color(0xFF3B82F6),
      coverAsset: AppAssets.featuredBanner1,
      panoramaAssets: [
        AppAssets.featuredBanner1,
        AppAssets.onboarding2,
        AppAssets.featuredBanner2,
        AppAssets.onboarding3,
      ],
      standType: 'Covered Stand',
      seatingType: 'Reserved',
      distanceFromGate: '0.8 km',
    ),
    EnclosureOption(
      id: 'premium',
      name: 'Premium Enclosure',
      price: 3500,
      availableSeats: 1200,
      color: Color(0xFF8B5CF6),
      coverAsset: AppAssets.featuredBanner2,
      panoramaAssets: [
        AppAssets.featuredBanner2,
        AppAssets.onboarding3,
        AppAssets.featuredMatch,
        AppAssets.onboarding1,
      ],
      standType: 'Club Stand',
      seatingType: 'Reserved',
      distanceFromGate: '0.5 km',
    ),
    EnclosureOption(
      id: 'vip',
      name: 'VIP Enclosure',
      price: 5000,
      availableSeats: 400,
      color: Color(0xFFE0B43C),
      coverAsset: AppAssets.onboarding3,
      panoramaAssets: [
        AppAssets.onboarding3,
        AppAssets.featuredMatch,
        AppAssets.onboarding1,
        AppAssets.featuredBanner1,
      ],
      standType: 'Pavilion',
      seatingType: 'Reserved',
      distanceFromGate: '0.3 km',
    ),
  ];

  static EnclosureOption byId(String id) {
    return all.firstWhere(
      (item) => item.id == id,
      orElse: () => all.first,
    );
  }
}
