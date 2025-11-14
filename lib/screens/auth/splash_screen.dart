import 'package:flutter/material.dart';
import 'package:suggest_doctor/themes/app_theme.dart';
import 'package:suggest_doctor/core/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _logoOpacity = 0.0;
  double _textOpacity = 0.0;
  bool _showProgress = false;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start the animation sequence
    _startAnimation();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    // Scale animation
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _scaleController.forward();
      }
    });

    // Logo fade in
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _logoOpacity = 1.0;
        });
      }
    });

    // Text fade in
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _textOpacity = 1.0;
        });
      }
    });

    // Show progress indicator
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showProgress = true;
        });
      }
    });

    // Navigate to next screen
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    NavigationService.pushNamedAndRemoveUntil('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.9),
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo Container
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: AnimatedOpacity(
                      opacity: _logoOpacity,
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.9),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 25,
                              offset: const Offset(0, 15),
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Background pattern
                            Positioned(
                              right: -10,
                              bottom: -10,
                              child: Icon(
                                Icons.favorite,
                                size: 40,
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.1),
                              ),
                            ),
                            // Main icon
                            Center(
                              child: Icon(
                                Icons.medical_services_rounded,
                                size: 70,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // App name with enhanced styling
                  AnimatedOpacity(
                    opacity: _textOpacity,
                    duration: const Duration(milliseconds: 1000),
                    child: ScaleTransition(
                      scale: _pulseAnimation,
                      child: Column(
                        children: [
                          Text(
                            'MediCare',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your Health Companion',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Enhanced progress indicator with better animation
                  if (_showProgress)
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 800),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white.withOpacity(0.9),
                              ),
                              backgroundColor: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          const SizedBox(height: 20),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            child: Column(
                              children: [
                                Text(
                                  'Preparing your health journey...',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Loading dots animation
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(3, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(
                                          milliseconds: 600 + (index * 200),
                                        ),
                                        curve: Curves.easeInOut,
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(
                                            _showProgress ? 0.8 : 0.3,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(height: 8),
                                AnimatedOpacity(
                                  opacity: _textOpacity,
                                  duration: const Duration(milliseconds: 1000),
                                  child: Text(
                                    'Safe • Secure • Reliable',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:suggest_doctor/themes/app_theme.dart';
// import 'package:suggest_doctor/core/navigation_service.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   double _opacity = 0.0;
//   bool _showProgress = false;

//   @override
//   void initState() {
//     super.initState();
//     // Start the animation sequence
//     _startAnimation();
//   }

//   void _startAnimation() {
//     // First, fade in the logo
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (mounted) {
//         setState(() {
//           _opacity = 1.0;
//         });
//       }
//     });

//     // Show progress indicator after logo is visible
//     Future.delayed(const Duration(milliseconds: 1500), () {
//       if (mounted) {
//         setState(() {
//           _showProgress = true;
//         });
//       }
//     });

//     // Navigate to next screen after animations complete
//     Future.delayed(const Duration(milliseconds: 3000), () {
//       if (mounted) {
//         _navigateToNextScreen();
//       }
//     });
//   }

//   void _navigateToNextScreen() {
//     // For now, we'll navigate to onboarding screen
//     // In a real app, you would check auth state here
//     NavigationService.pushNamedAndRemoveUntil('/onboarding');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primary,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo with fade-in animation
//             AnimatedOpacity(
//               opacity: _opacity,
//               duration: const Duration(milliseconds: 1000),
//               child: Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.local_hospital,
//                   size: 60,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
            
//             // App name
//             AnimatedOpacity(
//               opacity: _opacity,
//               duration: const Duration(milliseconds: 1000),
//               child: const Text(
//                 'Suggest Doctor',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//             ),
            
//             const SizedBox(height: 60),
            
//             // Progress indicator (appears after logo fade-in)
//             if (_showProgress)
//               AnimatedOpacity(
//                 opacity: 1.0,
//                 duration: const Duration(milliseconds: 500),
//                 child: Column(
//                   children: [
//                     const CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'Preparing your health journey...',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }