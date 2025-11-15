import 'package:flutter/material.dart';
import 'package:suggest_doctor/core/responsive.dart';
import 'package:suggest_doctor/models/medicine.dart';
import 'package:suggest_doctor/core/constants.dart';
import 'package:suggest_doctor/screens/ecommerce/medicine_detail_screen.dart';
import 'package:suggest_doctor/widgets/network_image_widget.dart';

class ShimmerLoading extends StatefulWidget {
  final double height;
  final BorderRadius borderRadius;

  const ShimmerLoading({
    Key? key,
    required this.height,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  }) : super(key: key);

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-2.4 + _controller.value * 3, -0.2),
              end: Alignment(0.4 + _controller.value * 3, 1.0),
              colors: [
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.0),
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: widget.borderRadius,
            ),
          ),
        );
      },
    );
  }
}

class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({super.key});

  @override
  State<MedicineListScreen> createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  // Sample medicine data with real images
  final List<Medicine> _allMedicines = [
    Medicine(
      id: '1',
      name: 'Paracetamol',
      brand: 'Dolo 650',
      manufacturer: 'Micro Labs',
      category: 'Pain Relief',
      dosageForm: 'Tablet',
      description:
          'Paracetamol is used to treat many conditions such as headache, muscle aches, arthritis, backache, toothaches, colds, and fevers.',
      composition: 'Paracetamol 650mg',
      price: 25.00,
      discountedPrice: 20.00,
      discountPercentage: 20,
      inStock: true,
      imageUrl:
          'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      rating: 4.5,
      reviewCount: 120,
      prescriptionRequired: false,
      tags: ['fever', 'headache', 'pain'],
    ),
    Medicine(
      id: '2',
      name: 'Ibuprofen',
      brand: 'Brufen',
      manufacturer: 'Abbott',
      category: 'Pain Relief',
      dosageForm: 'Tablet',
      description:
          'Ibuprofen is a nonsteroidal anti-inflammatory drug (NSAID). It works by reducing hormones that cause inflammation and pain in the body.',
      composition: 'Ibuprofen 400mg',
      price: 35.00,
      inStock: true,
      imageUrl:
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      rating: 4.2,
      reviewCount: 89,
      prescriptionRequired: false,
      tags: ['pain', 'inflammation', 'fever'],
    ),
    Medicine(
      id: '3',
      name: 'Metformin',
      brand: 'Glycomet',
      manufacturer: 'GlaxoSmithKline',
      category: 'Diabetes',
      dosageForm: 'Tablet',
      description:
          'Metformin is an oral diabetes medicine that helps control blood sugar levels.',
      composition: 'Metformin 500mg',
      price: 45.00,
      discountedPrice: 38.00,
      discountPercentage: 15,
      inStock: true,
      imageUrl:
          'https://media.istockphoto.com/id/472120679/photo/metformin.jpg?s=612x612&w=0&k=20&c=1BzRBjagCoJh_eDm6rjZQ7iQo9k1TRD4QgB__nGpPV0=',
      rating: 4.7,
      reviewCount: 210,
      prescriptionRequired: true,
      tags: ['diabetes', 'blood sugar'],
    ),
    Medicine(
      id: '4',
      name: 'Amoxicillin',
      brand: 'Amoxil',
      manufacturer: 'Glenmark',
      category: 'Antibiotics',
      dosageForm: 'Capsule',
      description:
          'Amoxicillin is used to treat many different types of infection caused by bacteria, such as tonsillitis, bronchitis, pneumonia, and infections of the ear, nose, throat, skin, or urinary tract.',
      composition: 'Amoxicillin 500mg',
      price: 55.00,
      inStock: false,
      imageUrl:
          'https://www.scabpharmacy.com/wp-content/uploads/2024/10/Amoxicillin-500mg-caps-3-scaled.jpg',
      rating: 4.0,
      reviewCount: 76,
      prescriptionRequired: true,
      tags: ['infection', 'antibiotic'],
    ),
    Medicine(
      id: '5',
      name: 'Omeprazole',
      brand: 'Prilosec',
      manufacturer: 'AstraZeneca',
      category: 'Digestive Health',
      dosageForm: 'Capsule',
      description:
          'Omeprazole is used to treat certain stomach and esophagus problems (such as acid reflux, ulcers).',
      composition: 'Omeprazole 20mg',
      price: 65.00,
      discountedPrice: 55.00,
      discountPercentage: 15,
      inStock: true,
      imageUrl:
          'https://5.imimg.com/data5/SELLER/Default/2023/8/333617770/HU/CV/CM/65567988/omeprazole-40mg-tablet.jpg',
      rating: 4.3,
      reviewCount: 142,
      prescriptionRequired: true,
      tags: ['acid reflux', 'ulcer', 'stomach'],
    ),
    Medicine(
      id: '6',
      name: 'Cetirizine',
      brand: 'Zyrtec',
      manufacturer: 'Pfizer',
      category: 'Allergy',
      dosageForm: 'Tablet',
      description:
          'Cetirizine is an antihistamine used to relieve allergy symptoms such as watery eyes, runny nose, itching eyes/nose, sneezing, hives, and itching.',
      composition: 'Cetirizine 10mg',
      price: 30.00,
      inStock: true,
      imageUrl:
          'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      rating: 4.6,
      reviewCount: 98,
      prescriptionRequired: false,
      tags: ['allergy', 'cold', 'sneezing'],
    ),
  ];
  List<Medicine> _filteredMedicines = [];
  List<String> _categories = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _showOutOfStock = true;

  @override
  void initState() {
    super.initState();
    _filteredMedicines = List.from(_allMedicines);
    _extractCategories();
  }

  void _extractCategories() {
    Set<String> categorySet = {};
    for (var medicine in _allMedicines) {
      categorySet.add(medicine.category);
    }
    _categories = ['All', ...categorySet.toList()..sort()];
  }

  void _filterMedicines() {
    setState(() {
      _filteredMedicines = _allMedicines.where((medicine) {
        // Category filter
        bool categoryMatch =
            _selectedCategory == 'All' ||
            medicine.category == _selectedCategory;
        // Search filter
        bool searchMatch =
            _searchQuery.isEmpty ||
            medicine.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            medicine.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            medicine.tags.any(
              (tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()),
            );
        // Stock filter
        bool stockMatch = _showOutOfStock || medicine.inStock;
        return categoryMatch && searchMatch && stockMatch;
      }).toList();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _filterMedicines();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filterMedicines();
    });
  }

  void _toggleStockFilter(bool value) {
    setState(() {
      _showOutOfStock = value;
      _filterMedicines();
    });
  }

  Future<void> _refreshMedicines() async {
    // Simulate refreshing medicines
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // In a real app, this would fetch updated data
    });
  }

  Widget _buildEmptyState(double screenWidth) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final double padding = screenWidth < 400 ? 24.0 : 32.0;
    final double iconSize = screenWidth < 400 ? 40.0 : 48.0;
    final double buttonPaddingH = screenWidth < 400 ? 24.0 : 32.0;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth < 400 ? 64.0 : 80.0,
              height: screenWidth < 400 ? 64.0 : 80.0,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(
                  screenWidth < 400 ? 16.0 : 20.0,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.search_off,
                  color: colorScheme.primary,
                  size: iconSize,
                ),
              ),
            ),
            SizedBox(height: screenWidth < 400 ? 24.0 : 32.0),
            Text(
              'No medicines found',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
                fontSize: screenWidth < 400 ? 18.0 : 22.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Try adjusting your search or filter',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.5,
                fontSize: screenWidth < 400 ? 14.0 : 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenWidth < 400 ? 24.0 : 32.0),
            ElevatedButton(
              onPressed: () {
                _onSearchChanged('');
                _onCategorySelected('All');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: buttonPaddingH,
                  vertical: screenWidth < 400 ? 12.0 : 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    screenWidth < 400 ? 8.0 : 12.0,
                  ),
                ),
              ),
              child: Text(
                'Clear Filters',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth < 400 ? 14.0 : 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Responsive breakpoints
    final bool isNarrowScreen = screenWidth < 350;
    final bool isExtraNarrow = screenWidth < 300;
    final bool isTablet = screenWidth >= 600;
    final double horizontalPadding = isNarrowScreen
        ? 12.0
        : (isTablet ? 24.0 : 16.0);
    final double verticalPadding = isNarrowScreen ? 8.0 : 12.0;
    final double fontSizeBase = isNarrowScreen
        ? 14.0
        : (isTablet ? 18.0 : 16.0);
    final double iconSizeBase = isNarrowScreen
        ? 20.0
        : (isTablet ? 28.0 : 24.0);
    final double chipPaddingH = isNarrowScreen ? 8.0 : (isTablet ? 16.0 : 12.0);
    final double chipPaddingV = isNarrowScreen ? 4.0 : (isTablet ? 8.0 : 6.0);
    final double chipFontSize = isNarrowScreen
        ? 12.0
        : (isTablet ? 16.0 : 14.0);
    final double borderRadius = isNarrowScreen ? 8.0 : (isTablet ? 16.0 : 12.0);

    // Grid configuration
    final int crossAxisCount = screenWidth < 300
        ? 1
        : screenWidth < 600
        ? 2
        : screenWidth < 900
        ? 3
        : 4;
    final double childAspectRatio = crossAxisCount == 1
        ? 0.65
        : crossAxisCount == 2
        ? 0.75
        : crossAxisCount == 3
        ? 0.85
        : 0.95;
    final double gridSpacing = isNarrowScreen
        ? 8.0
        : (crossAxisCount > 2 ? 12.0 : 16.0);
    final double cardWidthApprox =
        (screenWidth -
            2 * horizontalPadding -
            (crossAxisCount - 1) * gridSpacing) /
        crossAxisCount;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Browse Medicines',
          style: TextStyle(
            fontSize: isNarrowScreen ? 18.0 : (isTablet ? 24.0 : 20.0),
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(isNarrowScreen ? 6.0 : 8.0),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                color: colorScheme.primary,
                size: iconSizeBase,
              ),
            ),
            onPressed: () {
              // Navigate to wishlist screen
              Navigator.pushNamed(context, '/wishlist');
            },
            tooltip: 'Wishlist',
          ),
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(isNarrowScreen ? 6.0 : 8.0),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history,
                color: colorScheme.primary,
                size: iconSizeBase,
              ),
            ),
            onPressed: () {
              // Navigate to recently viewed screen
              Navigator.pushNamed(context, '/recently_viewed');
            },
            tooltip: 'Recently Viewed',
          ),
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(isNarrowScreen ? 6.0 : 8.0),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart,
                color: colorScheme.primary,
                size: iconSizeBase,
              ),
            ),
            onPressed: () {
              // Navigate to cart screen
              Navigator.pushNamed(context, '/cart');
            },
            tooltip: 'Cart',
          ),
          SizedBox(width: isNarrowScreen ? 8.0 : 16.0),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            margin: EdgeInsets.all(horizontalPadding),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: isNarrowScreen ? 4.0 : 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: isNarrowScreen
                    ? 'Search medicines...'
                    : isTablet
                    ? 'Search medicines, brands, categories...'
                    : 'Search medicines, brands...',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                  fontSize: isNarrowScreen ? 13.0 : fontSizeBase,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colorScheme.primary,
                  size: isNarrowScreen ? 18.0 : iconSizeBase,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                          size: isNarrowScreen ? 18.0 : iconSizeBase,
                        ),
                        onPressed: () {
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isNarrowScreen ? 12.0 : horizontalPadding,
                  vertical: isNarrowScreen ? 10.0 : verticalPadding,
                ),
              ),
              style: TextStyle(fontSize: isNarrowScreen ? 13.0 : fontSizeBase),
              onChanged: _onSearchChanged,
            ),
          ),
          // Filters
          Container(
            margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _categories.map((category) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: isNarrowScreen
                                ? 4.0
                                : (isTablet ? 12.0 : 8.0),
                          ),
                          child: FilterChip(
                            label: Text(
                              category,
                              style: TextStyle(
                                fontWeight: _selectedCategory == category
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                fontSize: chipFontSize,
                              ),
                            ),
                            selected: _selectedCategory == category,
                            onSelected: (selected) {
                              _onCategorySelected(selected ? category : 'All');
                            },
                            selectedColor: colorScheme.primary,
                            backgroundColor: colorScheme.surface,
                            labelStyle: TextStyle(
                              color: _selectedCategory == category
                                  ? Colors.white
                                  : colorScheme.onSurface,
                              fontSize: chipFontSize,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: chipPaddingH,
                              vertical: chipPaddingV,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: isNarrowScreen ? 4.0 : (isTablet ? 12.0 : 8.0),
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.filter_list,
                      color: colorScheme.primary,
                      size: isNarrowScreen ? 18.0 : iconSizeBase,
                    ),
                    onSelected: (value) {
                      if (value == 'stock') {
                        _toggleStockFilter(!_showOutOfStock);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        CheckedPopupMenuItem(
                          checked: _showOutOfStock,
                          value: 'stock',
                          child: Text(
                            'Show out of stock',
                            style: TextStyle(
                              fontSize: isNarrowScreen ? 11.0 : chipFontSize,
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: verticalPadding * 2),
          // Medicine list
          Expanded(
            child: _filteredMedicines.isEmpty
                ? _buildEmptyState(screenWidth)
                : RefreshIndicator(
                    onRefresh: _refreshMedicines,
                    color: colorScheme.primary,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                        crossAxisSpacing: gridSpacing,
                        mainAxisSpacing: gridSpacing,
                      ),
                      itemCount: _filteredMedicines.length,
                      itemBuilder: (context, index) {
                        return _buildMedicineCard(
                          _filteredMedicines[index],
                          cardWidthApprox,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(Medicine medicine, double cardWidth) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isCompact = cardWidth < 150;
    final bool isExtraCompact = cardWidth < 120;
    final double imageHeight = isCompact
        ? 70.0
        : (cardWidth < 200 ? 100.0 : 120.0);
    final double cardPadding = isCompact
        ? 6.0
        : (cardWidth < 200 ? 10.0 : 12.0);
    final double fontSizeTitle = isExtraCompact
        ? 11.0
        : isCompact
        ? 13.0
        : (cardWidth < 200 ? 14.0 : 16.0);
    final double fontSizeBody = isExtraCompact
        ? 7.0
        : isCompact
        ? 9.0
        : (cardWidth < 200 ? 11.0 : 12.0);
    final double iconSizeSmall = isExtraCompact
        ? 8.0
        : isCompact
        ? 10.0
        : (cardWidth < 200 ? 11.0 : 12.0);
    final double buttonSize = isExtraCompact
        ? 22.0
        : isCompact
        ? 26.0
        : (cardWidth < 200 ? 28.0 : 32.0);
    final double badgeFontSize = isExtraCompact
        ? 7.0
        : isCompact
        ? 9.0
        : (cardWidth < 200 ? 10.0 : 12.0);
    final double stockPaddingH = isExtraCompact
        ? 3.0
        : isCompact
        ? 5.0
        : (cardWidth < 200 ? 6.0 : 8.0);
    final double stockPaddingV = isExtraCompact
        ? 1.0
        : isCompact
        ? 2.0
        : (cardWidth < 200 ? 3.0 : 4.0);
    final double ratingIconSize = isExtraCompact
        ? 9.0
        : isCompact
        ? 11.0
        : (cardWidth < 200 ? 12.0 : 14.0);
    final double ratingFontSize = isExtraCompact
        ? 7.0
        : isCompact
        ? 9.0
        : (cardWidth < 200 ? 10.0 : 12.0);
    final double spacingSmall = isExtraCompact ? 1.0 : (isCompact ? 2.0 : 4.0);
    final double borderRadiusCard = isCompact ? 12.0 : 16.0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicineDetailScreen(medicine: medicine),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadiusCard),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: isCompact ? 4.0 : 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medicine image with badge
            Stack(
              children: [
                Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusCard),
                      topRight: Radius.circular(borderRadiusCard),
                    ),
                    color: colorScheme.primary.withValues(alpha: 0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusCard),
                      topRight: Radius.circular(borderRadiusCard),
                    ),
                    child: Image.network(
                      medicine.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: imageHeight,
                        color: colorScheme.surfaceVariant,
                        child: Icon(Icons.medication, size: imageHeight * 0.4),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return ShimmerLoading(
                          height: imageHeight,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(borderRadiusCard),
                            topRight: Radius.circular(borderRadiusCard),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Prescription required badge
                if (medicine.prescriptionRequired)
                  Positioned(
                    top: 4.0,
                    right: 4.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: LightColors.warning,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Rx',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: badgeFontSize,
                        ),
                      ),
                    ),
                  ),
                // Discount badge
                if (medicine.isOnDiscount)
                  Positioned(
                    top: 4.0,
                    left: 4.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: LightColors.error,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '${medicine.discountPercentage}% OFF',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: badgeFontSize - 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
            // Medicine details
            Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Medicine name
                  Text(
                    medicine.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSizeTitle,
                    ),
                    maxLines: isExtraCompact ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spacingSmall),
                  // Brand and dosage
                  Text(
                    '${medicine.brand} • ${medicine.dosageForm}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                      fontSize: fontSizeBody,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.size(context, 4)),
                  // Price and add to cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Final price
                          Text(
                            '₹${medicine.finalPrice.toStringAsFixed(2)}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                              fontSize: fontSizeTitle,
                            ),
                          ),
                          if (medicine.isOnDiscount) ...[
                            SizedBox(height: spacingSmall),
                            // Original price with strikethrough
                            Text(
                              '₹${medicine.price.toStringAsFixed(2)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                                decoration: TextDecoration.lineThrough,
                                fontSize: fontSizeBody,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                      // Add to cart button
                      Container(
                        width: buttonSize,
                        height: buttonSize,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(
                            isExtraCompact ? 10.0 : (isCompact ? 12.0 : 16.0),
                          ),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.add,
                            size: isExtraCompact
                                ? 10.0
                                : isCompact
                                ? 12.0
                                : (cardWidth < 200 ? 14.0 : 16.0),
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Add to cart functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${medicine.name} added to cart',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacingSmall),
                  // Stock status and rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: stockPaddingH,
                            vertical: stockPaddingV,
                          ),
                          decoration: BoxDecoration(
                            color: medicine.inStock
                                ? LightColors.success.withValues(alpha: 0.1)
                                : LightColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                medicine.inStock
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                size: iconSizeSmall,
                                color: medicine.inStock
                                    ? LightColors.success
                                    : LightColors.error,
                              ),
                              SizedBox(width: spacingSmall / 2),
                              Flexible(
                                child: Text(
                                  medicine.inStock
                                      ? 'In Stock'
                                      : 'Out of Stock',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: medicine.inStock
                                        ? LightColors.success
                                        : LightColors.error,
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizeBody - 1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: ratingIconSize,
                            color: Colors.amber,
                          ),
                          SizedBox(width: spacingSmall / 2),
                          Text(
                            medicine.rating.toStringAsFixed(1),
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: ratingFontSize,
                            ),
                          ),
                          Text(
                            ' (${medicine.reviewCount})',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                              fontSize: fontSizeBody - 2,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
  }
}



// import 'package:flutter/material.dart';
// import 'package:suggest_doctor/core/responsive.dart';
// import 'package:suggest_doctor/models/medicine.dart';
// import 'package:suggest_doctor/core/constants.dart';
// import 'package:suggest_doctor/screens/ecommerce/medicine_detail_screen.dart';
// import 'package:suggest_doctor/widgets/network_image_widget.dart';

// class MedicineListScreen extends StatefulWidget {
//   const MedicineListScreen({super.key});

//   @override
//   State<MedicineListScreen> createState() => _MedicineListScreenState();
// }

// class _MedicineListScreenState extends State<MedicineListScreen> {
//   // Sample medicine data with real images
//   final List<Medicine> _allMedicines = [
//     Medicine(
//       id: '1',
//       name: 'Paracetamol',
//       brand: 'Dolo 650',
//       manufacturer: 'Micro Labs',
//       category: 'Pain Relief',
//       dosageForm: 'Tablet',
//       description:
//           'Paracetamol is used to treat many conditions such as headache, muscle aches, arthritis, backache, toothaches, colds, and fevers.',
//       composition: 'Paracetamol 650mg',
//       price: 25.00,
//       discountedPrice: 20.00,
//       discountPercentage: 20,
//       inStock: true,
//       imageUrl:
//           'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
//       rating: 4.5,
//       reviewCount: 120,
//       prescriptionRequired: false,
//       tags: ['fever', 'headache', 'pain'],
//     ),
//     Medicine(
//       id: '2',
//       name: 'Ibuprofen',
//       brand: 'Brufen',
//       manufacturer: 'Abbott',
//       category: 'Pain Relief',
//       dosageForm: 'Tablet',
//       description:
//           'Ibuprofen is a nonsteroidal anti-inflammatory drug (NSAID). It works by reducing hormones that cause inflammation and pain in the body.',
//       composition: 'Ibuprofen 400mg',
//       price: 35.00,
//       inStock: true,
//       imageUrl:
//           'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
//       rating: 4.2,
//       reviewCount: 89,
//       prescriptionRequired: false,
//       tags: ['pain', 'inflammation', 'fever'],
//     ),
//     Medicine(
//       id: '3',
//       name: 'Metformin',
//       brand: 'Glycomet',
//       manufacturer: 'GlaxoSmithKline',
//       category: 'Diabetes',
//       dosageForm: 'Tablet',
//       description:
//           'Metformin is an oral diabetes medicine that helps control blood sugar levels.',
//       composition: 'Metformin 500mg',
//       price: 45.00,
//       discountedPrice: 38.00,
//       discountPercentage: 15,
//       inStock: true,
//       imageUrl:
//           'https://images.unsplash.com/photo-1590658251333-d20d07c3edce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
//       rating: 4.7,
//       reviewCount: 210,
//       prescriptionRequired: true,
//       tags: ['diabetes', 'blood sugar'],
//     ),
//     Medicine(
//       id: '4',
//       name: 'Amoxicillin',
//       brand: 'Amoxil',
//       manufacturer: 'Glenmark',
//       category: 'Antibiotics',
//       dosageForm: 'Capsule',
//       description:
//           'Amoxicillin is used to treat many different types of infection caused by bacteria, such as tonsillitis, bronchitis, pneumonia, and infections of the ear, nose, throat, skin, or urinary tract.',
//       composition: 'Amoxicillin 500mg',
//       price: 55.00,
//       inStock: false,
//       imageUrl:
//           'https://images.unsplash.com/photo-1628771594745-7c1c7c9a0c3a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
//       rating: 4.0,
//       reviewCount: 76,
//       prescriptionRequired: true,
//       tags: ['infection', 'antibiotic'],
//     ),
//     Medicine(
//       id: '5',
//       name: 'Omeprazole',
//       brand: 'Prilosec',
//       manufacturer: 'AstraZeneca',
//       category: 'Digestive Health',
//       dosageForm: 'Capsule',
//       description:
//           'Omeprazole is used to treat certain stomach and esophagus problems (such as acid reflux, ulcers).',
//       composition: 'Omeprazole 20mg',
//       price: 65.00,
//       discountedPrice: 55.00,
//       discountPercentage: 15,
//       inStock: true,
//       imageUrl:
//           'https://images.unsplash.com/photo-1591350306295-6a07159c770d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
//       rating: 4.3,
//       reviewCount: 142,
//       prescriptionRequired: true,
//       tags: ['acid reflux', 'ulcer', 'stomach'],
//     ),
//     Medicine(
//       id: '6',
//       name: 'Cetirizine',
//       brand: 'Zyrtec',
//       manufacturer: 'Pfizer',
//       category: 'Allergy',
//       dosageForm: 'Tablet',
//       description:
//           'Cetirizine is an antihistamine used to relieve allergy symptoms such as watery eyes, runny nose, itching eyes/nose, sneezing, hives, and itching.',
//       composition: 'Cetirizine 10mg',
//       price: 30.00,
//       inStock: true,
//       imageUrl:
//           'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
//       rating: 4.6,
//       reviewCount: 98,
//       prescriptionRequired: false,
//       tags: ['allergy', 'cold', 'sneezing'],
//     ),
//   ];

//   List<Medicine> _filteredMedicines = [];
//   List<String> _categories = [];
//   String _selectedCategory = 'All';
//   String _searchQuery = '';
//   bool _showOutOfStock = true;

//   @override
//   void initState() {
//     super.initState();
//     _filteredMedicines = List.from(_allMedicines);
//     _extractCategories();
//   }

//   void _extractCategories() {
//     Set<String> categorySet = {};
//     for (var medicine in _allMedicines) {
//       categorySet.add(medicine.category);
//     }
//     _categories = ['All', ...categorySet.toList()..sort()];
//   }

//   void _filterMedicines() {
//     setState(() {
//       _filteredMedicines = _allMedicines.where((medicine) {
//         // Category filter
//         bool categoryMatch =
//             _selectedCategory == 'All' ||
//             medicine.category == _selectedCategory;

//         // Search filter
//         bool searchMatch =
//             _searchQuery.isEmpty ||
//             medicine.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//             medicine.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//             medicine.tags.any(
//               (tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()),
//             );

//         // Stock filter
//         bool stockMatch = _showOutOfStock || medicine.inStock;

//         return categoryMatch && searchMatch && stockMatch;
//       }).toList();
//     });
//   }

//   void _onCategorySelected(String category) {
//     setState(() {
//       _selectedCategory = category;
//       _filterMedicines();
//     });
//   }

//   void _onSearchChanged(String query) {
//     setState(() {
//       _searchQuery = query;
//       _filterMedicines();
//     });
//   }

//   void _toggleStockFilter(bool value) {
//     setState(() {
//       _showOutOfStock = value;
//       _filterMedicines();
//     });
//   }

//   Future<void> _refreshMedicines() async {
//     // Simulate refreshing medicines
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() {
//       // In a real app, this would fetch updated data
//     });
//   }

//   int _getCrossAxisCount(double screenWidth) {
//     // More granular column calculation based on screen width
//     if (screenWidth < 300) {
//       return 1; // Very small screens
//     } else if (screenWidth < 400) {
//       return 2; // Extra small screens
//     } else if (screenWidth < 600) {
//       return 2; // Small screens
//     } else if (screenWidth < 900) {
//       return 3; // Medium screens
//     } else {
//       return 4; // Large screens
//     }
//   }

//   double _getChildAspectRatio(int crossAxisCount) {
//     // More refined aspect ratio calculation based on column count
//     switch (crossAxisCount) {
//       case 1:
//         return 0.65; // Taller cards for single column
//       case 2:
//         return 0.75; // Standard aspect ratio for two columns
//       case 3:
//         return 0.85; // Slightly wider for three columns
//       default:
//         return 0.95; // Wider for four or more columns
//     }
//   }

//   Widget _buildEmptyState() {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: colorScheme.primary.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.search_off,
//                   color: colorScheme.primary,
//                   size: 48,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),
//             Text(
//               'No medicines found',
//               style: theme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: colorScheme.onSurface,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Try adjusting your search or filter',
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 color: colorScheme.onSurface.withValues(alpha: 0.7),
//                 height: 1.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 _onSearchChanged('');
//                 _onCategorySelected('All');
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 32,
//                   vertical: 16,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 'Clear Filters',
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'Browse Medicines',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//         ),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: colorScheme.primary.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.favorite_border, color: colorScheme.primary),
//             ),
//             onPressed: () {
//               // Navigate to wishlist screen
//               Navigator.pushNamed(context, '/wishlist');
//             },
//             tooltip: 'Wishlist',
//           ),
//           IconButton(
//             icon: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: colorScheme.primary.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.history, color: colorScheme.primary),
//             ),
//             onPressed: () {
//               // Navigate to recently viewed screen
//               Navigator.pushNamed(context, '/recently_viewed');
//             },
//             tooltip: 'Recently Viewed',
//           ),
//           IconButton(
//             icon: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: colorScheme.primary.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.shopping_cart, color: colorScheme.primary),
//             ),
//             onPressed: () {
//               // Navigate to cart screen
//               Navigator.pushNamed(context, '/cart');
//             },
//             tooltip: 'Cart',
//           ),
//           const SizedBox(width: 16),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Search bar with enhanced styling
//           LayoutBuilder(
//             builder: (context, constraints) {
//               bool isNarrowScreen = constraints.maxWidth < 350;
//               return Container(
//                 margin: EdgeInsets.all(isNarrowScreen ? 12 : 16),
//                 decoration: BoxDecoration(
//                   color: colorScheme.surface,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: colorScheme.shadow.withValues(alpha: 0.05),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: isNarrowScreen
//                         ? 'Search medicines...'
//                         : 'Search medicines, brands...',
//                     hintStyle: TextStyle(
//                       color: colorScheme.onSurface.withValues(alpha: 0.7),
//                       fontSize: isNarrowScreen ? 14 : 16,
//                     ),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: colorScheme.primary,
//                       size: isNarrowScreen ? 20 : 24,
//                     ),
//                     suffixIcon: _searchQuery.isNotEmpty
//                         ? IconButton(
//                             icon: Icon(
//                               Icons.clear,
//                               color: colorScheme.onSurface.withValues(
//                                 alpha: 0.7,
//                               ),
//                               size: isNarrowScreen ? 20 : 24,
//                             ),
//                             onPressed: () {
//                               _onSearchChanged('');
//                             },
//                           )
//                         : null,
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: isNarrowScreen ? 12 : 16,
//                       vertical: isNarrowScreen ? 12 : 16,
//                     ),
//                   ),
//                   style: TextStyle(fontSize: isNarrowScreen ? 14 : 16),
//                   onChanged: _onSearchChanged,
//                 ),
//               );
//             },
//           ),

//           // Filters with enhanced styling
//           LayoutBuilder(
//             builder: (context, constraints) {
//               bool isNarrowScreen = constraints.maxWidth < 400;
//               return Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: isNarrowScreen ? 12 : 16,
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: _categories.map((category) {
//                             return Padding(
//                               padding: EdgeInsets.only(
//                                 right: isNarrowScreen ? 6 : 8,
//                               ),
//                               child: FilterChip(
//                                 label: Text(
//                                   category,
//                                   style: TextStyle(
//                                     fontWeight: _selectedCategory == category
//                                         ? FontWeight.w600
//                                         : FontWeight.w500,
//                                     fontSize: isNarrowScreen ? 12 : 14,
//                                   ),
//                                 ),
//                                 selected: _selectedCategory == category,
//                                 onSelected: (selected) {
//                                   _onCategorySelected(
//                                     selected ? category : 'All',
//                                   );
//                                 },
//                                 selectedColor: colorScheme.primary,
//                                 backgroundColor: colorScheme.surface,
//                                 labelStyle: TextStyle(
//                                   color: _selectedCategory == category
//                                       ? Colors.white
//                                       : colorScheme.onSurface,
//                                   fontSize: isNarrowScreen ? 12 : 14,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                     isNarrowScreen ? 8 : 10,
//                                   ),
//                                 ),
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: isNarrowScreen ? 8 : 12,
//                                   vertical: isNarrowScreen ? 4 : 6,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(left: isNarrowScreen ? 6 : 8),
//                       decoration: BoxDecoration(
//                         color: colorScheme.surface,
//                         borderRadius: BorderRadius.circular(
//                           isNarrowScreen ? 8 : 10,
//                         ),
//                       ),
//                       child: PopupMenuButton<String>(
//                         icon: Icon(
//                           Icons.filter_list,
//                           color: colorScheme.primary,
//                           size: isNarrowScreen ? 20 : 24,
//                         ),
//                         onSelected: (value) {
//                           if (value == 'stock') {
//                             _toggleStockFilter(!_showOutOfStock);
//                           }
//                         },
//                         itemBuilder: (BuildContext context) {
//                           return [
//                             CheckedPopupMenuItem(
//                               checked: _showOutOfStock,
//                               value: 'stock',
//                               child: Text(
//                                 'Show out of stock',
//                                 style: TextStyle(
//                                   fontSize: isNarrowScreen ? 12 : 14,
//                                 ),
//                               ),
//                             ),
//                           ];
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),

//           const SizedBox(height: 16),

//           // Medicine list
//           Expanded(
//             child: _filteredMedicines.isEmpty
//                 ? _buildEmptyState()
//                 : RefreshIndicator(
//                     onRefresh: _refreshMedicines,
//                     color: colorScheme.primary,
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         // Calculate cross axis count based on screen width
//                         int crossAxisCount = _getCrossAxisCount(
//                           constraints.maxWidth,
//                         );
//                         double childAspectRatio = _getChildAspectRatio(
//                           crossAxisCount,
//                         );

//                         return GridView.builder(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: crossAxisCount,
//                                 childAspectRatio: childAspectRatio,
//                                 crossAxisSpacing: crossAxisCount > 2 ? 12 : 16,
//                                 mainAxisSpacing: crossAxisCount > 2 ? 12 : 16,
//                               ),
//                           itemCount: _filteredMedicines.length,
//                           itemBuilder: (context, index) {
//                             return _buildMedicineCard(
//                               _filteredMedicines[index],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMedicineCard(Medicine medicine) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Adjust card layout based on available width
//         bool isCompact = constraints.maxWidth < 150;
//         bool isExtraCompact = constraints.maxWidth < 120;
//         double imageHeight = isCompact ? 70 : 120;
//         double imageSize = isCompact ? 50 : 80;

//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MedicineDetailScreen(medicine: medicine),
//               ),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: colorScheme.surface,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: colorScheme.shadow.withValues(alpha: 0.05),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//               // border: Border.all(),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Medicine image with badge
//                 Stack(
//                   children: [
//                     Container(
//                       height: imageHeight,
//                       decoration: BoxDecoration(
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(16),
//                           topRight: Radius.circular(16),
//                         ),
//                         color: colorScheme.primary.withValues(alpha: 0.1),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(16),
//                           topRight: Radius.circular(16),
//                         ),
//                         child: Image.network(
//                           medicine.imageUrl,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                         ),
//                       ),
//                     ),
//                     // Prescription required badge
//                     if (medicine.prescriptionRequired)
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: LightColors.warning,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Text(
//                             'Rx',
//                             style: theme.textTheme.labelSmall?.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: isExtraCompact
//                                   ? 8
//                                   : isCompact
//                                   ? 10
//                                   : 12,
//                             ),
//                           ),
//                         ),
//                       ),
//                     // Discount badge
//                     if (medicine.isOnDiscount)
//                       Positioned(
//                         top: 8,
//                         left: 8,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: LightColors.error,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Text(
//                             '${medicine.discountPercentage}% OFF',
//                             style: theme.textTheme.labelSmall?.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: isExtraCompact
//                                   ? 7
//                                   : isCompact
//                                   ? 8
//                                   : 10,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),

//                 // Medicine details
//                 Padding(
//                   padding: EdgeInsets.all(isCompact ? 8 : 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Medicine name
//                       Text(
//                         medicine.name,
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           fontSize: isExtraCompact
//                               ? 12
//                               : isCompact
//                               ? 14
//                               : 16,
//                         ),
//                         maxLines: isExtraCompact ? 1 : 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),

//                       // SizedBox(height: Responsive.fontSize(context, 1)),

//                       // Brand and dosage
//                       Text(
//                         '${medicine.brand} • ${medicine.dosageForm}',
//                         style: theme.textTheme.bodySmall?.copyWith(
//                           color: colorScheme.onSurface.withValues(alpha: 0.7),
//                           fontSize: Responsive.fontSize(context, 1),
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),

//                       SizedBox(height: Responsive.size(context, 4)),

//                       // Price and add to cart
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Final price
//                               Text(
//                                 '₹${medicine.finalPrice.toStringAsFixed(2)}',
//                                 style: theme.textTheme.titleMedium?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   color: colorScheme.primary,
//                                   fontSize: isExtraCompact
//                                       ? 12
//                                       : isCompact
//                                       ? 14
//                                       : 16,
//                                 ),
//                               ),
//                               if (medicine.isOnDiscount) ...[
//                                 SizedBox(height: isCompact ? 1 : 2),
//                                 // Original price with strikethrough
//                                 Text(
//                                   '₹${medicine.price.toStringAsFixed(2)}',
//                                   style: theme.textTheme.bodySmall?.copyWith(
//                                     color: colorScheme.onSurface.withValues(
//                                       alpha: 0.7,
//                                     ),
//                                     decoration: TextDecoration.lineThrough,
//                                     fontSize: isExtraCompact
//                                         ? 8
//                                         : isCompact
//                                         ? 10
//                                         : 12,
//                                   ),
//                                 ),
//                               ],
//                             ],
//                           ),
//                           // Add to cart button
//                           Container(
//                             width: isExtraCompact
//                                 ? 24
//                                 : isCompact
//                                 ? 28
//                                 : 32,
//                             height: isExtraCompact
//                                 ? 24
//                                 : isCompact
//                                 ? 28
//                                 : 32,
//                             decoration: BoxDecoration(
//                               color: colorScheme.primary,
//                               borderRadius: BorderRadius.circular(
//                                 isExtraCompact
//                                     ? 12
//                                     : isCompact
//                                     ? 14
//                                     : 16,
//                               ),
//                             ),
//                             child: IconButton(
//                               padding: EdgeInsets.zero,
//                               icon: Icon(
//                                 Icons.add,
//                                 size: isExtraCompact
//                                     ? 12
//                                     : isCompact
//                                     ? 14
//                                     : 16,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 // Add to cart functionality
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                       '${medicine.name} added to cart',
//                                     ),
//                                     duration: const Duration(seconds: 1),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),

//                       // SizedBox(height: MediaQuery.of(context).size.height * 0.005),

//                       // Stock status and rating
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: isExtraCompact
//                                   ? 4
//                                   : isCompact
//                                   ? 6
//                                   : 8,
//                               vertical: isExtraCompact
//                                   ? 1
//                                   : isCompact
//                                   ? 2
//                                   : 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: medicine.inStock
//                                   ? LightColors.success.withValues(alpha: 0.1)
//                                   : LightColors.error.withValues(alpha: 0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   medicine.inStock
//                                       ? Icons.check_circle
//                                       : Icons.cancel,
//                                   size: isExtraCompact
//                                       ? 8
//                                       : isCompact
//                                       ? 10
//                                       : 12,
//                                   color: medicine.inStock
//                                       ? LightColors.success
//                                       : LightColors.error,
//                                 ),
//                                 SizedBox(
//                                   width: isExtraCompact
//                                       ? 1
//                                       : isCompact
//                                       ? 2
//                                       : 4,
//                                 ),
//                                 Text(
//                                   medicine.inStock
//                                       ? 'In Stock'
//                                       : 'Out of Stock',
//                                   style: theme.textTheme.labelSmall?.copyWith(
//                                     color: medicine.inStock
//                                         ? LightColors.success
//                                         : LightColors.error,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: isExtraCompact
//                                         ? 7
//                                         : isCompact
//                                         ? 8
//                                         : 10,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 size: isExtraCompact
//                                     ? 10
//                                     : isCompact
//                                     ? 12
//                                     : 14,
//                                 color: Colors.amber,
//                               ),
//                               SizedBox(
//                                 width: isExtraCompact
//                                     ? 1
//                                     : isCompact
//                                     ? 2
//                                     : 4,
//                               ),
//                               Text(
//                                 medicine.rating.toString(),
//                                 style: theme.textTheme.labelMedium?.copyWith(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: isExtraCompact
//                                       ? 8
//                                       : isCompact
//                                       ? 10
//                                       : 12,
//                                 ),
//                               ),
//                               Text(
//                                 ' (${medicine.reviewCount})',
//                                 style: theme.textTheme.labelSmall?.copyWith(
//                                   color: colorScheme.onSurface.withValues(
//                                     alpha: 0.7,
//                                   ),
//                                   fontSize: isExtraCompact
//                                       ? 7
//                                       : isCompact
//                                       ? 8
//                                       : 10,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:suggest_doctor/core/constants.dart';
// import 'package:suggest_doctor/core/responsive.dart';

// class MedicineListScreen extends StatefulWidget {
//   const MedicineListScreen({super.key});

//   @override
//   State<MedicineListScreen> createState() => _MedicineListScreenState();
// }

// class _MedicineListScreenState extends State<MedicineListScreen> {
//   // Dummy Medicine Data
//   final List<Map<String, dynamic>> medicines = [
//     {
//       "name": "Dolo 650 Tablet",
//       "generic": "Paracetamol 650mg",
//       "company": "Micro Labs Ltd",
//       "price": 32.50,
//       "mrp": 45.00,
//       "discount": 28,
//       "rating": 4.5,
//       "reviews": 12540,
//       "image":
//           "https://m.media-amazon.com/images/I/91bz6RZlHZL._AC_UF894,1000_QL80_.jpg",
//       "prescription": true,
//     },
//     {
//       "name": "Crocin Advance",
//       "generic": "Paracetamol 500mg",
//       "company": "GlaxoSmithKline",
//       "price": 25.00,
//       "mrp": 35.00,
//       "discount": 29,
//       "rating": 4.3,
//       "reviews": 8950,
//       "image":
//           "https://m.media-amazon.com/images/I/31CsUtgSdiL._AC_UF894,1000_QL80_.jpg",
//       "prescription": false,
//     },
//     {
//       "name": "Azithral 500",
//       "generic": "Azithromycin 500mg",
//       "company": "Alembic Pharma",
//       "price": 118.00,
//       "mrp": 140.00,
//       "discount": 16,
//       "rating": 4.6,
//       "reviews": 6780,
//       "image":
//           "https://www.onebharatpharmacy.com/uploads/product/main/1739864826_1844_0.jpeg",
//       "prescription": true,
//     },
//     {
//       "name": "Liv 52 DS",
//       "generic": "Herbal Liver Tonic",
//       "company": "Himalaya Wellness",
//       "price": 165.00,
//       "mrp": 195.00,
//       "discount": 15,
//       "rating": 4.7,
//       "reviews": 15420,
//       "image":
//           "https://i0.wp.com/medimartus.com/wp-content/uploads/2020/09/images-4.jpg?fit=267%2C189&ssl=1",
//       "prescription": false,
//     },
//     {
//       "name": "Ecosprin 75mg",
//       "generic": "Aspirin 75mg",
//       "company": "USV Ltd",
//       "price": 12.50,
//       "mrp": 18.00,
//       "discount": 31,
//       "rating": 4.4,
//       "reviews": 4320,
//       "image":
//           "https://assets.mrmed.in/product-images/product-images-1681190984206-881655758-ECOSPRIN%20AV%2075MG%20CAPSULE_90450%20%282%29.jpg",
//       "prescription": true,
//     },
//     {
//       "name": "Shelcal 500",
//       "generic": "Calcium + Vitamin D3",
//       "company": "Torrent Pharma",
//       "price": 98.00,
//       "mrp": 135.00,
//       "discount": 27,
//       "rating": 4.5,
//       "reviews": 9870,
//       "image": "https://m.media-amazon.com/images/I/7192EBB3GrL.jpg",
//       "prescription": false,
//     },
//     {
//       "name": "Neurobion Forte",
//       "generic": "Vitamin B Complex",
//       "company": "Procter & Gamble",
//       "price": 38.00,
//       "mrp": 50.00,
//       "discount": 24,
//       "rating": 4.6,
//       "reviews": 11200,
//       "image":
//           "https://images.apollo247.in/pub/media/catalog/product/n/e/neu0830_1-march25_1_.png?tr=q-80,f-webp,w-400,dpr-3,c-at_max%20400w",
//       "prescription": false,
//     },
//     {
//       "name": "Augmentin 625 Duo",
//       "generic": "Amoxycillin + Clavulanic Acid",
//       "company": "GlaxoSmithKline",
//       "price": 185.00,
//       "mrp": 220.00,
//       "discount": 16,
//       "rating": 4.5,
//       "reviews": 7890,
//       "image":
//           "https://assets.truemeds.in/Images/ProductImage/TM-TACR1-003781/augmentin-625-duo-tablet-10_augmentin-625-duo-tablet-10--TM-TACR1-003781_1.png?width=320",
//       "prescription": true,
//     },
//     {
//       "name": "Pantocid 40mg",
//       "generic": "Pantoprazole 40mg",
//       "company": "Sun Pharma",
//       "price": 88.00,
//       "mrp": 110.00,
//       "discount": 20,
//       "rating": 4.4,
//       "reviews": 5670,
//       "image":
//           "https://api.chemist180.com/api/media/image-resize/?path=Product%20Images/&name=PANTOCID_40MG_TABLET_chemist180.jpg",
//       "prescription": true,
//     },
//     {
//       "name": "Evion 400",
//       "generic": "Vitamin E 400mg",
//       "company": "Merck Ltd",
//       "price": 35.00,
//       "mrp": 48.00,
//       "discount": 27,
//       "rating": 4.5,
//       "reviews": 8900,
//       "image": "https://m.media-amazon.com/images/I/61AXD61XPhL._SX679_.jpg",
//       "prescription": false,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text(
//           "Medicines",
//           style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.only(
//           left: Responsive.size(context, 16),
//           right: Responsive.size(context, 16),
//         ),

//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: Responsive.size(context, 20)),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(
//                   Responsive.size(context, AppConstants.radiusLg),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: Responsive.size(context, 10),
//                     offset: Offset(0, Responsive.size(context, 2)),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search doctors, clinics, specialties...',
//                   hintStyle: TextStyle(
//                     fontSize: Responsive.fontSize(context, 14),
//                   ),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Theme.of(context).colorScheme.secondary,
//                     size: Responsive.size(context, 20),
//                   ),
//                   suffixIcon: Container(
//                     margin: EdgeInsets.all(Responsive.spacing(context, 8)),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.primary,
//                       borderRadius: BorderRadius.circular(
//                         Responsive.size(context, 8),
//                       ),
//                     ),
//                     child: Icon(
//                       Icons.filter_list,
//                       color: Colors.white,
//                       size: Responsive.size(context, 20),
//                     ),
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: Responsive.spacing(context, 16),
//                     vertical: Responsive.spacing(context, 16),
//                   ),
//                 ),
//                 style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
//                 onTap: () {
//                   Navigator.pushNamed(context, '/search');
//                 },
//               ),
//             ),
//             GridView.builder(
//               shrinkWrap: true,
//               itemCount: medicines.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10.w,
//                 mainAxisSpacing: 10.h,
//                 childAspectRatio: 0.72, // Slightly taller = no overflow
//               ),
//               itemBuilder: (context, index) =>
//                   MedicineCard(medicine: medicines[index]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MedicineCard extends StatelessWidget {
//   final Map<String, dynamic> medicine;
//   const MedicineCard({super.key, required this.medicine});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//       child: Column(
//         children: [
//           // IMAGE + Rx
//           SizedBox(
//             height: 95.h,
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(12.r),
//                     ),
//                     child: Image.network(
//                       medicine['image'],
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height * 0.2,
//                       filterQuality: FilterQuality.high,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Shimmer.fromColors(
//                           baseColor: Colors.grey.shade300,
//                           highlightColor: Colors.grey.shade100,
//                           child: Container(
//                             width: double.infinity,
//                             height: MediaQuery.of(context).size.height * 0.2,
//                             color: Colors.white,
//                           ),
//                         );
//                       },
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           color: Colors.grey[200],
//                           alignment: Alignment.center,
//                           child: const Icon(
//                             Icons.broken_image,
//                             color: Colors.grey,
//                             size: 50,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 if (medicine['prescription'])
//                   Positioned(
//                     top: 6.h,
//                     right: 6.w,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 7.w,
//                         vertical: 3.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(20.r),
//                       ),
//                       child: Text(
//                         "Rx",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 9.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           // CONTENT — THIS IS THE FINAL FIX
//           Padding(
//             padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Name
//                 Text(
//                   medicine['name'],
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.bold,
//                     height: 1.1,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 2.h),

//                 // Generic
//                 Text(
//                   medicine['generic'],
//                   style: TextStyle(fontSize: 9.5.sp, color: Colors.grey[700]),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 // Company
//                 Text(
//                   medicine['company'],
//                   style: TextStyle(fontSize: 8.5.sp, color: Colors.grey[500]),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 SizedBox(height: 3.h),

//                 // Rating
//                 Row(
//                   children: [
//                     Icon(Icons.star, size: 11.sp, color: Colors.amber),
//                     SizedBox(width: 2.w),
//                     Text(
//                       "${medicine['rating']}",
//                       style: TextStyle(fontSize: 9.sp),
//                     ),
//                     Text(
//                       " (${medicine['reviews']})",
//                       style: TextStyle(fontSize: 8.sp, color: Colors.grey),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 4.h),

//                 // Price
//                 Row(
//                   children: [
//                     Text(
//                       "₹${medicine['price']}",
//                       style: TextStyle(
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green[700],
//                       ),
//                     ),
//                     SizedBox(width: 4.w),
//                     Text(
//                       "₹${medicine['mrp']}",
//                       style: TextStyle(
//                         fontSize: 9.sp,
//                         color: Colors.grey,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                     Spacer(),
//                     Text(
//                       "${medicine['discount']}% off",
//                       style: TextStyle(fontSize: 9.sp, color: Colors.green),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 6.h),

//                 // ADD BUTTON — FIXED HEIGHT, NO EXPANDED
//                 SizedBox(
//                   height: 28.h,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6.r),
//                       ),
//                       padding: EdgeInsets.zero,
//                       elevation: 0,
//                     ),
//                     child: Text(
//                       "ADD",
//                       style: TextStyle(
//                         fontSize: 10.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }