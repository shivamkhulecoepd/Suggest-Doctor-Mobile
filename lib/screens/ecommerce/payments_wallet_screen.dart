import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class PaymentsWalletScreen extends StatefulWidget {
  const PaymentsWalletScreen({super.key});

  @override
  State<PaymentsWalletScreen> createState() => _PaymentsWalletScreenState();
}

class _PaymentsWalletScreenState extends State<PaymentsWalletScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Wallet', 'Payment Methods', 'Insurance'];

  // Sample data
  double _walletBalance = 125.50;
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'Lab Test Payment',
      description: 'Complete Blood Count',
      amount: -49.99,
      date: 'Nov 18, 2023',
      type: 'debit',
      status: 'Completed',
    ),
    Transaction(
      id: '2',
      title: 'Medicine Order',
      description: 'Order #ORD-789456',
      amount: -29.99,
      date: 'Nov 15, 2023',
      type: 'debit',
      status: 'Completed',
    ),
    Transaction(
      id: '3',
      title: 'Wallet Top-up',
      description: 'Via Credit Card',
      amount: 100.00,
      date: 'Nov 10, 2023',
      type: 'credit',
      status: 'Completed',
    ),
    Transaction(
      id: '4',
      title: 'Appointment Payment',
      description: 'Dr. Sarah Johnson',
      amount: -150.00,
      date: 'Nov 5, 2023',
      type: 'debit',
      status: 'Completed',
    ),
  ];

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: '1',
      type: 'Credit Card',
      name: 'Visa **** 1234',
      isDefault: true,
      expiryDate: '12/25',
      icon: Icons.credit_card,
    ),
    PaymentMethod(
      id: '2',
      type: 'Debit Card',
      name: 'Mastercard **** 5678',
      isDefault: false,
      expiryDate: '06/24',
      icon: Icons.credit_card,
    ),
    PaymentMethod(
      id: '3',
      type: 'UPI',
      name: 'johnsmith@upi',
      isDefault: false,
      expiryDate: '',
      icon: Icons.account_balance_wallet,
    ),
  ];

  final List<InsurancePolicy> _insurancePolicies = [
    InsurancePolicy(
      id: '1',
      provider: 'HealthPlus Insurance',
      policyNumber: 'HP123456789',
      validUntil: 'Dec 31, 2024',
      coverage: 'Full Coverage',
      isActive: true,
    ),
    InsurancePolicy(
      id: '2',
      provider: 'MediCare Insurance',
      policyNumber: 'MC987654321',
      validUntil: 'Jun 30, 2024',
      coverage: 'Partial Coverage',
      isActive: false,
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

  void _addMoneyToWallet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddMoneyBottomSheet(
          onAmountAdded: (amount) {
            setState(() {
              _walletBalance += amount;
            });
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added \$${amount.toStringAsFixed(2)} to wallet'),
              ),
            );
          },
        );
      },
    );
  }

  void _addPaymentMethod() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const AddPaymentMethodBottomSheet();
      },
    );
  }

  void _addInsurancePolicy() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const AddInsurancePolicyBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments & Wallet'),
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
                _buildWalletTab(),
                _buildPaymentMethodsTab(),
                _buildInsuranceTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh wallet data
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet balance card
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingXl),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Wallet Balance',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  Text(
                    '\$${_walletBalance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingLg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addMoneyToWallet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Add Money'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.spacingLg),

            // Quick actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Row(
              children: [
                _buildQuickAction(
                  icon: Icons.send,
                  label: 'Send Money',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Send money feature coming soon')),
                    );
                  },
                ),
                const SizedBox(width: AppConstants.spacingMd),
                _buildQuickAction(
                  icon: Icons.request_quote,
                  label: 'Request Money',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Request money feature coming soon')),
                    );
                  },
                ),
                const SizedBox(width: AppConstants.spacingMd),
                _buildQuickAction(
                  icon: Icons.redeem,
                  label: 'Coupons',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coupons feature coming soon')),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacingLg),

            // Transaction history
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction History',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    // View all transactions
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Viewing all transactions...')),
                    );
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingMd),
            ..._transactions.take(5).map((transaction) {
              return _buildTransactionItem(transaction);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh payment methods
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add payment method button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _addPaymentMethod,
                icon: const Icon(Icons.add),
                label: const Text('Add Payment Method'),
              ),
            ),

            const SizedBox(height: AppConstants.spacingLg),

            // Payment methods list
            if (_paymentMethods.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payment,
                      size: 80,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    Text(
                      'No payment methods',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppConstants.spacingSm),
                    Text(
                      'Add a payment method to get started',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),
              )
            else
              ..._paymentMethods.map((method) {
                return _buildPaymentMethodCard(method);
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInsuranceTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh insurance policies
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add insurance button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _addInsurancePolicy,
                icon: const Icon(Icons.add),
                label: const Text('Add Insurance Policy'),
              ),
            ),

            const SizedBox(height: AppConstants.spacingLg),

            // Insurance policies list
            if (_insurancePolicies.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_hospital,
                      size: 80,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    Text(
                      'No insurance policies',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppConstants.spacingSm),
                    Text(
                      'Add your insurance policy to get started',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),
              )
            else
              ..._insurancePolicies.map((policy) {
                return _buildInsurancePolicyCard(policy);
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: AppConstants.iconLg,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingSm),
            decoration: BoxDecoration(
              color: transaction.type == 'credit'
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction.type == 'credit' ? Icons.add : Icons.remove,
              color: transaction.type == 'credit' ? Colors.green : Colors.red,
              size: AppConstants.iconMd,
            ),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  transaction.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                Text(
                  transaction.date,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction.type == 'credit' ? '+' : ''}\$${transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: transaction.type == 'credit' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingSm,
                  vertical: AppConstants.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(transaction.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                ),
                child: Text(
                  transaction.status,
                  style: TextStyle(
                    color: _getStatusColor(transaction.status),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
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
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingSm),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  method.icon,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (method.expiryDate.isNotEmpty)
                      Text(
                        'Expires ${method.expiryDate}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                      ),
                  ],
                ),
              ),
              if (method.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingSm,
                    vertical: AppConstants.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: Text(
                    'Default',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Set as default
                  setState(() {
                    for (var m in _paymentMethods) {
                      m.isDefault = false;
                    }
                    method.isDefault = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment method set as default')),
                  );
                },
                child: const Text('Set Default'),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Remove payment method
                  setState(() {
                    _paymentMethods.remove(method);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment method removed')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsurancePolicyCard(InsurancePolicy policy) {
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
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingSm),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_hospital,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      policy.provider,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      policy.policyNumber,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingSm,
                  vertical: AppConstants.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: policy.isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                ),
                child: Text(
                  policy.isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: policy.isActive ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valid Until',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    Text(
                      policy.validUntil,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coverage',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    Text(
                      policy.coverage,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // View policy details
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing policy details...')),
                  );
                },
                child: const Text('View Details'),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Remove policy
                  setState(() {
                    _insurancePolicies.remove(policy);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insurance policy removed')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Theme.of(context).primaryColor;
    }
  }
}

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String date;
  final String type; // credit or debit
  final String status;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    required this.status,
  });
}

