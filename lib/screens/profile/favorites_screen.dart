import 'package:flutter/material.dart';
import '../../core/constants.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Doctors', 'Clinics', 'Hospitals'];
  
  // Sorting options
  String _sortBy = 'Name';
  bool _isGridView = true;
  
  // Sample data
  final List<SavedProvider> _savedDoctors = [
    SavedProvider(
      id: '1',
      name: 'Dr. Sarah Johnson',
      specialty: 'Cardiologist',
      rating: 4.8,
      reviews: 124,
      address: '123 Medical Center, New York, NY',
      distance: '2.5 km',
      image: Icons.person,
      isAvailable: true,
      nextAvailableSlot: 'Today, 3:30 PM',
      consultationFee: 150.00,
      isVerified: true,
    ),
    SavedProvider(
      id: '2',
      name: 'Dr. Michael Chen',
      specialty: 'General Physician',
      rating: 4.6,
      reviews: 89,
      address: '456 Health Plaza, Brooklyn, NY',
      distance: '1.8 km',
      image: Icons.person,
      isAvailable: true,
      nextAvailableSlot: 'Tomorrow, 10:00 AM',
      consultationFee: 120.00,
      isVerified: true,
    ),
    SavedProvider(
      id: '3',
      name: 'Dr. Emily Roberts',
      specialty: 'Dermatologist',
      rating: 4.9,
      reviews: 156,
      address: '789 Skin Care Center, Manhattan, NY',
      distance: '3.2 km',
      image: Icons.person,
      isAvailable: false,
      nextAvailableSlot: 'Next week',
      consultationFee: 200.00,
      isVerified: true,
    ),
    SavedProvider(
      id: '4',
      name: 'Dr. Robert Wilson',
      specialty: 'Pediatrician',
      rating: 4.7,
      reviews: 203,
      address: '321 Children\'s Hospital, Queens, NY',
      distance: '4.1 km',
      image: Icons.person,
      isAvailable: true,
      nextAvailableSlot: 'Today, 4:00 PM',
      consultationFee: 140.00,
      isVerified: false,
    ),
  ];
  
  final List<SavedProvider> _savedClinics = [
    SavedProvider(
      id: '5',
      name: 'City Medical Center',
      specialty: 'Multi-Specialty Clinic',
      rating: 4.5,
      reviews: 342,
      address: '100 Main Street, New York, NY',
      distance: '1.2 km',
      image: Icons.local_hospital,
      isAvailable: true,
      nextAvailableSlot: 'Today, 2:00 PM',
      consultationFee: 0.00,
      isVerified: true,
    ),
    SavedProvider(
      id: '6',
      name: 'Advanced Health Clinic',
      specialty: 'Specialized Care',
      rating: 4.3,
      reviews: 187,
      address: '200 Healthcare Blvd, Brooklyn, NY',
      distance: '2.7 km',
      image: Icons.local_hospital,
      isAvailable: true,
      nextAvailableSlot: 'Today, 5:30 PM',
      consultationFee: 0.00,
      isVerified: true,
    ),
  ];
  
  final List<SavedProvider> _savedHospitals = [
    SavedProvider(
      id: '7',
      name: 'Metropolitan General Hospital',
      specialty: 'Full Service Hospital',
      rating: 4.4,
      reviews: 876,
      address: '500 Hospital Drive, Manhattan, NY',
      distance: '3.8 km',
      image: Icons.local_hospital,
      isAvailable: true,
      nextAvailableSlot: '24/7',
      consultationFee: 0.00,
      isVerified: true,
    ),
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

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort By',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              ...['Name', 'Rating', 'Distance', 'Availability'].map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _sortBy,
                  onChanged: (value) {
                    setState(() {
                      _sortBy = value!;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  void _removeFavorite(SavedProvider provider) {
    setState(() {
      if (_tabController.index == 0) {
        _savedDoctors.remove(provider);
      } else if (_tabController.index == 1) {
        _savedClinics.remove(provider);
      } else {
        _savedHospitals.remove(provider);
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${provider.name} from favorites'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              if (_tabController.index == 0) {
                _savedDoctors.add(provider);
              } else if (_tabController.index == 1) {
                _savedClinics.add(provider);
              } else {
                _savedHospitals.add(provider);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: _toggleView,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
              vertical: AppConstants.spacingSm,
            ),
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((String name) => Tab(text: name)).toList(),
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMd,
              ),
            ),
          ),

          // Tab bar view
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProvidersList(_savedDoctors),
                _buildProvidersList(_savedClinics),
                _buildProvidersList(_savedHospitals),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvidersList(List<SavedProvider> providers) {
    if (providers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'No favorites yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              'Save your favorite providers to access them quickly',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingLg),
            ElevatedButton(
              onPressed: () {
                // Navigate to search
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigate to search...')),
                );
              },
              child: const Text('Find Providers'),
            ),
          ],
        ),
      );
    }

    // Sort providers based on selected option
    List<SavedProvider> sortedProviders = List.from(providers);
    switch (_sortBy) {
      case 'Name':
        sortedProviders.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Rating':
        sortedProviders.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Distance':
        // For simplicity, we'll sort by name if distance is not numeric
        sortedProviders.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Availability':
        sortedProviders.sort((a, b) => (b.isAvailable ? 1 : 0).compareTo(a.isAvailable ? 1 : 0));
        break;
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh favorites
        await Future.delayed(const Duration(seconds: 1));
      },
      child: _isGridView
          ? _buildGridView(sortedProviders)
          : _buildListView(sortedProviders),
    );
  }

  Widget _buildGridView(List<SavedProvider> providers) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.spacingMd,
        mainAxisSpacing: AppConstants.spacingMd,
        childAspectRatio: 0.8,
      ),
      itemCount: providers.length,
      itemBuilder: (context, index) {
        return _buildProviderCard(providers[index], true);
      },
    );
  }

  Widget _buildListView(List<SavedProvider> providers) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      itemCount: providers.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
          child: _buildProviderCard(providers[index], false),
        );
      },
    );
  }

  Widget _buildProviderCard(SavedProvider provider, bool isGrid) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider header
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    provider.image,
                    color: Theme.of(context).primaryColor,
                    size: AppConstants.iconLg,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              provider.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (provider.isVerified)
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.spacingXs),
                      Text(
                        provider.specialty,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Provider details
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating and reviews
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: AppConstants.iconSm,
                    ),
                    const SizedBox(width: AppConstants.spacingXs),
                    Text(
                      provider.rating.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: AppConstants.spacingXs),
                    Text(
                      '(${provider.reviews} reviews)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacingSm,
                        vertical: AppConstants.spacingXs,
                      ),
                      decoration: BoxDecoration(
                        color: provider.isAvailable ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                      ),
                      child: Text(
                        provider.isAvailable ? 'Available' : 'Unavailable',
                        style: TextStyle(
                          color: provider.isAvailable ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.spacingSm),

                // Address and distance
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: AppConstants.iconSm,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: AppConstants.spacingXs),
                    Expanded(
                      child: Text(
                        provider.address,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingSm),
                    Text(
                      provider.distance,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.spacingSm),

                // Next available slot and fee
                if (provider.isAvailable) ...[
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: AppConstants.iconSm,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: AppConstants.spacingXs),
                      Text(
                        provider.nextAvailableSlot,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                      ),
                      const Spacer(),
                      if (provider.consultationFee > 0)
                        Text(
                          '\$${provider.consultationFee.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                ],

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => _removeFavorite(provider),
                    ),
                    if (provider.isAvailable)
                      ElevatedButton(
                        onPressed: () {
                          // Book appointment
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Booking appointment with ${provider.name}')),
                          );
                        },
                        child: const Text('Book Now'),
                      )
                    else
                      OutlinedButton(
                        onPressed: () {
                          // Set reminder
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Setting availability reminder...')),
                          );
                        },
                        child: const Text('Remind Me'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SavedProvider {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String address;
  final String distance;
  final IconData image;
  final bool isAvailable;
  final String nextAvailableSlot;
  final double consultationFee;
  final bool isVerified;

  SavedProvider({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.address,
    required this.distance,
    required this.image,
    required this.isAvailable,
    required this.nextAvailableSlot,
    required this.consultationFee,
    required this.isVerified,
  });
}