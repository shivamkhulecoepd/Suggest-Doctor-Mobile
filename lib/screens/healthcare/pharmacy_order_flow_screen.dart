import 'package:flutter/material.dart';
import '../../core/constants.dart';

class PharmacyOrderFlowScreen extends StatefulWidget {
  const PharmacyOrderFlowScreen({super.key});

  @override
  State<PharmacyOrderFlowScreen> createState() => _PharmacyOrderFlowScreenState();
}

class _PharmacyOrderFlowScreenState extends State<PharmacyOrderFlowScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'Select Medicines',
    'Cart',
    'Delivery',
    'Payment',
    'Confirmation'
  ];
  
  int _currentStep = 0;
  final List<Medicine> _medicines = [
    Medicine(
      id: '1',
      name: 'Lisinopril',
      brand: 'Generic',
      dosage: '10mg',
      price: 12.99,
      originalPrice: 15.99,
      discount: 19,
      packSize: '30 tablets',
      authenticity: true,
      prescriptionRequired: true,
      image: Icons.local_pharmacy,
    ),
    Medicine(
      id: '2',
      name: 'Atorvastatin',
      brand: 'Generic',
      dosage: '20mg',
      price: 18.50,
      originalPrice: 22.99,
      discount: 20,
      packSize: '30 tablets',
      authenticity: true,
      prescriptionRequired: true,
      image: Icons.local_pharmacy,
    ),
    Medicine(
      id: '3',
      name: 'Ibuprofen',
      brand: 'Advil',
      dosage: '200mg',
      price: 8.99,
      originalPrice: 10.99,
      discount: 18,
      packSize: '20 tablets',
      authenticity: true,
      prescriptionRequired: false,
      image: Icons.local_pharmacy,
    ),
  ];
  
  final List<CartItem> _cartItems = [];
  String _selectedAddress = 'Home';
  List<String> _addresses = ['Home', 'Work', 'Other'];
  String _selectedPaymentMethod = 'Credit Card';
  List<String> _paymentMethods = ['Credit Card', 'Debit Card', 'UPI', 'Wallet'];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }
  
  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }
  
  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentStep = _tabController.index;
      });
    }
  }
  
  void _nextStep() {
    if (_currentStep < _tabs.length - 1) {
      setState(() {
        _currentStep++;
        _tabController.animateTo(_currentStep);
      });
    }
  }
  
  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _tabController.animateTo(_currentStep);
      });
    }
  }
  
  void _addToCart(Medicine medicine) {
    setState(() {
      _cartItems.add(CartItem(
        medicine: medicine,
        quantity: 1,
        totalPrice: medicine.price,
      ));
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${medicine.name} added to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            setState(() {
              _currentStep = 1;
              _tabController.animateTo(1);
            });
          },
        ),
      ),
    );
  }
  
  void _updateQuantity(CartItem item, int quantity) {
    setState(() {
      item.quantity = quantity;
      item.totalPrice = item.medicine.price * quantity;
    });
  }
  
  void _removeFromCart(CartItem item) {
    setState(() {
      _cartItems.remove(item);
    });
  }
  
  double _calculateTotal() {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
  
  double _calculateSavings() {
    return _cartItems.fold(0.0, (sum, item) {
      double originalPrice = item.medicine.originalPrice * item.quantity;
      double discountedPrice = item.totalPrice;
      return sum + (originalPrice - discountedPrice);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Medicines'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentStep > 0) {
              _previousStep();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Stepper(
              currentStep: _currentStep,
              onStepTapped: (step) {
                if (step <= _currentStep) {
                  setState(() {
                    _currentStep = step;
                    _tabController.animateTo(step);
                  });
                }
              },
              onStepContinue: _nextStep,
              onStepCancel: _previousStep,
              steps: _tabs.map((tab) {
                int index = _tabs.indexOf(tab);
                return Step(
                  title: Text(tab),
                  content: Container(),
                  isActive: index == _currentStep,
                  state: index < _currentStep
                      ? StepState.complete
                      : index == _currentStep
                          ? StepState.editing
                          : StepState.indexed,
                );
              }).toList(),
            ),
          ),
          
          // Tab bar view
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildSelectMedicinesStep(),
                _buildCartStep(),
                _buildDeliveryStep(),
                _buildPaymentStep(),
                _buildConfirmationStep(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSelectMedicinesStep() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingSm),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.search),
                const SizedBox(width: AppConstants.spacingSm),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search medicines...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      // Handle search
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Searching for "$value"')),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    // Scan barcode
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Scanning barcode...')),
                    );
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Prescription upload
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Have a prescription?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingSm),
                Text(
                  'Upload your prescription to get medicines delivered',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                ElevatedButton.icon(
                  onPressed: () {
                    // Upload prescription
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Uploading prescription...')),
                    );
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload Prescription'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Medicines list
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Refresh medicines
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                itemCount: _medicines.length,
                itemBuilder: (context, index) {
                  return _buildMedicineCard(_medicines[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCartStep() {
    if (_cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'Your cart is empty',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              'Add medicines to your cart to continue',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingLg),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentStep = 0;
                  _tabController.animateTo(0);
                });
              },
              child: const Text('Browse Medicines'),
            ),
          ],
        ),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        children: [
          // Cart items
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItem(_cartItems[index]);
              },
            ),
          ),
          
          // Order summary
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '\$${_calculateTotal().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Savings',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    Text(
                      '-\$${_calculateSavings().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.green,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const Text(
                      'FREE',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '\$${_calculateTotal().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingMd),
                ElevatedButton(
                  onPressed: _nextStep,
                  child: const Text('Proceed to Delivery'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDeliveryStep() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        children: [
          // Address selection
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Address',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                ..._addresses.map((address) {
                  return RadioListTile<String>(
                    title: Text(address),
                    value: address,
                    groupValue: _selectedAddress,
                    onChanged: (value) {
                      setState(() {
                        _selectedAddress = value!;
                      });
                    },
                  );
                }).toList(),
                const SizedBox(height: AppConstants.spacingMd),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add new address
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Adding new address...')),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Address'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Delivery time
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Time',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                ListTile(
                  title: const Text('Standard Delivery'),
                  subtitle: const Text('Free • 2-3 business days'),
                  trailing: Radio<String>(
                    value: 'standard',
                    groupValue: 'standard',
                    onChanged: (value) {},
                  ),
                ),
                ListTile(
                  title: const Text('Express Delivery'),
                  subtitle: const Text('\$4.99 • Next business day'),
                  trailing: Radio<String>(
                    value: 'express',
                    groupValue: 'standard',
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Continue button
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: ElevatedButton(
              onPressed: _nextStep,
              child: const Text('Proceed to Payment'),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPaymentStep() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        children: [
          // Payment methods
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                ..._paymentMethods.map((method) {
                  return RadioListTile<String>(
                    title: Text(method),
                    value: method,
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Payment details form
          if (_selectedPaymentMethod == 'Credit Card' ||
              _selectedPaymentMethod == 'Debit Card')
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacingMd),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Cardholder Name',
                    ),
                  ),
                ],
              ),
            ),
          
          const Spacer(),
          
          // Order summary
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Items (${_cartItems.length})',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '\$${_calculateTotal().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const Text(
                      'FREE',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '\$${_calculateTotal().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Pay now button
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: ElevatedButton(
              onPressed: _nextStep,
              child: const Text('Pay Now'),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildConfirmationStep() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        children: [
          // Success icon
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingXl),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 80,
              color: Colors.green,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacingLg),
          
          // Success message
          Text(
            'Order Placed Successfully!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: AppConstants.spacingSm),
          
          Text(
            'Your medicines will be delivered in 2-3 business days',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
          
          const SizedBox(height: AppConstants.spacingXxl),
          
          // Order details
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order ID',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const Text(
                      '#ORD-789456',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estimated Delivery',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const Text(
                      'Nov 24, 2023',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    Text(
                      '\$${_calculateTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Action buttons
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Track order
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tracking order...')),
                    );
                  },
                  child: const Text('Track Order'),
                ),
                const SizedBox(height: AppConstants.spacingSm),
                OutlinedButton(
                  onPressed: () {
                    // Continue shopping
                    Navigator.of(context).pop();
                  },
                  child: const Text('Continue Shopping'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMedicineCard(Medicine medicine) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
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
          Row(
            children: [
              // Medicine image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                ),
                child: Icon(
                  medicine.image,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Medicine name and brand
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            medicine.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        if (medicine.authenticity)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.spacingXs,
                              vertical: AppConstants.spacingXxs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                            ),
                            child: const Text(
                              'Authentic',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      '${medicine.brand} • ${medicine.dosage}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      medicine.packSize,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Price and discount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${medicine.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${medicine.originalPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      const SizedBox(width: AppConstants.spacingXs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                        ),
                        child: Text(
                          '${medicine.discount}% OFF',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _addToCart(medicine),
                child: const Text('Add to Cart'),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacingXs),
          
          // Prescription required badge
          if (medicine.prescriptionRequired)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingSm,
                vertical: AppConstants.spacingXs,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                border: Border.all(
                  color: Colors.orange.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning,
                    size: 14,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: AppConstants.spacingXs),
                  Text(
                    'Prescription required',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      padding: const EdgeInsets.all(AppConstants.spacingSm),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
      ),
      child: Row(
        children: [
          // Medicine image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusXs),
            ),
            child: Icon(
              item.medicine.image,
              color: Theme.of(context).primaryColor,
              size: AppConstants.iconMd,
            ),
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.medicine.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  '${item.medicine.brand} • ${item.medicine.dosage}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                Text(
                  '\$${item.medicine.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          // Quantity selector
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: item.quantity > 1
                    ? () => _updateQuantity(item, item.quantity - 1)
                    : null,
                iconSize: AppConstants.iconSm,
              ),
              Text(
                '${item.quantity}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _updateQuantity(item, item.quantity + 1),
                iconSize: AppConstants.iconSm,
              ),
            ],
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Text(
            '\$${item.totalPrice.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _removeFromCart(item),
            iconSize: AppConstants.iconSm,
          ),
        ],
      ),
    );
  }
}

class Medicine {
  final String id;
  final String name;
  final String brand;
  final String dosage;
  final double price;
  final double originalPrice;
  final int discount;
  final String packSize;
  final bool authenticity;
  final bool prescriptionRequired;
  final IconData image;
  
  Medicine({
    required this.id,
    required this.name,
    required this.brand,
    required this.dosage,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.packSize,
    required this.authenticity,
    required this.prescriptionRequired,
    required this.image,
  });
}

class CartItem {
  final Medicine medicine;
  int quantity;
  double totalPrice;
  
  CartItem({
    required this.medicine,
    required this.quantity,
    required this.totalPrice,
  });
}