class PaymentMethod {
  final String id;
  final String type;
  final String name;
  bool isDefault;
  final String expiryDate;
  final IconData icon;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.name,
    required this.isDefault,
    required this.expiryDate,
    required this.icon,
  });
}

class InsurancePolicy {
  final String id;
  final String provider;
  final String policyNumber;
  final String validUntil;
  final String coverage;
  final bool isActive;

  InsurancePolicy({
    required this.id,
    required this.provider,
    required this.policyNumber,
    required this.validUntil,
    required this.coverage,
    required this.isActive,
  });
}

class AddMoneyBottomSheet extends StatefulWidget {
  final Function(double) onAmountAdded;

  const AddMoneyBottomSheet({super.key, required this.onAmountAdded});

  @override
  State<AddMoneyBottomSheet> createState() => _AddMoneyBottomSheetState();
}

class _AddMoneyBottomSheetState extends State<AddMoneyBottomSheet> {
  final List<double> _presetAmounts = [10.0, 25.0, 50.0, 100.0, 200.0];
  double _selectedAmount = 50.0;
  final TextEditingController _customAmountController = TextEditingController();

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Money',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Select Amount',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Wrap(
            spacing: AppConstants.spacingSm,
            runSpacing: AppConstants.spacingSm,
            children: _presetAmounts.map((amount) {
              return ChoiceChip(
                label: Text('\$${amount.toStringAsFixed(0)}'),
                selected: _selectedAmount == amount,
                onSelected: (selected) {
                  setState(() {
                    _selectedAmount = amount;
                    _customAmountController.clear();
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Or enter custom amount',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          TextField(
            controller: _customAmountController,
            decoration: const InputDecoration(
              prefixText: '\$',
              hintText: 'Enter amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                final amount = double.tryParse(value);
                if (amount != null && amount > 0) {
                  setState(() {
                    _selectedAmount = amount;
                  });
                }
              }
            },
          ),
          const SizedBox(height: AppConstants.spacingLg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onAmountAdded(_selectedAmount);
              },
              child: const Text('Add Money'),
            ),
          ),
        ],
      ),
    );
  }
}

