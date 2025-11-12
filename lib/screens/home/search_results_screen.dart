import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import '../../widgets/network_image_widget.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;
  
  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String _selectedTab = 'All';
  final List<String> _tabs = ['All', 'Doctors', 'Clinics', 'Labs', 'Medicines'];
  
  // Sample search results data
  final List<Map<String, dynamic>> _allResults = [
    {
      'type': 'doctor',
      'name': 'Dr. John Smith',
      'specialty': 'Cardiologist',
      'rating': 4.8,
      'reviews': 120,
      'experience': '10 years',
      'fee': 50,
      'available': 'Tomorrow, 10:00 AM',
      'distance': '2.5 km',
    },
    {
      'type': 'clinic',
      'name': 'City Heart Clinic',
      'specialty': 'Cardiology',
      'rating': 4.5,
      'reviews': 85,
      'fee': 30,
      'available': 'Today, 2:00 PM',
      'distance': '1.2 km',
    },
    {
      'type': 'lab',
      'name': 'MediLab Diagnostics',
      'specialty': 'Pathology',
      'rating': 4.7,
      'reviews': 210,
      'fee': 25,
      'available': 'Open now',
      'distance': '0.8 km',
    },
    {
      'type': 'medicine',
      'name': 'Aspirin 100mg',
      'specialty': 'Pain Relief',
      'rating': 4.2,
      'reviews': 45,
      'fee': 5,
      'available': 'In stock',
      'distance': '',
    },
  ];

  List<Map<String, dynamic>> _filteredResults() {
    if (_selectedTab == 'All') {
      return _allResults;
    }
    
    return _allResults.where((item) {
      if (_selectedTab == 'Doctors' && item['type'] == 'doctor') return true;
      if (_selectedTab == 'Clinics' && item['type'] == 'clinic') return true;
      if (_selectedTab == 'Labs' && item['type'] == 'lab') return true;
      if (_selectedTab == 'Medicines' && item['type'] == 'medicine') return true;
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredResults();
    
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: Responsive.size(context, 40),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search doctors, clinics, specialties...',
              hintStyle: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
              ),
              prefixIcon: Icon(Icons.search, 
                size: Responsive.size(context, 20),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear, 
                  size: Responsive.size(context, 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: Responsive.spacing(context, 16)),
            ),
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
            ),
            onSubmitted: (value) {
              // Handle search
            },
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter row
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacing(context, 16), 
              vertical: Responsive.spacing(context, 8)
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.spacing(context, 12), 
                    vertical: Responsive.spacing(context, 8)
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
                  ),
                  child: Icon(Icons.filter_list, 
                    size: Responsive.size(context, 20),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 12)),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ..._tabs.map((tab) => Container(
                          margin: EdgeInsets.only(right: Responsive.spacing(context, 8)),
                          child: FilterChip(
                            label: Text(tab,
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 14),
                              ),
                            ),
                            selected: _selectedTab == tab,
                            onSelected: (selected) {
                              setState(() {
                                _selectedTab = tab;
                              });
                            },
                            selectedColor: Theme.of(context).colorScheme.primary,
                            backgroundColor: Theme.of(context).cardColor,
                            labelStyle: TextStyle(
                              color: _selectedTab == tab 
                                  ? Colors.white 
                                  : Theme.of(context).colorScheme.secondary,
                              fontSize: Responsive.fontSize(context, 14),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Results count
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacing(context, 16), 
              vertical: Responsive.spacing(context, 8)
            ),
            child: Text(
              '${results.length} results found',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          
          // Results list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: Responsive.spacing(context, 16)),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                return _SearchResultCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final Map<String, dynamic> item;
  
  const _SearchResultCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 16)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Responsive.size(context, 16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: Responsive.size(context, 5),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(Responsive.spacing(context, 16)),
        leading: NetworkImageWidget(
          imageUrl: 'https://via.placeholder.com/150',
          width: Responsive.size(context, 60),
          height: Responsive.size(context, 60),
          borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
        ),
        title: Text(
          item['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.fontSize(context, 16),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.spacing(context, 4)),
            Text(
              item['specialty'],
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: Responsive.spacing(context, 8)),
            Row(
              children: [
                Icon(Icons.star, 
                  size: Responsive.size(context, 16), 
                  color: Colors.amber
                ),
                SizedBox(width: Responsive.spacing(context, 4)),
                Text('${item['rating']}',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 8)),
                Text(
                  '(${item['reviews']} reviews)',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Spacer(),
                if (item['distance'].isNotEmpty)
                  Text(
                    item['distance'],
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
              ],
            ),
            SizedBox(height: Responsive.spacing(context, 8)),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.spacing(context, 8), 
                    vertical: Responsive.spacing(context, 4)
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                  ),
                  child: Text(
                    '\$${item['fee']}',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 12)),
                Text(
                  item['available'],
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.bookmark_border,
            size: Responsive.size(context, 24),
          ),
          onPressed: () {
            // Save to favorites
          },
        ),
        onTap: () {
          // Navigate to detail screen
        },
      ),
    );
  }
}