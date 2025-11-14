import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../core/responsive.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/network_image_widget.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;
  final List<String> _tabs = ['Overview', 'Reviews', 'Clinic Info', 'Articles', 'Q&A'];
  
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver app bar with doctor header
          SliverAppBar(
            expandedHeight: Responsive.size(context, 300),
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Doctor cover image with background image widget
                  BackgroundImageWidget(
                    imageUrl: 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80',
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
                      padding: EdgeInsets.all(Responsive.spacing(context, 20)),
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
                              NetworkImageWidget(
                                imageUrl: 'https://via.placeholder.com/150',
                                width: Responsive.size(context, 80),
                                height: Responsive.size(context, 80),
                                isCircle: true,
                              ),
                              SizedBox(width: Responsive.spacing(context, 16)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Dr. John Smith',
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(context, 24),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: Responsive.spacing(context, 8)),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Responsive.spacing(context, 8),
                                            vertical: Responsive.spacing(context, 4),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                                          ),
                                          child: Text(
                                            'Verified',
                                            style: TextStyle(
                                              fontSize: Responsive.fontSize(context, 12),
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Responsive.spacing(context, 4)),
                                    Text(
                                      'Cardiologist',
                                      style: TextStyle(
                                        fontSize: Responsive.fontSize(context, 16),
                                        color: Colors.white70,
                                      ),
                                    ),
                                    SizedBox(height: Responsive.spacing(context, 4)),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: Responsive.size(context, 16),
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: Responsive.spacing(context, 4)),
                                        Text(
                                          '4.8 (120 reviews)',
                                          style: TextStyle(
                                            fontSize: Responsive.fontSize(context, 14),
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
                                },
                              ),
                            ],
                          ),
                          
                          // Key info row
                          SizedBox(height: Responsive.spacing(context, 20)),
                          Container(
                            padding: EdgeInsets.all(Responsive.spacing(context, 12)),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _InfoItem(
                                  icon: Icons.work,
                                  label: '10 years',
                                  value: 'Experience',
                                ),
                                _InfoItem(
                                  icon: Icons.language,
                                  label: 'English, Hindi',
                                  value: 'Languages',
                                ),
                                _InfoItem(
                                  icon: Icons.attach_money,
                                  label: '\$50/\$30',
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
                tabs: _tabs.map((tab) => Tab(
                  text: tab,
                  height: Responsive.size(context, 48),
                )).toList(),
              ),
            ),
            pinned: true,
          ),
          
          // Tab content - Fixed the sliver geometry issue
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 
                      kToolbarHeight - 
                      MediaQuery.of(context).padding.top -
                      Responsive.size(context, 48), // Tab bar height
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Overview tab
                  _OverviewTab(),
                  
                  // Reviews tab
                  _ReviewsTab(),
                  
                  // Clinic Info tab
                  _ClinicInfoTab(),
                  
                  // Articles tab
                  _ArticlesTab(),
                  
                  // Q&A tab
                  _QATab(),
                ],
              ),
            ),
          ),
        ],
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
                    borderRadius: BorderRadius.circular(Responsive.size(context, 16)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 16)),
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
                borderRadius: BorderRadius.circular(Responsive.size(context, 25)),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
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
        Icon(icon, 
          size: Responsive.size(context, 20), 
          color: Colors.white),
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
  @override
  Widget build(BuildContext context) {
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
            'Dr. John Smith is a renowned cardiologist with over 10 years of experience in treating heart conditions. He specializes in preventive cardiology and has helped thousands of patients maintain healthy hearts.',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              height: 1.5,
            ),
          ),
          
          SizedBox(height: Responsive.spacing(context, 24)),
          
          // Education
          Text(
            'Education & Experience',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          _ExperienceItem(
            title: 'MD in Cardiology',
            institution: 'Harvard Medical School',
            year: '2010-2014',
          ),
          _ExperienceItem(
            title: 'Residency in Internal Medicine',
            institution: 'Johns Hopkins Hospital',
            year: '2008-2010',
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
            child: Column(
              children: [
                _SlotItem(
                  time: 'Tomorrow, 10:00 AM',
                  type: 'In-Clinic',
                  available: true,
                ),
                Divider(),
                _SlotItem(
                  time: 'Tomorrow, 2:00 PM',
                  type: 'Video Consult',
                  available: true,
                ),
                Divider(),
                _SlotItem(
                  time: 'Day after tomorrow, 11:00 AM',
                  type: 'In-Clinic',
                  available: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
  final String time;
  final String type;
  final bool available;
  
  const _SlotItem({
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
              time,
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
              vertical: Responsive.spacing(context, 6)
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
              vertical: Responsive.spacing(context, 6)
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
  @override
  Widget build(BuildContext context) {
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
                  '4.8',
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
                      index < 4 ? Icons.star : Icons.star_half,
                      color: Colors.amber,
                      size: Responsive.size(context, 24),
                    );
                  }),
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Text(
                  'Based on 120 reviews',
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
                label: Text('Most Helpful', 
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                  )
                ),
                selected: true,
                onSelected: (selected) {},
                selectedColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).cardColor,
              ),
              SizedBox(width: Responsive.spacing(context, 8)),
              FilterChip(
                label: Text('Latest',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                  )
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
          _ReviewItem(
            name: 'Sarah Johnson',
            rating: 5,
            date: '2 days ago',
            comment: 'Dr. Smith was very professional and took the time to explain everything clearly. Highly recommend!',
          ),
          SizedBox(height: Responsive.spacing(context, 16)),
          _ReviewItem(
            name: 'Michael Brown',
            rating: 4,
            date: '1 week ago',
            comment: 'Great experience overall. The clinic was clean and the staff was friendly.',
          ),
        ],
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final String name;
  final int rating;
  final String date;
  final String comment;
  
  const _ReviewItem({
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
  });

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
              Text(
                name,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
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
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: Responsive.size(context, 16),
              );
            }),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            comment,
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

class _ClinicInfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'City Heart Clinic',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 20),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Text(
            '123 Medical Street, Health District',
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
              icon: Icon(Icons.directions,
                size: Responsive.size(context, 20),
              ),
              label: Text('Get Directions',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                ),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                ),
              ),
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
            children: [
              _InsuranceChip(name: 'Blue Cross'),
              _InsuranceChip(name: 'Aetna'),
              _InsuranceChip(name: 'Cigna'),
              _InsuranceChip(name: 'UnitedHealth'),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsuranceChip extends StatelessWidget {
  final String name;
  
  const _InsuranceChip({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.spacing(context, 12), 
        vertical: Responsive.spacing(context, 8)
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: Responsive.fontSize(context, 14),
        ),
      ),
    );
  }
}