class AddPaymentMethodBottomSheet extends StatefulWidget {
  const AddPaymentMethodBottomSheet({super.key});

  @override
  State<AddPaymentMethodBottomSheet> createState() => _AddPaymentMethodBottomSheetState();
}

class _AddPaymentMethodBottomSheetState extends State<AddPaymentMethodBottomSheet> {
  String _selectedMethod = 'Credit Card';
  final List<String> _paymentTypes = ['Credit Card', 'Debit Card', 'UPI'];

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    _upiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Payment Method',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Select Payment Type',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Wrap(
            spacing: AppConstants.spacingSm,
            runSpacing: AppConstants.spacingSm,
            children: _paymentTypes.map((type) {
              return ChoiceChip(
                label: Text(type),
                selected: _selectedMethod == type,
                onSelected: (selected) {
                  setState(() {
                    _selectedMethod = type;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          if (_selectedMethod == 'Credit Card' || _selectedMethod == 'Debit Card')
            _buildCardForm()
          else
            _buildUpiForm(),
          const SizedBox(height: AppConstants.spacingMd),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Add payment method
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment method added successfully')),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Add Payment Method'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardForm() {
    return Column(
      children: [
        TextFormField(
          controller: _cardNumberController,
          decoration: const InputDecoration(
            labelText: 'Card Number',
            hintText: '1234 5678 9012 3456',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _expiryController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  hintText: 'MM/YY',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  hintText: '123',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Cardholder Name',
            hintText: 'John Smith',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildUpiForm() {
    return Column(
      children: [
        TextFormField(
          controller: _upiController,
          decoration: const InputDecoration(
            labelText: 'UPI ID',
            hintText: 'username@upi',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: const Text(
            'Note: You will be redirected to your UPI app to complete the verification process.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class AddInsurancePolicyBottomSheet extends StatefulWidget {
  const AddInsurancePolicyBottomSheet({super.key});

  @override
  State<AddInsurancePolicyBottomSheet> createState() => _AddInsurancePolicyBottomSheetState();
}

class _AddInsurancePolicyBottomSheetState extends State<AddInsurancePolicyBottomSheet> {
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _policyNumberController = TextEditingController();
  final TextEditingController _validUntilController = TextEditingController();
  String _coverage = 'Full Coverage';

  @override
  void dispose() {
    _providerController.dispose();
    _policyNumberController.dispose();
    _validUntilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Insurance Policy',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          TextFormField(
            controller: _providerController,
            decoration: const InputDecoration(
              labelText: 'Insurance Provider',
              hintText: 'e.g., HealthPlus Insurance',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          TextFormField(
            controller: _policyNumberController,
            decoration: const InputDecoration(
              labelText: 'Policy Number',
              hintText: 'e.g., HP123456789',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          TextFormField(
            controller: _validUntilController,
            decoration: const InputDecoration(
              labelText: 'Valid Until',
              hintText: 'e.g., Dec 31, 2024',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Coverage Type',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          DropdownButtonFormField<String>(
            value: _coverage,
            items: ['Full Coverage', 'Partial Coverage', 'Basic Coverage']
                .map((coverage) => DropdownMenuItem(
                      value: coverage,
                      child: Text(coverage),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _coverage = value!;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Add insurance policy
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Insurance policy added successfully')),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Add Insurance Policy'),
            ),
          ),
        ],
      ),
    );
  }
}