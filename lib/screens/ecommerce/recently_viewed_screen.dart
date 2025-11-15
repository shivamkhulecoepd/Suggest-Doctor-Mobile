import 'package:flutter/material.dart';
import 'package:suggest_doctor/models/medicine.dart';
import 'package:suggest_doctor/core/constants.dart';
import 'package:suggest_doctor/widgets/network_image_widget.dart';
import 'package:suggest_doctor/screens/ecommerce/medicine_detail_screen.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  // Sample recently viewed items
  List<Medicine> _recentlyViewedItems = [
    Medicine(
      id: '1',
      name: 'Paracetamol',
      brand: 'Dolo 650',
      manufacturer: 'Micro Labs',
      category: 'Pain Relief',
      dosageForm: 'Tablet',
      description: 'Paracetamol is used to treat many conditions such as headache, muscle aches, arthritis, backache, toothaches, colds, and fevers.',
      composition: 'Paracetamol 650mg',
      price: 25.00,
      discountedPrice: 20.00,
      discountPercentage: 20,
      inStock: true,
      imageUrl: 'https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      rating: 4.5,
      reviewCount: 120,
      prescriptionRequired: false,
      tags: ['fever', 'headache', 'pain'],
    ),
    Medicine(
      id: '6',
      name: 'Cetirizine',
      brand: 'Zyrtec',
      manufacturer: 'Pfizer',
      category: 'Allergy',
      dosageForm: 'Tablet',
      description: 'Cetirizine is an antihistamine used to relieve allergy symptoms such as watery eyes, runny nose, itching eyes/nose, sneezing, hives, and itching.',
      composition: 'Cetirizine 10mg',
      price: 30.00,
      inStock: true,
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      rating: 4.6,
      reviewCount: 98,
      prescriptionRequired: false,
      tags: ['allergy', 'cold', 'sneezing'],
    ),
    Medicine(
      id: '4',
      name: 'Amoxicillin',
      brand: 'Amoxil',
      manufacturer: 'Glenmark',
      category: 'Antibiotics',
      dosageForm: 'Capsule',
      description: 'Amoxicillin is used to treat many different types of infection caused by bacteria, such as tonsillitis, bronchitis, pneumonia, and infections of the ear, nose, throat, skin, or urinary tract.',
      composition: 'Amoxicillin 500mg',
      price: 55.00,
      inStock: false,
      imageUrl: 'https://images.unsplash.com/photo-1628771594745-7c1c7c9a0c3a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      rating: 4.0,
      reviewCount: 76,
      prescriptionRequired: true,
      tags: ['infection', 'antibiotic'],
    ),
  ];

  void _clearHistory() {
    setState(() {
      _recentlyViewedItems.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recently viewed history cleared'),
      ),
    );
  }

  Future<void> _refreshHistory() async {
    // Simulate refreshing history
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // In a real app, this would fetch updated history data
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Recently Viewed (${_recentlyViewedItems.length})',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (_recentlyViewedItems.isNotEmpty)
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: LightColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete,
                  color: LightColors.error,
                ),
              ),
              onPressed: _clearHistory,
              tooltip: 'Clear History',
            ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart,
                color: colorScheme.primary,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            tooltip: 'View Cart',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _recentlyViewedItems.isEmpty
          ? _buildEmptyHistory()
          : RefreshIndicator(
              onRefresh: _refreshHistory,
              color: colorScheme.primary,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _recentlyViewedItems.length,
                itemBuilder: (context, index) {
                  return _buildRecentlyViewedItem(_recentlyViewedItems[index]);
                },
              ),
            ),
    );
  }

  Widget _buildEmptyHistory() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Icon(
                  Icons.history,
                  color: colorScheme.primary,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'No recently viewed items',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Medicines you view will appear here',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/browse_medicines');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Browse Medicines',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyViewedItem(Medicine medicine) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
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
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Medicine image
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: NetworkImageWidget(
                    imageUrl: medicine.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Medicine details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Medicine name and brand
                    Text(
                      medicine.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${medicine.brand} • ${medicine.dosageForm}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Price and discount
                    Row(
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
                              ),
                            ),
                            if (medicine.isOnDiscount) ...[
                              const SizedBox(height: 2),
                              // Original price with strikethrough
                              Text(
                                '₹${medicine.price.toStringAsFixed(2)}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (medicine.isOnDiscount)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: LightColors.error,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${medicine.discountPercentage}% OFF',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Stock status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: medicine.inStock 
                            ? LightColors.success.withValues(alpha: 0.1) 
                            : LightColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            medicine.inStock ? Icons.check_circle : Icons.cancel,
                            size: 12,
                            color: medicine.inStock ? LightColors.success : LightColors.error,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            medicine.inStock ? 'In Stock' : 'Out of Stock',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: medicine.inStock ? LightColors.success : LightColors.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // View button
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.visibility,
                  color: colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineDetailScreen(medicine: medicine),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}