class _ArticlesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      child: Column(
        children: [
          _ArticleItem(
            title: 'Understanding Heart Health',
            author: 'Dr. John Smith',
            readTime: '5 min read',
            date: '2 days ago',
          ),
          SizedBox(height: Responsive.spacing(context, 16)),
          _ArticleItem(
            title: 'Preventing Cardiovascular Diseases',
            author: 'Dr. John Smith',
            readTime: '8 min read',
            date: '1 week ago',
          ),
        ],
      ),
    );
  }
}

class _ArticleItem extends StatelessWidget {
  final String title;
  final String author;
  final String readTime;
  final String date;
  
  const _ArticleItem({
    required this.title,
    required this.author,
    required this.readTime,
    required this.date,
  });

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
          Container(
            height: Responsive.size(context, 120),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Responsive.size(context, 8)),
            ),
            child: Center(
              child: Icon(
                Icons.article,
                size: Responsive.size(context, 40),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                author,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                '$readTime • $date',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 12),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QATab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _QAItem(
            question: 'What should I do before my appointment?',
            answer: 'Please bring your ID, insurance card, and any relevant medical records. Arrive 15 minutes early to complete paperwork.',
          ),
          const SizedBox(height: 16),
          _QAItem(
            question: 'Do you accept walk-ins?',
            answer: 'We recommend scheduling an appointment in advance, but walk-ins are welcome during regular hours.',
          ),
        ],
      ),
    );
  }
}

class _QAItem extends StatelessWidget {
  final String question;
  final String answer;
  
  const _QAItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
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
  
  final List<String> _dates = [
    'Today',
    'Tomorrow',
    'Day after tomorrow',
  ];
  
  final List<Map<String, String>> _times = [
    {'time': '10:00 AM', 'type': 'In-Clinic'},
    {'time': '11:00 AM', 'type': 'Video Consult'},
    {'time': '2:00 PM', 'type': 'In-Clinic'},
    {'time': '4:00 PM', 'type': 'Video Consult'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF2196F3),
                    ),
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
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _times.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_times[index]['time']!),
                        Text(
                          _times[index]['type']!,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                ),
                SizedBox(width: 12),
                Column(
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
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
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
    );
  }
}