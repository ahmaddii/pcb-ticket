import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class EnclosureOption {
  final String id;
  final String name;
  final double price;
  final int availableSeats;
  final Color color;
  final String coverAsset;
  final String standType;
  final String seatingType;
  final String distanceFromGate;
  final String gateLabel;

  const EnclosureOption({
    required this.id,
    required this.name,
    required this.price,
    required this.availableSeats,
    required this.color,
    required this.coverAsset,
    required this.standType,
    required this.seatingType,
    required this.distanceFromGate,
    required this.gateLabel,
  });

  bool get isLimited => availableSeats < 500;
}

class EnclosureCatalog {
  const EnclosureCatalog._();

  static const List<EnclosureOption> all = [
    EnclosureOption(
      id: 'imran_khan',
      name: 'Imran Khan Enclosure',
      price: 4500,
      availableSeats: 850,
      color: Color(0xFFD31010),
      coverAsset: AppAssets.featuredBanner1,
      standType: 'VIP Stand (Covered)',
      seatingType: 'Reserved',
      distanceFromGate: '150 m',
      gateLabel: 'Gate 1 & 2',
    ),
    EnclosureOption(
      id: 'shoaib_akhter',
      name: 'Shoaib Akhter Enclosure',
      price: 2500,
      availableSeats: 1800,
      color: Color(0xFFFDD835),
      coverAsset: AppAssets.featuredBanner2,
      standType: 'Premium Stand',
      seatingType: 'Reserved',
      distanceFromGate: '220 m',
      gateLabel: 'Gate 2 & 3',
    ),
    EnclosureOption(
      id: 'sohail_tanveer',
      name: 'Sohail Tanveer Enclosure',
      price: 1000,
      availableSeats: 3200,
      color: Color(0xFF00A859),
      coverAsset: AppAssets.stadiumSplash,
      standType: 'General Stand (Open)',
      seatingType: 'Unreserved',
      distanceFromGate: '350 m',
      gateLabel: 'Gate 3 & 4',
    ),
    EnclosureOption(
      id: 'javed_akhter',
      name: 'Javed Akhter Enclosure',
      price: 4000,
      availableSeats: 750,
      color: Color(0xFFD31010),
      coverAsset: AppAssets.onboarding3,
      standType: 'VIP Stand',
      seatingType: 'Reserved',
      distanceFromGate: '280 m',
      gateLabel: 'Gate 4',
    ),
    EnclosureOption(
      id: 'azhar_mehmood',
      name: 'Azhar Mehmood Enclosure',
      price: 4000,
      availableSeats: 750,
      color: Color(0xFFD31010),
      coverAsset: AppAssets.onboarding1,
      standType: 'VIP Stand',
      seatingType: 'Reserved',
      distanceFromGate: '280 m',
      gateLabel: 'Gate 5',
    ),
    EnclosureOption(
      id: 'miran_buksh',
      name: 'Miran Buksh Enclosure',
      price: 2000,
      availableSeats: 1500,
      color: Color(0xFF1E56A0),
      coverAsset: AppAssets.featuredBanner1,
      standType: 'First Class Stand',
      seatingType: 'Reserved',
      distanceFromGate: '200 m',
      gateLabel: 'Gate 5 & 6',
    ),
    EnclosureOption(
      id: 'yasir_arafat',
      name: 'Yasir Arafat Enclosure',
      price: 2000,
      availableSeats: 1600,
      color: Color(0xFF1E56A0),
      coverAsset: AppAssets.featuredBanner2,
      standType: 'First Class Stand',
      seatingType: 'Reserved',
      distanceFromGate: '180 m',
      gateLabel: 'Gate 6 & 7',
    ),
    EnclosureOption(
      id: 'javed_miandad',
      name: 'Javed Miandad Enclosure',
      price: 4500,
      availableSeats: 900,
      color: Color(0xFFD31010),
      coverAsset: AppAssets.featuredMatch,
      standType: 'VIP Stand (Covered)',
      seatingType: 'Reserved',
      distanceFromGate: '140 m',
      gateLabel: 'Gate 7 & 8',
    ),
    EnclosureOption(
      id: 'pavilion',
      name: 'Main Pavilion / VIP Gallery',
      price: 8000,
      availableSeats: 320,
      color: Color(0xFF282828),
      coverAsset: AppAssets.onboarding2,
      standType: 'Chairman & Members Box',
      seatingType: 'Reserved Hospitality',
      distanceFromGate: '50 m',
      gateLabel: 'Main Entrance (Gate 1 & 8)',
    ),
  ];

  static EnclosureOption byId(String id) {
    if (id == 'general') return byId('sohail_tanveer');
    if (id == 'first_class') return byId('miran_buksh');
    if (id == 'premium') return byId('shoaib_akhter');
    if (id == 'vip') return byId('imran_khan');
    return all.firstWhere(
      (item) => item.id == id,
      orElse: () => all.first,
    );
  }
}
