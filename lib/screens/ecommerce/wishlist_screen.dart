import 'package:flutter/material.dart';
import 'package:suggest_doctor/models/medicine.dart';
import 'package:suggest_doctor/core/constants.dart';
import 'package:suggest_doctor/widgets/network_image_widget.dart';
import 'package:suggest_doctor/screens/ecommerce/medicine_detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Sample wishlist items
  List<Medicine> _wishlistItems = [
    Medicine(
      id: '2',
      name: 'Ibuprofen',
      brand: 'Brufen',
      manufacturer: 'Abbott',
      category: 'Pain Relief',
      dosageForm: 'Tablet',
      description: 'Ibuprofen is a nonsteroidal anti-inflammatory drug (NSAID). It works by reducing hormones that cause inflammation and pain in the body.',
      composition: 'Ibuprofen 400mg',
      price: 35.00,
      inStock: true,
      imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      rating: 4.2,
      reviewCount: 89,
      prescriptionRequired: false,
      tags: ['pain', 'inflammation', 'fever'],
    ),
    Medicine(
      id: '5',
      name: 'Omeprazole',
      brand: 'Prilosec',
      manufacturer: 'AstraZeneca',
      category: 'Digestive Health',
      dosageForm: 'Capsule',
      description: 'Omeprazole is used to treat certain stomach and esophagus problems (such as acid reflux, ulcers).',
      composition: 'Omeprazole 20mg',
      price: 65.00,
      discountedPrice: 55.00,
      discountPercentage: 15,
      inStock: true,
      imageUrl: 'https://images.unsplash.com/photo-1591350306295-6a07159c770d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      rating: 4.3,
      reviewCount: 142,
      prescriptionRequired: true,
      tags: ['acid reflux', 'ulcer', 'stomach'],
    ),
  ];

  void _removeFromWishlist(Medicine medicine) {
    setState(() {
      _wishlistItems.remove(medicine);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${medicine.name} removed from wishlist'),
      ),
    );
  }

  Future<void> _refreshWishlist() async {
    // Simulate refreshing wishlist
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // In a real app, this would fetch updated wishlist data
    });
  }

  void _moveToCart(Medicine medicine) {
    // In a real app, this would add to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${medicine.name} moved to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'My Wishlist (${_wishlistItems.length})',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
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
      body: _wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : RefreshIndicator(
              onRefresh: _refreshWishlist,
              color: colorScheme.primary,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _wishlistItems.length,
                itemBuilder: (context, index) {
                  return _buildWishlistItem(_wishlistItems[index]);
                },
              ),
            ),
    );
  }

  Widget _buildEmptyWishlist() {
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
                  Icons.favorite_border,
                  color: colorScheme.primary,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Your wishlist is empty',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Save medicines you like for later',
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

  Widget _buildWishlistItem(Medicine medicine) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
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
            
            // Action buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.favorite,
                    color: LightColors.error,
                  ),
                  onPressed: () {
                    _removeFromWishlist(medicine);
                  },
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: colorScheme.primary,
                  ),
                  onPressed: () {
                    _moveToCart(medicine);
                  },
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.visibility,
                    color: colorScheme.onSurface,
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
          ],
        ),
      ),
    );
  }
}