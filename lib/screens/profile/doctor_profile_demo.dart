import 'package:flutter/material.dart';
import 'package:suggest_doctor/screens/profile/enhanced_doctor_profile_screen.dart';

class DoctorProfileDemo extends StatelessWidget {
  const DoctorProfileDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EnhancedDoctorProfileScreen(),
    );
  }
}