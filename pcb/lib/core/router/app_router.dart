import 'package:flutter/material.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/booking/data/models/booking_flow_args.dart';
import '../../features/booking/presentation/booking_success_screen.dart';
import '../../features/booking/presentation/checkout_screen.dart';
import '../../features/booking/presentation/select_tickets_screen.dart';
import '../../features/enclosure/presentation/enclosure_details_screen.dart';
import '../../features/enclosure/presentation/enclosure_selection_screen.dart';
import '../../features/home/presentation/main_shell.dart';
import '../../features/live_status/presentation/live_status_screen.dart';
import '../../features/matches/presentation/match_details_screen.dart';
import '../../features/matches/presentation/matches_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile/presentation/booking_history_screen.dart';
import '../../features/profile/presentation/help_support_screen.dart';
import '../../features/profile/presentation/language_screen.dart';
import '../../features/profile/presentation/notifications_screen.dart';
import '../../features/profile/presentation/payment_methods_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/staff/presentation/gate_dashboard_screen.dart';
import '../../features/staff/presentation/scan_result_screen.dart';
import '../../features/staff/presentation/scanner_screen.dart';
import '../../features/staff/presentation/staff_login_screen.dart';
import '../../features/tickets/presentation/my_tickets_screen.dart';
import '../../features/tickets/presentation/ticket_full_screen.dart';
import '../constants/app_assets.dart';
import 'route_names.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case RouteNames.onboarding:
        // Seamless cross-fade from splash to onboarding
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        );

      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(initialIsSignUp: false),
          settings: settings,
        );

      case RouteNames.register:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(initialIsSignUp: true),
          settings: settings,
        );

      case RouteNames.otp:
        final args = settings.arguments as Map<String, dynamic>?;
        final phone = args?['phone'] as String?;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(phoneNumber: phone),
          settings: settings,
        );

      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
          settings: settings,
        );

      case RouteNames.matches:
        return MaterialPageRoute(
          builder: (_) => const MatchesScreen(),
          settings: settings,
        );

      case RouteNames.matchDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => MatchDetailsScreen(
            team1: args?['team1'] as String? ?? 'Pakistan',
            team2: args?['team2'] as String? ?? 'New Zealand',
            format: args?['format'] as String? ?? 'ODI',
            venue: args?['venue'] as String? ?? 'Rawalpindi Cricket Stadium',
            dateTime: args?['dateTime'] as DateTime? ??
                DateTime.now().add(const Duration(hours: 5, minutes: 20)),
            imageAsset: args?['imageAsset'] as String? ?? AppAssets.stadiumSplash,
          ),
          settings: settings,
        );

      case RouteNames.enclosureSelection:
        return MaterialPageRoute(
          builder: (_) => EnclosureSelectionScreen(
            booking: BookingFlowArgs.fromMap(settings.arguments),
          ),
          settings: settings,
        );

      case RouteNames.enclosureDetails:
        return MaterialPageRoute(
          builder: (_) => EnclosureDetailsScreen(
            booking: BookingFlowArgs.fromMap(settings.arguments),
          ),
          settings: settings,
        );

      case RouteNames.selectTickets:
        return MaterialPageRoute(
          builder: (_) => SelectTicketsScreen(
            booking: BookingFlowArgs.fromMap(settings.arguments),
          ),
          settings: settings,
        );

      case RouteNames.checkout:
        return MaterialPageRoute(
          builder: (_) => CheckoutScreen(
            booking: BookingFlowArgs.fromMap(settings.arguments),
          ),
          settings: settings,
        );

      case RouteNames.bookingSuccess:
        return MaterialPageRoute(
          builder: (_) => BookingSuccessScreen(
            booking: BookingFlowArgs.fromMap(settings.arguments),
          ),
          settings: settings,
        );

      case RouteNames.ticketDetails:
        return MaterialPageRoute(
          builder: (_) => TicketFullScreen(
            booking: BookingFlowArgs.fromMap(settings.arguments),
          ),
          settings: settings,
        );

      case RouteNames.myTickets:
        return MaterialPageRoute(
          builder: (_) => const MyTicketsScreen(),
          settings: settings,
        );

      case RouteNames.liveStatus:
        return MaterialPageRoute(
          builder: (_) => const LiveStatusScreen(),
          settings: settings,
        );

      case RouteNames.staffLogin:
        return MaterialPageRoute(
          builder: (_) => const StaffLoginScreen(),
          settings: settings,
        );

      case RouteNames.gateDashboard:
        return MaterialPageRoute(
          builder: (_) => const GateDashboardScreen(),
          settings: settings,
        );

      case RouteNames.scanner:
        return MaterialPageRoute(
          builder: (_) => const ScannerScreen(),
          settings: settings,
        );

      case RouteNames.scanResult:
        return MaterialPageRoute(
          builder: (_) => ScanResultScreen(
            booking: BookingFlowArgs.fromMap(settings.arguments),
          ),
          settings: settings,
        );

      case RouteNames.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      case RouteNames.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );

      case RouteNames.notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
          settings: settings,
        );

      case RouteNames.language:
        return MaterialPageRoute(
          builder: (_) => const LanguageScreen(),
          settings: settings,
        );

      case RouteNames.helpSupport:
        return MaterialPageRoute(
          builder: (_) => const HelpSupportScreen(),
          settings: settings,
        );

      case RouteNames.paymentMethods:
        return MaterialPageRoute(
          builder: (_) => const PaymentMethodsScreen(),
          settings: settings,
        );

      case RouteNames.bookingHistory:
        return MaterialPageRoute(
          builder: (_) => const BookingHistoryScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
