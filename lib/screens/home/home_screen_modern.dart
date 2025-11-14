import 'package:flutter/material.dart';
import 'package:suggest_doctor/screens/booking/appointments_screen_new.dart';
import 'package:suggest_doctor/screens/ecommerce/medicines_listing_screen.dart';
import 'package:suggest_doctor/screens/profile/doctor_profile_screen.dart';
import 'package:suggest_doctor/screens/profile/enhanced_doctor_profile_screen.dart';
import '../../core/constants.dart';
import '../../core/responsive.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/network_image_widget.dart';
import '../booking/appointments_screen.dart';
import '../communication/chat_screen.dart';
import '../ecommerce/orders_deliveries_screen.dart';
import '../profile/patient_profile_screen.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';

class HomeScreenModern extends StatefulWidget {
  const HomeScreenModern({super.key});

  @override
  State<HomeScreenModern> createState() => _HomeScreenModernState();
}

class _HomeScreenModernState extends State<HomeScreenModern> {
  int _selectedIndex = 0;

  List<Widget> get _widgetOptions => [
    HomeContentModern(
      onAppointmentTap: () {
        setState(() {
          _selectedIndex = 1;
        });
      },
    ),
    // const AppointmentsScreen(),
    const AppointmentsScreenNew(),
    const ChatScreen(),
    MedicineListScreen(),
    const PatientProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContentModern extends StatelessWidget {
  final VoidCallback? onAppointmentTap;

  const HomeContentModern({super.key, this.onAppointmentTap});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Modern app bar with greeting and profile
        SliverAppBar(
          pinned: true,
          floating: true,
          snap: false,
          title: Text(
            'Good morning,',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 20),
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: EdgeInsets.all(Responsive.spacing(context, 8)),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none,
                  color: Theme.of(context).colorScheme.primary,
                  size: Responsive.size(context, 24),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
            ),
            SizedBox(width: Responsive.spacing(context, 8)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/patient_profile');
              },
              child: NetworkImageWidget(
                imageUrl: 'https://via.placeholder.com/150',
                width: Responsive.size(context, 40),
                height: Responsive.size(context, 40),
                isCircle: true,
              ),
            ),
            SizedBox(width: Responsive.spacing(context, 16)),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),

