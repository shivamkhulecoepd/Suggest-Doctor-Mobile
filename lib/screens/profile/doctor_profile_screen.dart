import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:suggest_doctor/core/constants.dart';
import '../../core/responsive.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/network_image_widget.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;
  final List<String> _tabs = [
    'Overview',
    'Reviews',
    'Services',
    'Clinic Info',
    'Articles',
    'Q&A',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final DoctorProfileData _doctorData = DoctorProfileData(
    name: 'Dr. Sarah Johnson',
    specialty: 'Cardiologist',
    experience: 12,
    rating: 4.8,
    reviewCount: 124,
    about:
        'Dr. Sarah Johnson is a renowned cardiologist with over 12 years of experience in treating heart conditions. She specializes in preventive cardiology and has helped thousands of patients maintain healthy hearts. Dr. Johnson is known for her compassionate approach and clear communication with patients.',
    languages: ['English', 'Hindi', 'Spanish'],
    education: [
      Education(
        degree: 'MD in Cardiology',
        institution: 'Harvard Medical School',
        year: '2010-2014',
      ),
      Education(
        degree: 'Residency in Internal Medicine',
        institution: 'Johns Hopkins Hospital',
        year: '2008-2010',
      ),
      Education(
        degree: 'MBBS',
        institution: 'Stanford University',
        year: '2004-2008',
      ),
    ],
    certifications: [
      'American Board of Cardiology',
      'Fellow of the American College of Cardiology',
      'European Society of Cardiology',
    ],
    services: [
      'Heart Health Checkup',
      'Echocardiogram',
      'Stress Test',
      'Cardiac Rehabilitation',
      'Hypertension Management',
      'Cholesterol Management',
    ],
    availability: [
      AvailabilitySlot(
        date: 'Today',
        time: '3:30 PM - 5:00 PM',
        type: 'In-Clinic',
        available: true,
      ),
      AvailabilitySlot(
        date: 'Tomorrow',
        time: '10:00 AM - 12:00 PM',
        type: 'Video Consult',
        available: true,
      ),
      AvailabilitySlot(
        date: 'Tomorrow',
        time: '2:00 PM - 4:00 PM',
        type: 'In-Clinic',
        available: false,
      ),
      AvailabilitySlot(
        date: 'Day after tomorrow',
        time: '11:00 AM - 1:00 PM',
        type: 'Video Consult',
        available: true,
      ),
    ],
    reviews: [
      Review(
        name: 'John Smith',
        rating: 5,
        date: '2 days ago',
        comment:
            'Dr. Johnson was very professional and took the time to explain everything clearly. Highly recommend!',
        avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      Review(
        name: 'Emily Davis',
        rating: 4,
        date: '1 week ago',
        comment:
            'Great experience overall. The clinic was clean and the staff was friendly. Dr. Johnson made me feel comfortable.',
        avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
      ),
      Review(
        name: 'Michael Brown',
        rating: 5,
        date: '2 weeks ago',
        comment:
            'Excellent doctor! She diagnosed my condition quickly and provided an effective treatment plan.',
        avatar: 'https://randomuser.me/api/portraits/men/65.jpg',
      ),
    ],
    articles: [
      Article(
        title: 'Understanding Heart Health',
        author: 'Dr. Sarah Johnson',
        readTime: '5 min read',
        date: '2 days ago',
        image:
            'https://images.unsplash.com/photo-1576091160550-2173dba999ef?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      ),
      Article(
        title: 'Preventing Cardiovascular Diseases',
        author: 'Dr. Sarah Johnson',
        readTime: '8 min read',
        date: '1 week ago',
        image:
            'https://images.unsplash.com/photo-1581091226033-d5c48150dbaa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      ),
    ],
    clinic: ClinicInfo(
      name: 'City Heart Clinic',
      address: '123 Medical Street, Health District, New York, NY 10001',
      phone: '+1 (555) 123-4567',
      email: 'info@cityheartclinic.com',
      timings: 'Mon-Fri: 9:00 AM - 6:00 PM, Sat: 10:00 AM - 2:00 PM',
      insurance: ['Blue Cross', 'Aetna', 'Cigna', 'UnitedHealth'],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // Sliver app bar with doctor header
            SliverAppBar(
              expandedHeight: Responsive.size(context, 320),
              pinned: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    // Doctor cover image with background image widget
                    BackgroundImageWidget(
                      imageUrl:
                          'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80',
                      overlayColor: Colors.black,
                      overlayOpacity: 0.7,
                      child: Container(),
                    ),
                    // Doctor info overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(
                          Responsive.spacing(context, 20),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Doctor image and verification
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    NetworkImageWidget(
                                      imageUrl:
                                          'https://images.unsplash.com/photo-1659353887233-05d1180eb691?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
                                      width: Responsive.size(context, 80),
                                      height: Responsive.size(context, 80),
                                      isCircle: true,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          Responsive.spacing(context, 4),
                                        ),
                                        decoration: BoxDecoration(
                                          color: LightColors.success,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: Responsive.spacing(context, 16),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _doctorData.name,
                                              style: TextStyle(
                                                fontSize: Responsive.fontSize(
                                                  context,
                                                  24,
                                                ),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Responsive.spacing(
                                                context,
                                                8,
                                              ),
                                              vertical: Responsive.spacing(
                                                context,
                                                4,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: LightColors.success,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    Responsive.size(
                                                      context,
                                                      12,
                                                    ),
                                                  ),
                                            ),
                                            child: Text(
                                              'Verified',
                                              style: TextStyle(
                                                fontSize: Responsive.fontSize(
                                                  context,
                                                  12,
                                                ),
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Responsive.spacing(context, 4),
                                      ),
                                      Text(
                                        _doctorData.specialty,
                                        style: TextStyle(
                                          fontSize: Responsive.fontSize(
                                            context,
                                            16,
                                          ),
                                          color: Colors.white70,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Responsive.spacing(context, 4),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: Responsive.size(context, 16),
                                            color: Colors.amber,
                                          ),
                                          SizedBox(
                                            width: Responsive.spacing(
                                              context,
                                              4,
                                            ),
                                          ),
                                          Text(
                                            '${_doctorData.rating} (${_doctorData.reviewCount} reviews)',
                                            style: TextStyle(
                                              fontSize: Responsive.fontSize(
                                                context,
                                                14,
                                              ),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.bookmark_border,
                                    color: Colors.white,
                                    size: Responsive.size(context, 24),
                                  ),
                                  onPressed: () {
                                    // Save to favorites
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Added to favorites successfully',
                                        ),
                                        backgroundColor: LightColors.success,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            // Key info row
                            SizedBox(height: Responsive.spacing(context, 20)),
                            Container(
                              padding: EdgeInsets.all(
                                Responsive.spacing(context, 12),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                  Responsive.size(context, 12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _InfoItem(
                                    icon: Icons.work,
                                    label: '${_doctorData.experience} years',
                                    value: 'Experience',
                                  ),
                                  _InfoItem(
                                    icon: Icons.language,
                                    label: _doctorData.languages.length > 1
                                        ? '${_doctorData.languages[0]}, ${_doctorData.languages[1]}'
                                        : _doctorData.languages[0],
                                    value: 'Languages',
                                  ),
                                  _InfoItem(
                                    icon: Icons.attach_money,
                                    label: '\$80/\$50',
                                    value: 'Fees',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tab bar
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  indicatorWeight: Responsive.size(context, 3),
                  isScrollable: true,
                  tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Overview tab
            _OverviewTab(doctorData: _doctorData),
            // Reviews tab
            _ReviewsTab(reviews: _doctorData.reviews),
            // Services tab
            _ServicesTab(services: _doctorData.services),
            // Clinic Info tab
            _ClinicInfoTab(clinic: _doctorData.clinic),
            // Articles tab
            _ArticlesTab(articles: _doctorData.articles),
            // Q&A tab
            _QATab(),
          ],
        ),
      ),

      // Booking button at bottom
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Responsive.spacing(context, 16)),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: Responsive.size(context, 10),
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Show booking bottom sheet
                  _showBookingBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Responsive.size(context, 16),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: Responsive.spacing(context, 16),
                  ),
                ),
                child: Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: Responsive.spacing(context, 12)),
            Container(
              width: Responsive.size(context, 50),
              height: Responsive.size(context, 50),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  Responsive.size(context, 25),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.video_call,
                  color: Theme.of(context).colorScheme.primary,
                  size: Responsive.size(context, 24),
                ),
                onPressed: () {
                  // Video consultation
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const _BookingBottomSheet();
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: _tabBar.preferredSize.height,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: Responsive.size(context, 20), color: Colors.white),
        SizedBox(height: Responsive.spacing(context, 4)),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 12),
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

// Tab content widgets
class _OverviewTab extends StatelessWidget {
  final DoctorProfileData doctorData;

  const _OverviewTab({required this.doctorData});

  @override
  Widget build(BuildContext context) {
    List<Widget> slotWidgets = doctorData.availability
        .map<Widget>(
          (slot) => _SlotItem(
            date: slot.date,
            time: slot.time,
            type: slot.type,
            available: slot.available,
          ),
        )
        .toList();
    slotWidgets.insertBetween(
      Divider(
        height: Responsive.spacing(context, 16),
        thickness: 0.5,
        color: Theme.of(context).dividerColor,
      ),
    );
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About section
          Text(
            'About',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Text(
            doctorData.about,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              height: 1.5,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 24)),
          // Education & Certifications
          Text(
            'Education & Certifications',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          ...doctorData.education.map(
            (edu) => _ExperienceItem(
              title: edu.degree,
              institution: edu.institution,
              year: edu.year,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 16)),
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Certifications',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                ...doctorData.certifications.map(
                  (cert) => Padding(
                    padding: EdgeInsets.only(
                      bottom: Responsive.spacing(context, 8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified,
                          size: Responsive.size(context, 16),
                          color: LightColors.success,
                        ),
                        SizedBox(width: Responsive.spacing(context, 8)),
                        Text(
                          cert,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 24)),
          // Availability
          Text(
            'Next Available Slots',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: Responsive.size(context, 5),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(children: slotWidgets),
          ),
          SizedBox(height: Responsive.spacing(context, 24)),
          // Clinic Info
          Text(
            'Clinic Information',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: Responsive.size(context, 5),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorData.clinic.name,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: Responsive.size(context, 16),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Expanded(
                      child: Text(
                        doctorData.clinic.address,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: Responsive.size(context, 16),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Text(
                      doctorData.clinic.timings,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: Responsive.size(context, 16),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Text(
                      doctorData.clinic.phone,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: Responsive.size(context, 16),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Text(
                      doctorData.clinic.email,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                Text(
                  'Accepted Insurance',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Wrap(
                  spacing: Responsive.spacing(context, 8),
                  runSpacing: Responsive.spacing(context, 8),
                  children: doctorData.clinic.insurance
                      .map(
                        (insurance) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.spacing(context, 12),
                            vertical: Responsive.spacing(context, 6),
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              Responsive.size(context, 20),
                            ),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            insurance,
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 12),
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on List<Widget> {
  void insertBetween(Widget widget) {
    for (int i = length - 1; i > 0; i--) {
      insert(i, widget);
    }
  }
}

class _ExperienceItem extends StatelessWidget {
  final String title;
  final String institution;
  final String year;

  const _ExperienceItem({
    required this.title,
    required this.institution,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Responsive.size(context, 8),
            height: Responsive.size(context, 8),
            margin: EdgeInsets.only(top: Responsive.spacing(context, 8)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: Responsive.spacing(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 4)),
                Text(
                  institution,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 4)),
                Text(
                  year,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: Theme.of(context).colorScheme.secondary,
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

class _SlotItem extends StatelessWidget {
  final String date;
  final String time;
  final String type;
  final bool available;

  const _SlotItem({
    required this.date,
    required this.time,
    required this.type,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$date, $time',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.spacing(context, 4)),
            Text(
              type,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        if (available)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacing(context, 12),
              vertical: Responsive.spacing(context, 6),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
            ),
            child: Text(
              'Book',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        else
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacing(context, 12),
              vertical: Responsive.spacing(context, 6),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
            ),
            child: Text(
              'Fully Booked',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  final List<Review> reviews;

  const _ReviewsTab({required this.reviews});

  @override
  Widget build(BuildContext context) {
    // Calculate average rating
    double averageRating =
        reviews.fold(0.0, (sum, review) => sum + review.rating) /
        reviews.length;
    List<Widget> reviewWidgets = reviews
        .map<Widget>((review) => _ReviewItem(review: review))
        .toList();
    reviewWidgets.insertBetween(
      SizedBox(height: Responsive.spacing(context, 16)),
    );
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating summary
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: Responsive.size(context, 5),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  averageRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < averageRating.floor()
                          ? Icons.star
                          : (index < averageRating.ceil()
                                ? Icons.star_half
                                : Icons.star_border),
                      color: Colors.amber,
                      size: Responsive.size(context, 24),
                    );
                  }),
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Text(
                  'Based on ${reviews.length} reviews',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 24)),
          // Review filters
          Row(
            children: [
              FilterChip(
                label: Text(
                  'Most Helpful',
                  style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                ),
                selected: true,
                onSelected: (selected) {},
                selectedColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).cardColor,
              ),
              SizedBox(width: Responsive.spacing(context, 8)),
              FilterChip(
                label: Text(
                  'Latest',
                  style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                ),
                selected: false,
                onSelected: (selected) {},
                selectedColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).cardColor,
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 24)),
          // Reviews list
          ...reviewWidgets,
        ],
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final Review review;

  const _ReviewItem({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Responsive.size(context, 5),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: Responsive.size(context, 16),
                    backgroundImage: NetworkImage(review.avatar),
                  ),
                  SizedBox(width: Responsive.spacing(context, 8)),
                  Text(
                    review.name,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                review.date,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < review.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: Responsive.size(context, 16),
              );
            }),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            review.comment,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesTab extends StatelessWidget {
  final List<String> services;

  const _ServicesTab({required this.services});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Offered',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Wrap(
            spacing: Responsive.spacing(context, 8),
            runSpacing: Responsive.spacing(context, 8),
            children: services
                .map(
                  (service) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.spacing(context, 12),
                      vertical: Responsive.spacing(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(
                        Responsive.size(context, 20),
                      ),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Text(
                      service,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ArticlesTab extends StatelessWidget {
  final List<Article> articles;

  const _ArticlesTab({required this.articles});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Articles',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          ...articles.map((article) => _ArticleItem(article: article)),
        ],
      ),
    );
  }
}

class _ArticleItem extends StatelessWidget {
  final Article article;

  const _ArticleItem({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Responsive.size(context, 5),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            article.author,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.readTime,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                article.date,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 16)),
          Container(
            height: Responsive.size(context, 200),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(article.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _QATab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        'question': 'What should I bring to my first appointment?',
        'answer':
            'Please bring your ID, insurance card, and any relevant medical records. Arrive 15 minutes early to complete paperwork.',
      },
      {
        'question': 'Do you accept walk-ins?',
        'answer':
            'We recommend scheduling an appointment in advance, but walk-ins are welcome during regular hours.',
      },
      {
        'question': 'How can I reschedule or cancel my appointment?',
        'answer':
            'You can reschedule or cancel your appointment through the app or by calling our clinic directly at least 24 hours in advance.',
      },
      {
        'question': 'What payment methods do you accept?',
        'answer':
            'We accept cash, credit cards, debit cards, and most major insurance plans.',
      },
      {
        'question': 'How long does a typical appointment last?',
        'answer':
            'Initial consultations typically last 30-45 minutes, while follow-up appointments are usually 15-30 minutes.',
      },
      {
        'question': 'Do you offer telemedicine consultations?',
        'answer':
            'Yes, we offer video consultations for follow-up appointments and certain initial consultations. Please check with our staff for availability.',
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 16)),
          ...faqs
              .map(
                (faq) => _FAQItem(
                  question: faq['question']!,
                  answer: faq['answer']!,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 12)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 16),
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicInfoTab extends StatelessWidget {
  final ClinicInfo clinic;

  const _ClinicInfoTab({required this.clinic});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            clinic.name,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 20),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            clinic.address,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: Colors.grey,
            ),
          ),

          SizedBox(height: Responsive.spacing(context, 24)),

          // Map placeholder with network image
          Container(
            height: Responsive.size(context, 200),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
            ),
            child: Center(
              child: Icon(
                Icons.map,
                size: Responsive.size(context, 50),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          SizedBox(height: Responsive.spacing(context, 24)),

          // Directions button
          SizedBox(
            width: double.infinity,
            height: Responsive.size(context, 50),
            child: OutlinedButton.icon(
              onPressed: () {
                // Open maps
              },
              icon: Icon(Icons.directions, size: Responsive.size(context, 20)),
              label: Text(
                'Get Directions',
                style: TextStyle(fontSize: Responsive.fontSize(context, 16)),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Responsive.size(context, 12),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: Responsive.spacing(context, 24)),

          // Contact information
          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: Responsive.size(context, 5),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: Responsive.size(context, 16),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Text(
                      'Timings',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Text(
                  clinic.timings,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: Responsive.size(context, 16),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Text(
                  clinic.phone,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: Responsive.size(context, 16),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Text(
                  clinic.email,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                ),
              ],
            ),
          ),

          SizedBox(height: Responsive.spacing(context, 24)),

          // Insurance info
          Text(
            'Accepted Insurance',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Wrap(
            spacing: Responsive.spacing(context, 8),
            runSpacing: Responsive.spacing(context, 8),
            children: clinic.insurance
                .map(
                  (insurance) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.spacing(context, 12),
                      vertical: Responsive.spacing(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(
                        Responsive.size(context, 20),
                      ),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Text(
                      insurance,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _QAItem extends StatelessWidget {
  final String question;
  final String answer;

  const _QAItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Responsive.size(context, 5),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            answer,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// Booking bottom sheet
class _BookingBottomSheet extends StatefulWidget {
  const _BookingBottomSheet();

  @override
  State<_BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<_BookingBottomSheet> {
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 0;

  final List<String> _dates = ['Today', 'Tomorrow', 'Day after tomorrow'];

  final List<Map<String, String>> _times = [
    {'time': '10:00 AM', 'type': 'In-Clinic'},
    {'time': '11:00 AM', 'type': 'Video Consult'},
    {'time': '2:00 PM', 'type': 'In-Clinic'},
    {'time': '4:00 PM', 'type': 'Video Consult'},
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Book Appointment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Doctor info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                          child: Icon(Icons.person, color: Color(0xFF2196F3)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. John Smith',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Cardiologist',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Date selection
                const Text(
                  'Select Date',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _dates.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(_dates[index]),
                          selected: _selectedDateIndex == index,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDateIndex = index;
                            });
                          },
                          selectedColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context).cardColor,
                          labelStyle: TextStyle(
                            color: _selectedDateIndex == index
                                ? Colors.white
                                : Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Time selection
                const Text(
                  'Select Time',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _times.length,
                    itemBuilder: (context, index) {
                      final timeMap = _times[index];
                      return Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(timeMap['time'] ?? ''),
                              Text(
                                timeMap['type'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          selected: _selectedTimeIndex == index,
                          onSelected: (selected) {
                            setState(() {
                              _selectedTimeIndex = index;
                            });
                          },
                          selectedColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context).cardColor,
                          labelStyle: TextStyle(
                            color: _selectedTimeIndex == index
                                ? Colors.white
                                : Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Patient info
                const Text(
                  'Patient Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '35 years, Male',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Book button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Proceed to booking
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Confirm Booking',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Data models
class DoctorProfileData {
  final String name;
  final String specialty;
  final int experience;
  final double rating;
  final int reviewCount;
  final String about;
  final List<String> languages;
  final List<Education> education;
  final List<String> certifications;
  final List<String> services;
  final List<AvailabilitySlot> availability;
  final List<Review> reviews;
  final List<Article> articles;
  final ClinicInfo clinic;

  DoctorProfileData({
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.reviewCount,
    required this.about,
    required this.languages,
    required this.education,
    required this.certifications,
    required this.services,
    required this.availability,
    required this.reviews,
    required this.articles,
    required this.clinic,
  });
}

class Education {
  final String degree;
  final String institution;
  final String year;

  Education({
    required this.degree,
    required this.institution,
    required this.year,
  });
}

class AvailabilitySlot {
  final String date;
  final String time;
  final String type;
  final bool available;

  AvailabilitySlot({
    required this.date,
    required this.time,
    required this.type,
    required this.available,
  });
}

class Review {
  final String name;
  final int rating;
  final String date;
  final String comment;
  final String avatar;

  Review({
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
    required this.avatar,
  });
}

class Article {
  final String title;
  final String author;
  final String readTime;
  final String date;
  final String image;

  Article({
    required this.title,
    required this.author,
    required this.readTime,
    required this.date,
    required this.image,
  });
}

class ClinicInfo {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String timings;
  final List<String> insurance;

  ClinicInfo({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.timings,
    required this.insurance,
  });
}
