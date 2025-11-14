import 'package:flutter/material.dart';
import 'package:suggest_doctor/models/medicine.dart';
import 'package:suggest_doctor/core/constants.dart';
import 'package:suggest_doctor/widgets/network_image_widget.dart';
import 'package:suggest_doctor/screens/ecommerce/order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items
  List<CartItem> _cartItems = [
    CartItem(
      medicine: Medicine(
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
      quantity: 2,
      addedAt: DateTime.now(),
    ),
    CartItem(
      medicine: Medicine(
        id: '3',
        name: 'Metformin',
        brand: 'Glycomet',
        manufacturer: 'GlaxoSmithKline',
        category: 'Diabetes',
        dosageForm: 'Tablet',
        description: 'Metformin is an oral diabetes medicine that helps control blood sugar levels.',
        composition: 'Metformin 500mg',
        price: 45.00,
        discountedPrice: 38.00,
        discountPercentage: 15,
        inStock: true,
        imageUrl: 'https://images.unsplash.com/photo-1590658251333-d20d07c3edce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
        rating: 4.7,
        reviewCount: 210,
        prescriptionRequired: true,
        tags: ['diabetes', 'blood sugar'],
      ),
      quantity: 1,
      addedAt: DateTime.now(),
    ),
  ];

  void _updateQuantity(CartItem item, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _cartItems.remove(item);
      } else {
        item.quantity = quantity;
      }
    });
  }

  void _removeItem(CartItem item) {
    setState(() {
      _cartItems.remove(item);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart'),
      ),
    );
  }

  Future<void> _refreshCart() async {
    // Simulate refreshing cart
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // In a real app, this would fetch updated cart data
    });
  }

  double _calculateSubtotal() {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double _calculateDiscount() {
    return _cartItems.fold(0.0, (sum, item) {
      double originalPrice = item.medicine.price * item.quantity;
      double discountedPrice = item.totalPrice;
      return sum + (originalPrice - discountedPrice);
    });
  }

  double _calculateTotal() {
    return _calculateSubtotal() - _calculateDiscount();
  }

  void _proceedToCheckout() {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
        ),
      );
      return;
    }
    
    // Check if any prescription required medicines are in cart
    bool hasPrescriptionRequired = _cartItems.any((item) => item.medicine.prescriptionRequired);
    
    if (hasPrescriptionRequired) {
      // Show dialog to upload prescription
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Prescription Required'),
            content: const Text('Some medicines in your cart require a prescription. Would you like to upload one now?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to prescription upload
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Prescription upload feature coming soon'),
                    ),
                  );
                },
                child: const Text('Upload Later'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to order confirmation
                  _navigateToOrderConfirmation();
                },
                child: const Text('Continue'),
              ),
            ],
          );
        },
      );
    } else {
      _navigateToOrderConfirmation();
    }
  }

  void _navigateToOrderConfirmation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationScreen(
          items: _cartItems,
          subtotal: _calculateSubtotal(),
          discount: _calculateDiscount(),
          deliveryFee: 0.0, // Free delivery
          totalAmount: _calculateTotal(),
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
          'My Cart (${_cartItems.length})',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag,
                color: colorScheme.primary,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/browse_medicines');
            },
            tooltip: 'Continue Shopping',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                // Cart items
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshCart,
                    color: colorScheme.primary,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        return _buildCartItem(_cartItems[index]);
                      },
                    ),
                  ),
                ),
                
                // Order summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildOrderSummaryRow('Subtotal', '₹${_calculateSubtotal().toStringAsFixed(2)}'),
                      if (_calculateDiscount() > 0)
                        _buildOrderSummaryRow('Discount', '-₹${_calculateDiscount().toStringAsFixed(2)}', isDiscount: true),
                      _buildOrderSummaryRow('Delivery', 'FREE', isFree: true),
                      const Divider(),
                      _buildOrderSummaryRow('Total', '₹${_calculateTotal().toStringAsFixed(2)}', isTotal: true),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _proceedToCheckout,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Delivery within 2-3 business days',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
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
                  Icons.shopping_cart_outlined,
                  color: colorScheme.primary,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Your cart is empty',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Add medicines to your cart to continue',
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

  Widget _buildCartItem(CartItem item) {
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
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: NetworkImageWidget(
                  imageUrl: item.medicine.imageUrl,
                  width: 50,
                  height: 50,
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
                    item.medicine.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.medicine.brand,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Price and dosage
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.medicine.dosageForm}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        '₹${item.medicine.finalPrice.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Quantity controls and total
            Column(
              children: [
                // Quantity controls
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colorScheme.outline,
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.remove,
                          size: 16,
                          color: colorScheme.onSurface,
                        ),
                        onPressed: () {
                          _updateQuantity(item, item.quantity - 1);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item.quantity}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: colorScheme.outline,
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.add,
                          size: 16,
                          color: colorScheme.onSurface,
                        ),
                        onPressed: () {
                          _updateQuantity(item, item.quantity + 1);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Total price
                Text(
                  '₹${item.totalPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Remove button
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: LightColors.error,
                  ),
                  onPressed: () {
                    _removeItem(item);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryRow(String label, String value, {bool isDiscount = false, bool isTotal = false, bool isFree = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal 
                  ? Theme.of(context).textTheme.titleLarge?.color 
                  : Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isDiscount 
                  ? Colors.green 
                  : isFree 
                      ? Colors.green 
                      : isTotal 
                          ? Theme.of(context).textTheme.titleLarge?.color 
                          : Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}