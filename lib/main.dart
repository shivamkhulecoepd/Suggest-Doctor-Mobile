import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:suggest_doctor/screens/auth/auth_entry_screen.dart';
import 'package:suggest_doctor/screens/auth/forgot_password_screen.dart';
import 'package:suggest_doctor/screens/auth/onboarding_screen.dart';
import 'package:suggest_doctor/screens/auth/otp_verification_screen.dart';
import 'package:suggest_doctor/screens/auth/signin_email_screen.dart';
import 'package:suggest_doctor/screens/auth/signup_phone_screen.dart';
import 'package:suggest_doctor/screens/auth/splash_screen.dart';
import 'package:suggest_doctor/screens/booking/booking_confirmation_screen.dart';
import 'package:suggest_doctor/screens/booking/booking_flow_screen.dart';
import 'package:suggest_doctor/screens/healthcare/ehr_reports_screen.dart';
import 'package:suggest_doctor/screens/healthcare/health_feed_screen.dart';
import 'package:suggest_doctor/screens/healthcare/lab_tests_screen.dart' as lab_tests;
import 'package:suggest_doctor/screens/healthcare/pharmacy_order_flow_screen.dart';
import 'package:suggest_doctor/screens/healthcare/prescriptions_medication_screen.dart';
import 'package:suggest_doctor/screens/home/home_screen_modern.dart';
import 'package:suggest_doctor/screens/profile/doctor_profile_screen.dart';
import 'package:suggest_doctor/screens/profile/patient_profile_screen.dart';
import 'package:suggest_doctor/screens/home/search_results_screen.dart';
import 'core/navigation_service.dart';
import 'themes/app_theme.dart';
import 'package:suggest_doctor/screens/booking/appointments_screen.dart';
import 'package:suggest_doctor/screens/communication/chat_screen.dart';
import 'package:suggest_doctor/screens/communication/video_consultation_screen.dart';
import 'package:suggest_doctor/screens/ecommerce/orders_deliveries_screen.dart';
import 'package:suggest_doctor/screens/notifications/notifications_center_screen.dart';
import 'package:suggest_doctor/screens/profile/favorites_screen.dart';
import 'package:suggest_doctor/screens/reviews/ratings_reviews_screen.dart';
import 'package:suggest_doctor/screens/ecommerce/payments_wallet_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
      title: 'Suggest Doctor',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/auth': (context) => const AuthEntryScreen(),
        '/signup_phone': (context) => const SignupPhoneScreen(),
        '/otp_verification': (context) => const OTPVerificationScreen(),
        '/signin_email': (context) => const SigninEmailScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreenModern(),
        '/search': (context) => const SearchResultsScreen(query: 'cardiologist'),
        '/doctor_profile': (context) => const DoctorProfileScreen(),
        '/booking': (context) => const BookingFlowScreen(),
        '/booking_confirmation': (context) => const BookingConfirmationScreen(),
        '/appointments': (context) => const AppointmentsScreen(),
        '/chat': (context) => const ChatScreen(),
        '/video_consultation': (context) => const VideoConsultationScreen(),
        '/patient_profile': (context) => const PatientProfileScreen(),
        '/ehr_reports': (context) => const EhrReportsScreen(),
        '/prescriptions': (context) => const PrescriptionsMedicationScreen(),
        '/pharmacy_order': (context) => const PharmacyOrderFlowScreen(),
        '/lab_tests': (context) => const lab_tests.LabTestsScreen(),
        '/orders_deliveries': (context) => const OrdersDeliveriesScreen(),
        '/notifications': (context) => const NotificationsCenterScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/ratings_reviews': (context) => const RatingsReviewsScreen(
              providerName: 'Dr. Sarah Johnson',
              providerSpecialty: 'Cardiologist',
              providerIcon: Icons.person,
            ),
        '/health_feed': (context) => const HealthFeedScreen(),
        '/payments_wallet': (context) => const PaymentsWalletScreen(),
      },
      // Add navigator key for better navigation management
      navigatorKey: NavigationService.navigatorKey,
      // Handle unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
      debugShowCheckedModeBanner: false,
    );
      },
    );
  }
}