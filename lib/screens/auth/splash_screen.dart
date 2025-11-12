import 'package:flutter/material.dart';
import 'package:suggest_doctor/themes/app_theme.dart';
import 'package:suggest_doctor/core/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    // Start the animation sequence
    _startAnimation();
  }

  void _startAnimation() {
    // First, fade in the logo
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    // Show progress indicator after logo is visible
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showProgress = true;
        });
      }
    });

    // Navigate to next screen after animations complete
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    // For now, we'll navigate to onboarding screen
    // In a real app, you would check auth state here
    NavigationService.pushNamedAndRemoveUntil('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with fade-in animation
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 1000),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.local_hospital,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // App name
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                'Suggest Doctor',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            
            const SizedBox(height: 60),
            
            // Progress indicator (appears after logo fade-in)
            if (_showProgress)
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Preparing your health journey...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}