import 'dart:async';

import 'package:flutter/material.dart';
import 'package:suggest_doctor/core/navigation_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _autoScrollTimer;

  // Simple onboarding data
  final List<Map<String, dynamic>> _onboardingPages = [
    {
      'title': 'Find Best Doctors',
      'description': 'Connect with verified doctors and specialists near you',
      'image': 'assets/images/onboarding/onb1.jpg',
      'color': Color(0xFF4361EE), // Blue
    },
    {
      'title': 'Book Appointments',
      'description': 'Schedule consultations with just a few taps',
      'image': 'assets/images/onboarding/onb2.jpg',
      'color': Color(0xFF3A0CA3), // Purple
    },
    {
      'title': 'Health Advice',
      'description': 'Access medical consultations anytime, anywhere',
      'image': 'assets/images/onboarding/onb3.jpg',
      'color': Color(0xFF7209B7), // Deep Purple
    },
    {
      'title': 'Health Records',
      'description': 'Keep all your medical records in one secure place',
      'image': 'assets/images/onboarding/onb4.jpg',
      'color': Color(0xFFF72585), // Pink
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < _onboardingPages.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    // Reset timer on manual page change
    _autoScrollTimer.cancel();
    _startAutoScroll();
  }

  void _onSkipPressed() {
    _autoScrollTimer.cancel();
    NavigationService.pushNamedAndRemoveUntil('/auth');
  }

  void _onNextPressed() {
    _autoScrollTimer.cancel();
    if (_currentPage < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      NavigationService.pushNamedAndRemoveUntil('/auth');
    }
    _startAutoScroll();
  }

  void _onIndicatorTap(int index) {
    _autoScrollTimer.cancel();
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _startAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 32),
          // Skip button
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: _onSkipPressed,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey.shade600,
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          
          // Page view
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingPages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return _OnboardingPage(
                  title: _onboardingPages[index]['title'],
                  description: _onboardingPages[index]['description'],
                  image: _onboardingPages[index]['image'],
                  color: _onboardingPages[index]['color'],
                );
              },
            ),
          ),
          
          // Indicators and button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingPages.length,
                    (index) => GestureDetector(
                      onTap: () => _onIndicatorTap(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index 
                              ? _onboardingPages[index]['color']
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Next button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onNextPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _onboardingPages[_currentPage]['color'],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage == _onboardingPages.length - 1 
                              ? 'Get Started' 
                              : 'Next',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (_currentPage < _onboardingPages.length - 1)
                          const SizedBox(width: 8),
                        if (_currentPage < _onboardingPages.length - 1)
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Color color;

  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image container
          Container(
            height: 280,
            margin: const EdgeInsets.only(bottom: 40),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background shape
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(120),
                  ),
                ),
                
                // Image with shadow
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.medical_services,
                            size: 80,
                            color: color,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Decorative element
                Positioned(
                  bottom: 5,
                  right: 40,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
              height: 1.3,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              // color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:suggest_doctor/core/navigation_service.dart';


// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   // Onboarding data
//   final List<Map<String, String>> _onboardingPages = [
//     {
//       'title': 'Find Best Doctors',
//       'description': 'Connect with verified doctors and specialists near you',
//       'image': 'assets/images/onboarding1.png', // Placeholder
//     },
//     {
//       'title': 'Book Appointments',
//       'description': 'Schedule consultations with just a few taps',
//       'image': 'assets/images/onboarding2.png', // Placeholder
//     },
//     {
//       'title': 'Get Health Advice',
//       'description': 'Access medical consultations anytime, anywhere',
//       'image': 'assets/images/onboarding3.png', // Placeholder
//     },
//     {
//       'title': 'Manage Health Records',
//       'description': 'Keep all your medical records in one secure place',
//       'image': 'assets/images/onboarding4.png', // Placeholder
//     },
//   ];

//   void _onPageChanged(int index) {
//     setState(() {
//       _currentPage = index;
//     });
//   }

//   void _onSkipPressed() {
//     // Navigate to auth screen
//     NavigationService.pushNamedAndRemoveUntil('/auth');
//   }

//   void _onNextPressed() {
//     if (_currentPage < _onboardingPages.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       // Navigate to auth screen
//       NavigationService.pushNamedAndRemoveUntil('/auth');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Theme.of(context).colorScheme.primary.withOpacity(0.1),
//                   Theme.of(context).colorScheme.background,
//                 ],
//               ),
//             ),
//           ),
          
//           // Main content
//           Column(
//             children: [
//               const SizedBox(height: 34),
//               // Skip button
//               Align(
//                 alignment: Alignment.topRight,
//                 child: TextButton(
//                   onPressed: _onSkipPressed,
//                   child: const Text(
//                     'Skip',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
              
//               // Page view
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   itemCount: _onboardingPages.length,
//                   onPageChanged: _onPageChanged,
//                   itemBuilder: (context, index) {
//                     return _OnboardingPage(
//                       title: _onboardingPages[index]['title']!,
//                       description: _onboardingPages[index]['description']!,
//                       image: _onboardingPages[index]['image']!,
//                     );
//                   },
//                 ),
//               ),
              
//               // Indicators and button
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//                 child: Column(
//                   children: [
//                     // Page indicators
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         _onboardingPages.length,
//                         (index) => Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           width: _currentPage == index ? 24 : 8,
//                           height: 8,
//                           decoration: BoxDecoration(
//                             color: _currentPage == index 
//                                 ? Theme.of(context).colorScheme.primary 
//                                 : Theme.of(context).colorScheme.primary.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ),
//                       ),
//                     ),
                    
//                     const SizedBox(height: 32),
                    
//                     // Next button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 56,
//                       child: ElevatedButton(
//                         onPressed: _onNextPressed,
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: Text(
//                           _currentPage == _onboardingPages.length - 1 
//                               ? 'Get Started' 
//                               : 'Next',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _OnboardingPage extends StatelessWidget {
//   final String title;
//   final String description;
//   final String image;

//   const _OnboardingPage({
//     required this.title,
//     required this.description,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Illustration
//           Container(
//             height: 300,
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: Center(
//               child: Icon(
//                 Icons.health_and_safety,
//                 size: 120,
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//             ),
//           ),
          
//           const SizedBox(height: 40),
          
//           // Title
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
          
//           const SizedBox(height: 16),
          
//           // Description
//           Text(
//             description,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 16,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }