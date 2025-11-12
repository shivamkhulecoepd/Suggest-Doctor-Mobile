import 'package:flutter/material.dart';
import '../../core/constants.dart';

class LabTestsScreen extends StatefulWidget {
  const LabTestsScreen({super.key});

  @override
  State<LabTestsScreen> createState() => _LabTestsScreenState();
}

class _LabTestsScreenState extends State<LabTestsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Tests', 'Packages', 'My Reports'];

  // Sample data
  final List<LabTest> _labTests = [
    LabTest(
      id: '1',
      name: 'Complete Blood Count',
      category: 'Blood Tests',
      price: 49.99,
      originalPrice: 75.00,
      discount: 33,
      duration: '24-48 hrs',
      fastingRequired: true,
      preparation: '8-12 hours fasting required. Drink water allowed.',
      description:
          'A complete blood count (CBC) is a common blood test that evaluates your overall health and detects a wide range of disorders.',
      includes: [
        'Red blood cells',
        'White blood cells',
        'Hemoglobin',
        'Hematocrit',
        'Platelets'
      ],
    ),
    LabTest(
      id: '2',
      name: 'Lipid Profile',
      category: 'Blood Tests',
      price: 59.99,
      originalPrice: 85.00,
      discount: 30,
      duration: '24-48 hrs',
      fastingRequired: true,
      preparation: '12 hours fasting required. No food or drink except water.',
      description:
          'A lipid profile is a panel of blood tests that measures different types of lipids (fats) in your blood.',
      includes: [
        'Total Cholesterol',
        'LDL Cholesterol',
        'HDL Cholesterol',
        'Triglycerides',
        'Cholesterol Ratio'
      ],
    ),
    LabTest(
      id: '3',
      name: 'Thyroid Function',
      category: 'Blood Tests',
      price: 69.99,
      originalPrice: 95.00,
      discount: 26,
      duration: '24-48 hrs',
      fastingRequired: false,
      preparation: 'No special preparation required.',
      description:
          'Thyroid function tests are blood tests that check if your thyroid gland is working normally.',
      includes: [
        'TSH',
        'T3',
        'T4',
        'Free T3',
        'Free T4',
      ],
    ),
    LabTest(
      id: '4',
      name: 'Liver Function',
      category: 'Blood Tests',
      price: 54.99,
      originalPrice: 75.00,
      discount: 27,
      duration: '24-48 hrs',
      fastingRequired: true,
      preparation: '8-12 hours fasting required. Avoid alcohol for 24 hours.',
      description:
          'Liver function tests (LFTs) are blood tests that check how well your liver is working.',
      includes: [
        'ALT',
        'AST',
        'ALP',
        'Bilirubin',
        'Albumin',
        'Total Protein'
      ],
    ),
  ];

  final List<TestPackage> _testPackages = [
    TestPackage(
      id: '1',
      name: 'Basic Health Checkup',
      tests: 5,
      price: 149.99,
      originalPrice: 225.00,
      discount: 33,
      description:
          'Essential health tests to assess your overall well-being and detect common health issues.',
      includes: [
        'Complete Blood Count',
        'Lipid Profile',
        'Liver Function',
        'Kidney Function',
        'Blood Sugar'
      ],
    ),
    TestPackage(
      id: '2',
      name: 'Comprehensive Health Package',
      tests: 12,
      price: 299.99,
      originalPrice: 450.00,
      discount: 33,
      description:
          'Extensive health assessment including all essential parameters for a complete health overview.',
      includes: [
        'Complete Blood Count',
        'Lipid Profile',
        'Liver Function',
        'Kidney Function',
        'Thyroid Function',
        'Blood Sugar',
        'Uric Acid',
        'Vitamin D',
        'Vitamin B12',
        'Calcium',
        'Phosphorus',
        'Iron Studies'
      ],
    ),
  ];

  final List<TestReport> _testReports = [
    TestReport(
      id: '1',
      testName: 'Complete Blood Count',
      date: 'Nov 12, 2023',
      status: 'Completed',
      hasAbnormalValues: true,
      labName: 'City Lab Services',
    ),
    TestReport(
      id: '2',
      testName: 'Lipid Profile',
      date: 'Oct 25, 2023',
      status: 'Completed',
      hasAbnormalValues: false,
      labName: 'General Diagnostics',
    ),
    TestReport(
      id: '3',
      testName: 'Thyroid Function',
      date: 'Sep 30, 2023',
      status: 'Completed',
      hasAbnormalValues: false,
      labName: 'Metropolitan Labs',
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

  void _showPreparationInfo(String preparation) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                    'Preparation Instructions',
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
                preparation,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Tests & Packages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search functionality coming soon')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Open filters
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter functionality coming soon')),
              );
            },
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
                _buildTestsTab(),
                _buildPackagesTab(),
                _buildReportsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Book home sample collection
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SampleCollectionBookingScreen(),
            ),
          );
        },
        icon: const Icon(Icons.home),
        label: const Text('Home Collection'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildTestsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh tests
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // Category chips
          Container(
            margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
            child: Wrap(
              spacing: AppConstants.spacingXs,
              runSpacing: AppConstants.spacingXs,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (selected) {},
                ),
                FilterChip(
                  label: const Text('Blood Tests'),
                  selected: false,
                  onSelected: (selected) {},
                ),
                FilterChip(
                  label: const Text('Urine Tests'),
                  selected: false,
                  onSelected: (selected) {},
                ),
                FilterChip(
                  label: const Text('Imaging'),
                  selected: false,
                  onSelected: (selected) {},
                ),
              ],
            ),
          ),

          // Tests list
          ..._labTests.map((test) => _buildTestCard(test)).toList(),
        ],
      ),
    );
  }

  Widget _buildPackagesTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh packages
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // Packages list
          ..._testPackages.map((package) => _buildPackageCard(package)).toList(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh reports
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // Reports list
          ..._testReports.map((report) => _buildReportCard(report)).toList(),
        ],
      ),
    );
  }

  Widget _buildTestCard(LabTest test) {
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
          // Test header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      test.category,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),
              ),
              if (test.fastingRequired)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingSm,
                    vertical: AppConstants.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: const Text(
                    'Fasting Required',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Test description
          Text(
            test.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Includes
          Text(
            'Includes:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingXs),
          Wrap(
            spacing: AppConstants.spacingXs,
            runSpacing: AppConstants.spacingXs,
            children: test.includes.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingSm,
                  vertical: AppConstants.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                ),
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Price and actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${test.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${test.originalPrice.toStringAsFixed(2)}',
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
                          '${test.discount}% OFF',
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
              Column(
                children: [
                  Text(
                    'Report in ${test.duration}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingXs),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Book test
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestBookingScreen(test: test),
                            ),
                          );
                        },
                        child: const Text('Book Now'),
                      ),
                      const SizedBox(width: AppConstants.spacingXs),
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () => _showPreparationInfo(test.preparation),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(TestPackage package) {
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
          // Package header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      '${package.tests} Tests Included',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                ),
                child: Text(
                  'Popular',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Package description
          Text(
            package.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Includes
          Text(
            'Includes:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingXs),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: package.includes.map((item) {
                return Container(
                  margin: const EdgeInsets.only(right: AppConstants.spacingXs),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingSm,
                    vertical: AppConstants.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Price and actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${package.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${package.originalPrice.toStringAsFixed(2)}',
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
                          '${package.discount}% OFF',
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
                onPressed: () {
                  // Book package
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booking ${package.name} package'),
                    ),
                  );
                },
                child: const Text('Book Package'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(TestReport report) {
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
          // Report header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.testName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      report.labName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                  color: _getStatusColor(report.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                ),
                child: Text(
                  report.status,
                  style: TextStyle(
                    color: _getStatusColor(report.status),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Report details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                report.date,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
              if (report.hasAbnormalValues)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingSm,
                    vertical: AppConstants.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: const Text(
                    'Abnormal Values',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // View report
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestReportViewerScreen(report: report),
                    ),
                  );
                },
                child: const Text('View Report'),
              ),
              const SizedBox(width: AppConstants.spacingSm),
              TextButton(
                onPressed: () {
                  // Download report
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading report...')),
                  );
                },
                child: const Text('Download'),
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
      case 'cancelled':
        return Colors.red;
      default:
        return Theme.of(context).primaryColor;
    }
  }
}

class LabTest {
  final String id;
  final String name;
  final String category;
  final double price;
  final double originalPrice;
  final int discount;
  final String duration;
  final bool fastingRequired;
  final String preparation;
  final String description;
  final List<String> includes;

  LabTest({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.duration,
    required this.fastingRequired,
    required this.preparation,
    required this.description,
    required this.includes,
  });
}

class TestPackage {
  final String id;
  final String name;
  final int tests;
  final double price;
  final double originalPrice;
  final int discount;
  final String description;
  final List<String> includes;

  TestPackage({
    required this.id,
    required this.name,
    required this.tests,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.description,
    required this.includes,
  });
}

class TestReport {
  final String id;
  final String testName;
  final String date;
  final String status;
  final bool hasAbnormalValues;
  final String labName;

  TestReport({
    required this.id,
    required this.testName,
    required this.date,
    required this.status,
    required this.hasAbnormalValues,
    required this.labName,
  });
}

class TestBookingScreen extends StatefulWidget {
  final LabTest test;

  const TestBookingScreen({super.key, required this.test});

  @override
  State<TestBookingScreen> createState() => _TestBookingScreenState();
}

class _TestBookingScreenState extends State<TestBookingScreen> {
  int _currentStep = 0;
  String _selectedCollectionType = 'Home';
  String _selectedDate = 'Tomorrow, Nov 21';
  String _selectedTime = '10:00 AM';
  String _selectedPatient = 'John Smith';

  final List<String> _collectionTypes = ['Home', 'Lab Center'];
  final List<String> _dates = [
    'Today, Nov 20',
    'Tomorrow, Nov 21',
    'Nov 22',
    'Nov 23',
    'Nov 24'
  ];
  final List<String> _times = [
    '8:00 AM',
    '10:00 AM',
    '12:00 PM',
    '2:00 PM',
    '4:00 PM',
    '6:00 PM'
  ];
  final List<String> _patients = ['John Smith', 'Sarah Smith', 'Robert Smith'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.name),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 3) {
            setState(() {
              _currentStep++;
            });
          } else {
            // Complete booking
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingConfirmationScreen(),
              ),
            );
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          } else {
            Navigator.of(context).pop();
          }
        },
        steps: [
          Step(
            title: const Text('Collection Type'),
            content: Column(
              children: _collectionTypes.map((type) {
                return RadioListTile<String>(
                  title: Text(type),
                  value: type,
                  groupValue: _selectedCollectionType,
                  onChanged: (value) {
                    setState(() {
                      _selectedCollectionType = value!;
                    });
                  },
                );
              }).toList(),
            ),
            isActive: _currentStep == 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Select Date & Time'),
            content: Column(
              children: [
                // Date selection
                Text(
                  'Select Date',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppConstants.spacingSm),
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _dates.map((date) {
                      return Container(
                        margin: const EdgeInsets.only(right: AppConstants.spacingSm),
                        child: ChoiceChip(
                          label: Text(date),
                          selected: _selectedDate == date,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                // Time selection
                Text(
                  'Select Time',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppConstants.spacingSm),
                Wrap(
                  spacing: AppConstants.spacingSm,
                  runSpacing: AppConstants.spacingSm,
                  children: _times.map((time) {
                    return ChoiceChip(
                      label: Text(time),
                      selected: _selectedTime == time,
                      onSelected: (selected) {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            isActive: _currentStep == 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Patient Details'),
            content: Column(
              children: [
                Text(
                  'Select Patient',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppConstants.spacingSm),
                ..._patients.map((patient) {
                  return RadioListTile<String>(
                    title: Text(patient),
                    value: patient,
                    groupValue: _selectedPatient,
                    onChanged: (value) {
                      setState(() {
                        _selectedPatient = value!;
                      });
                    },
                  );
                }).toList(),
                const SizedBox(height: AppConstants.spacingMd),
                ElevatedButton(
                  onPressed: () {
                    // Add new patient
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Adding new patient...')),
                    );
                  },
                  child: const Text('Add New Patient'),
                ),
              ],
            ),
            isActive: _currentStep == 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Review & Payment'),
            content: Column(
              children: [
                // Test details
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
                        widget.test.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: AppConstants.spacingXs),
                      Text(
                        widget.test.category,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                      ),
                      const SizedBox(height: AppConstants.spacingMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '\$${widget.test.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                // Collection details
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
                        'Collection Details',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: AppConstants.spacingMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Type',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            _selectedCollectionType,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.spacingXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date & Time',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '$_selectedDate at $_selectedTime',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.spacingXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Patient',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            _selectedPatient,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMd),
                // Total
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingMd),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '\$${widget.test.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            isActive: _currentStep == 3,
            state: StepState.indexed,
          ),
        ],
      ),
    );
  }
}

class SampleCollectionBookingScreen extends StatelessWidget {
  const SampleCollectionBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Sample Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Home Sample Collection',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              'Our phlebotomist will visit your home at the scheduled time to collect samples.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingLg),

            // Benefits
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
                    'Why Home Collection?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  _buildBenefitItem(
                    context,
                    icon: Icons.home,
                    title: 'Convenience',
                    description: 'No need to visit a lab center',
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  _buildBenefitItem(
                    context,
                    icon: Icons.access_time,
                    title: 'Flexible Timing',
                    description: 'Choose your preferred time slot',
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  _buildBenefitItem(
                    context,
                    icon: Icons.security,
                    title: 'Safe & Hygienic',
                    description: 'Trained professionals with safety protocols',
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Book button
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              child: ElevatedButton(
                onPressed: () {
                  // Proceed to test selection
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceeding to test selection...')),
                  );
                },
                child: const Text('Select Tests'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingSm),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.blue,
            size: AppConstants.iconMd,
          ),
        ),
        const SizedBox(width: AppConstants.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingXs),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TestReportViewerScreen extends StatelessWidget {
  final TestReport report;

  const TestReportViewerScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${report.testName} Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Download report
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading report...')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share report
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing report...')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              '${report.testName} Report',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Completed on ${report.date}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            if (report.hasAbnormalValues) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingMd,
                  vertical: AppConstants.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                ),
                child: const Text(
                  'This report contains abnormal values. Please consult your doctor.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // View full report
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Viewing full report...')),
                );
              },
              icon: const Icon(Icons.visibility),
              label: const Text('View Full Report'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
      ),
      body: Padding(
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
              'Sample Collection Booked!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: AppConstants.spacingSm),

            Text(
              'Our phlebotomist will visit your home on Nov 21 at 10:00 AM',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),

            const SizedBox(height: AppConstants.spacingXxl),

            // Booking details
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
                    'Booking Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  _buildDetailRow(context, 'Test', 'Complete Blood Count'),
                  const SizedBox(height: AppConstants.spacingXs),
                  _buildDetailRow(context, 'Date & Time', 'Nov 21, 2023 at 10:00 AM'),
                  const SizedBox(height: AppConstants.spacingXs),
                  _buildDetailRow(context, 'Collection Type', 'Home Collection'),
                  const SizedBox(height: AppConstants.spacingXs),
                  _buildDetailRow(context, 'Patient', 'John Smith'),
                  const SizedBox(height: AppConstants.spacingXs),
                  _buildDetailRow(context, 'Amount', '\$49.99'),
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
                      // View booking
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Viewing booking...')),
                      );
                    },
                    child: const Text('View Booking'),
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  OutlinedButton(
                    onPressed: () {
                      // Back to home
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}