        // Search bar with modern styling
        SliverToBoxAdapter(
          child: Padding(
            padding: Responsive.adaptivePadding(context),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(
                  Responsive.size(context, AppConstants.radiusLg),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: Responsive.size(context, 10),
                    offset: Offset(0, Responsive.size(context, 2)),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search doctors, clinics, specialties...',
                  hintStyle: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                    size: Responsive.size(context, 20),
                  ),
                  suffixIcon: Container(
                    margin: EdgeInsets.all(Responsive.spacing(context, 8)),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(
                        Responsive.size(context, 8),
                      ),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: Responsive.size(context, 20),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Responsive.spacing(context, 16),
                    vertical: Responsive.spacing(context, 16),
                  ),
                ),
                style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ),
          ),
        ),

        // Quick actions with modern cards
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacing(context, AppConstants.spacingMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ModernQuickActionButton(
                      icon: Icons.calendar_today,
                      label: 'Appointment',
                      color: const Color(0xFF4CAF50),
                      // onTap:
                      //     onAppointmentTap ??
                      //     () {
                      //       Navigator.of(context).push(
                      //         MaterialPageRoute(
                      //           builder: (context) => AppointmentsScreenNew(),
                      //         ),
                      //       );
                      //     },
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AppointmentsScreenNew(),
                          ),
                        );
                      },
                    ),
                    _ModernQuickActionButton(
                      icon: Icons.video_call,
                      label: 'Video Consult',
                      color: const Color(0xFF2196F3),
                      onTap: () {
                        Navigator.pushNamed(context, '/video_consultation');
                      },
                    ),
                    _ModernQuickActionButton(
                      icon: Icons.home,
                      label: 'Home Test',
                      color: const Color(0xFFFF9800),
                      onTap: () {
                        Navigator.pushNamed(context, '/lab_tests');
                      },
                    ),
                    _ModernQuickActionButton(
                      icon: Icons.local_pharmacy,
                      label: 'Medicine',
                      color: const Color(0xFF9C27B0),
                      onTap: () {
                        Navigator.pushNamed(context, '/browse_medicines');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Promotional carousel with modern styling and background image
        SliverToBoxAdapter(
          child: Container(
            height: Responsive.size(context, 180),
            margin: Responsive.adaptivePadding(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Responsive.size(context, AppConstants.radiusLg),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: Responsive.size(context, 15),
                  offset: Offset(0, Responsive.size(context, 5)),
                ),
              ],
            ),
            child: BackgroundImageWidget(
              imageUrl:
                  'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80',
              overlayColor: Theme.of(context).colorScheme.primary,
              overlayOpacity: 0.7,
              child: Padding(
                padding: EdgeInsets.all(Responsive.spacing(context, 20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Special Offers',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 20),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 8)),
                    Text(
                      'Get 20% off on your first consultation',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 16)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.spacing(context, 16),
                        vertical: Responsive.spacing(context, 8),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          Responsive.size(context, 20),
                        ),
                      ),
                      child: Text(
                        'Claim Now',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Section title for doctors
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Doctors',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Doctors list with modern cards
        SliverToBoxAdapter(
          child: SizedBox(
            height: Responsive.size(context, 220),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.spacing(context, AppConstants.spacingMd),
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorProfileScreen(),
                        // builder: (context) => EnhancedDoctorProfileScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: Responsive.size(context, 160),
                    margin: EdgeInsets.only(
                      right: Responsive.spacing(
                        context,
                        AppConstants.spacingSm,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Responsive.size(context, AppConstants.radiusLg),
                      ),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: Responsive.size(context, 10),
                          offset: Offset(0, Responsive.size(context, 2)),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Doctor image with online indicator
                        Stack(
                          children: [
                            Container(
                              height: Responsive.size(context, 100),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                color: Color(0xFFE3F2FD),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: Responsive.size(context, 50),
                                  color: Color(0xFF2196F3),
                                ),
                              ),
                            ),
                            Positioned(
                              right: Responsive.spacing(context, 10),
                              bottom: Responsive.spacing(context, 10),
                              child: Container(
                                width: Responsive.size(context, 12),
                                height: Responsive.size(context, 12),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.fromBorderSide(
                                    BorderSide(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                            Responsive.spacing(context, AppConstants.spacingSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/doctor_profile',
                                  );
                                },
                                child: Text(
                                  'Dr. John Smith',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.fontSize(context, 16),
                                  ),
                                ),
                              ),
                              SizedBox(height: Responsive.spacing(context, 4)),
                              Text(
                                'Cardiologist',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 12),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: Responsive.spacing(context, 8)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: Responsive.size(context, 16),
                                    color: Colors.amber,
                                  ),
                                  SizedBox(
                                    width: Responsive.spacing(context, 4),
                                  ),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(
                                        context,
                                        12,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$50',
                                    style: TextStyle(
                                      fontSize: Responsive.fontSize(
                                        context,
                                        14,
                                      ),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Popular specialties section
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Specialties',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                // Specialty chips with modern styling
                Wrap(
                  spacing: Responsive.spacing(context, AppConstants.spacingSm),
                  runSpacing: Responsive.spacing(
                    context,
                    AppConstants.spacingSm,
                  ),
                  children: [
                    _SpecialtyChipModern(
                      icon: Icons.favorite,
                      label: 'Cardiology',
                      color: const Color(0xFFE3F2FD),
                    ),
                    _SpecialtyChipModern(
                      icon: Icons.psychology,
                      label: 'Psychology',
                      color: const Color(0xFFF3E5F5),
                    ),
                    _SpecialtyChipModern(
                      icon: Icons.child_care,
                      label: 'Pediatrics',
                      color: const Color(0xFFE8F5E9),
                    ),
                    _SpecialtyChipModern(
                      icon: Icons.female,
                      label: 'Gynecology',
                      color: const Color(0xFFFFF3E0),
                    ),
                    _SpecialtyChipModern(
                      icon: Icons.accessibility_new,
                      label: 'Orthopedics',
                      color: const Color(0xFFFBE9E7),
                    ),
                    _SpecialtyChipModern(
                      icon: Icons.local_hospital,
                      label: 'Dermatology',
                      color: const Color(0xFFE0F2F1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Health articles section
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingMd),
              Responsive.spacing(context, AppConstants.spacingSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Articles',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                // Article cards
                Container(
                  height: Responsive.size(context, 120),
                  margin: EdgeInsets.only(
                    bottom: Responsive.spacing(context, AppConstants.spacingSm),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Responsive.size(context, AppConstants.radiusMd),
                    ),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: Responsive.size(context, 5),
                        offset: Offset(0, Responsive.size(context, 1)),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: Responsive.size(context, 80),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                          color: Color(0xFFE3F2FD),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.article,
                            size: Responsive.size(context, 30),
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      SizedBox(width: Responsive.spacing(context, 12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '10 Tips for Better Heart Health',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.fontSize(context, 14),
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 4)),
                            Text(
                              'Learn how to maintain a healthy heart with these simple tips...',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 12),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: Responsive.spacing(context, 8)),
                            Text(
                              '5 min read',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 10),
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Responsive.spacing(context, 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: Responsive.spacing(context, AppConstants.spacingXl),
          ),
        ),
      ],
    );
  }
}

class _ModernQuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ModernQuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Responsive.size(context, 70),
          height: Responsive.size(context, 70),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Responsive.size(context, 18)),
            color: color.withOpacity(0.1),
          ),
          child: IconButton(
            icon: Icon(icon, color: color, size: Responsive.size(context, 28)),
            onPressed: onTap,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 8)),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 12),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SpecialtyChipModern extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _SpecialtyChipModern({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.spacing(context, 12),
        vertical: Responsive.spacing(context, 8),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Responsive.size(context, 16), color: Colors.black54),
          SizedBox(width: Responsive.spacing(context, 6)),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 12),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
