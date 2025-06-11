// lib/main.dart
import 'package:flutter/material.dart';

// User Pages
import 'pages/user/login_page.dart';
import 'pages/user/register_page.dart';
import 'pages/user/home_page.dart';
import 'pages/user/nurses_page.dart';
import 'pages/user/nurse_profile_page.dart';
import 'pages/user/education_page.dart';
import 'pages/user/profile_page.dart';
import 'pages/user/my_bookings_page.dart';
import 'pages/user/edit_profile_page.dart';
import 'pages/user/booking_detail_page.dart';
import 'pages/user/notifications_page.dart';
import 'pages/user/help_faq_page.dart';
import 'pages/user/settings_page.dart';
import 'pages/user/favorite_nurses_page.dart';
import 'pages/user/search_filter_page.dart';
import 'pages/user/chat_support_page.dart';
import 'pages/user/emergency_booking_page.dart';

// Caregiver Pages (akan dibuat nanti)
// import 'pages/caregiver/caregiver_login_page.dart';
// import 'pages/caregiver/caregiver_dashboard_page.dart';
// import 'pages/caregiver/caregiver_profile_page.dart';
// import 'pages/caregiver/caregiver_bookings_page.dart';
// import 'pages/caregiver/caregiver_settings_page.dart';

void main() {
  runApp(const JagaBersamaApp());
}

class JagaBersamaApp extends StatelessWidget {
  const JagaBersamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JagaBersama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFFE91E63,
          <int, Color>{
            50: Color(0xFFFCE4EC),
            100: Color(0xFFF8BBD9),
            200: Color(0xFFF48FB1),
            300: Color(0xFFF06292),
            400: Color(0xFFEC407A),
            500: Color(0xFFE91E63),
            600: Color(0xFFD81B60),
            700: Color(0xFFC2185B),
            800: Color(0xFFAD1457),
            900: Color(0xFF880E4F),
          },
        ),
        primaryColor: Color(0xFFE91E63),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFE91E63),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE91E63),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Color(0xFFE91E63),
            side: BorderSide(color: Color(0xFFE91E63)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      initialRoute: '/',
      routes: {
        // User Routes
        '/': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/nurses': (context) => const NursesPage(),
        '/nurse-profile': (context) => const NurseProfilePage(),
        '/education': (context) => const EducationPage(),
        '/profile': (context) => const ProfilePage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/my-bookings': (context) => const MyBookingsPage(),
        '/booking-detail': (context) => const BookingDetailPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/help': (context) => const HelpFaqPage(),
        '/settings': (context) => const SettingsPage(),
        '/favorite-nurses': (context) => const FavoriteNursesPage(),
        '/search-filter': (context) => const SearchFilterPage(),
        '/chat-support': (context) => const ChatSupportPage(),
        '/emergency-booking': (context) => const EmergencyBookingPage(),
        
        // Placeholder routes
        '/emergency-tracking': (context) => const EmergencyTrackingPlaceholder(),
        
        // Caregiver Routes (akan dibuat nanti)
        // '/caregiver': (context) => const CaregiverLoginPage(),
        // '/caregiver/dashboard': (context) => const CaregiverDashboardPage(),
        // '/caregiver/profile': (context) => const CaregiverProfilePage(),
        // '/caregiver/bookings': (context) => const CaregiverBookingsPage(),
        // '/caregiver/settings': (context) => const CaregiverSettingsPage(),
      },
    );
  }
}

class EmergencyTrackingPlaceholder extends StatelessWidget {
  const EmergencyTrackingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Emergency Tracking',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emergency_share,
              size: 64,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'Tim Darurat Sedang Menuju',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Estimasi kedatangan: 8-12 menit',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              icon: Icon(Icons.home),
              label: Text('Kembali ke Beranda'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}