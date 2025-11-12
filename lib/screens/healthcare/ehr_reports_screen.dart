import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class EhrReportsScreen extends StatefulWidget {
  const EhrReportsScreen({super.key});

  @override
  State<EhrReportsScreen> createState() => _EhrReportsScreenState();
}

class _EhrReportsScreenState extends State<EhrReportsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'Prescriptions',
    'Lab Reports',
    'Imaging',
    'History',
    'Vaccinations'
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

  void _uploadDocument() {
    // Show options for uploading documents
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening camera...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_upload),
                title: const Text('Upload File'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Uploading file...')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.qr_code_scanner),
                title: const Text('Scan Document'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Scanning document...')),
                  );
                },
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
        title: const Text('Health Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: _uploadDocument,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search functionality coming soon')),
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
                _buildPrescriptionsTab(),
                _buildLabReportsTab(),
                _buildImagingTab(),
                _buildHistoryTab(),
                _buildVaccinationsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh prescriptions
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          _buildDocumentCard(
            title: 'Prescription for Hypertension',
            date: 'Nov 15, 2023',
            provider: 'Dr. Sarah Johnson',
            type: 'Prescription',
            medications: ['Lisinopril 10mg', 'Atorvastatin 20mg'],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDocumentCard(
            title: 'Antibiotic Prescription',
            date: 'Oct 28, 2023',
            provider: 'Dr. Michael Chen',
            type: 'Prescription',
            medications: ['Amoxicillin 500mg'],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDocumentCard(
            title: 'Pain Management',
            date: 'Oct 10, 2023',
            provider: 'Dr. Emily Roberts',
            type: 'Prescription',
            medications: ['Ibuprofen 400mg', 'Acetaminophen 500mg'],
          ),
        ],
      ),
    );
  }

  Widget _buildLabReportsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh lab reports
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          _buildDocumentCard(
            title: 'Complete Blood Count',
            date: 'Nov 12, 2023',
            provider: 'City Lab Services',
            type: 'Lab Report',
            hasAbnormalValues: true,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDocumentCard(
            title: 'Lipid Profile',
            date: 'Oct 25, 2023',
            provider: 'General Diagnostics',
            type: 'Lab Report',
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDocumentCard(
            title: 'Thyroid Function',
            date: 'Sep 30, 2023',
            provider: 'Metropolitan Labs',
            type: 'Lab Report',
          ),
        ],
      ),
    );
  }

  Widget _buildImagingTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh imaging reports
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          _buildDocumentCard(
            title: 'Chest X-Ray',
            date: 'Nov 5, 2023',
            provider: 'Radiology Center',
            type: 'Imaging',
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDocumentCard(
            title: 'MRI Brain',
            date: 'Oct 18, 2023',
            provider: 'Advanced Imaging',
            type: 'Imaging',
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildDocumentCard(
            title: 'Ultrasound Abdomen',
            date: 'Sep 22, 2023',
            provider: 'Diagnostic Imaging',
            type: 'Imaging',
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh history
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          _buildHistoryCard(
            title: 'Cardiology Consultation',
            date: 'Nov 15, 2023',
            provider: 'Dr. Sarah Johnson',
            diagnosis: 'Hypertension Management',
            status: 'Completed',
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildHistoryCard(
            title: 'Annual Physical Exam',
            date: 'Oct 28, 2023',
            provider: 'Dr. Michael Chen',
            diagnosis: 'Routine Checkup',
            status: 'Completed',
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildHistoryCard(
            title: 'Dermatology Visit',
            date: 'Oct 10, 2023',
            provider: 'Dr. Emily Roberts',
            diagnosis: 'Skin Rash Evaluation',
            status: 'Completed',
          ),
        ],
      ),
    );
  }

  Widget _buildVaccinationsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh vaccinations
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          _buildVaccinationCard(
            vaccine: 'Influenza (Flu)',
            date: 'Oct 15, 2023',
            provider: 'City Health Clinic',
            nextDue: 'Oct 15, 2024',
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildVaccinationCard(
            vaccine: 'COVID-19 Booster',
            date: 'Sep 20, 2023',
            provider: 'Public Health Center',
            nextDue: 'Not scheduled',
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildVaccinationCard(
            vaccine: 'Tetanus-Diphtheria',
            date: 'Aug 5, 2023',
            provider: 'Travel Medicine Clinic',
            nextDue: 'Aug 5, 2033',
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required String date,
    required String provider,
    required String type,
    List<String>? medications,
    bool hasAbnormalValues = false,
  }) {
    return Container(
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
          // Header with type indicator
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingSm,
                  vertical: AppConstants.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: _getTypeColor(type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                ),
                child: Text(
                  type,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: _getTypeColor(type),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Spacer(),
              if (hasAbnormalValues)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingSm,
                    vertical: AppConstants.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                  ),
                  child: Text(
                    'Abnormal Values',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Document title
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: AppConstants.spacingXs),
          
          // Provider and date
          Text(
            '$provider • $date',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Medications (for prescriptions)
          if (medications != null && medications.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medications:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Wrap(
                  spacing: AppConstants.spacingXs,
                  runSpacing: AppConstants.spacingXs,
                  children: medications.map((med) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacingSm,
                        vertical: AppConstants.spacingXs,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                      ),
                      child: Text(
                        med,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppConstants.spacingMd),
              ],
            ),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // View document
                  _viewDocument(title, type);
                },
                child: const Text('View'),
              ),
              TextButton(
                onPressed: () {
                  // Share document
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sharing document...')),
                  );
                },
                child: const Text('Share'),
              ),
              TextButton(
                onPressed: () {
                  // Download document
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading document...')),
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

  Widget _buildHistoryCard({
    required String title,
    required String date,
    required String provider,
    required String diagnosis,
    required String status,
  }) {
    return Container(
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
          // Title and status
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingSm,
                  vertical: AppConstants.spacingXs,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                ),
                child: Text(
                  status,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacingXs),
          
          // Provider and date
          Text(
            '$provider • $date',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Diagnosis
          Text(
            'Diagnosis: $diagnosis',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // View details
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing details...')),
                  );
                },
                child: const Text('Details'),
              ),
              TextButton(
                onPressed: () {
                  // Add note
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adding note...')),
                  );
                },
                child: const Text('Add Note'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVaccinationCard({
    required String vaccine,
    required String date,
    required String provider,
    required String nextDue,
  }) {
    return Container(
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
          // Vaccine name
          Text(
            vaccine,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Details row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Administered',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      date,
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
                      'Next Due',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      nextDue,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: nextDue == 'Not scheduled' 
                                ? Theme.of(context).textTheme.bodySmall?.color 
                                : Theme.of(context).primaryColor,
                            fontWeight: nextDue == 'Not scheduled' 
                                ? FontWeight.normal 
                                : FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Provider
          Text(
            'Provider: $provider',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
          
          const SizedBox(height: AppConstants.spacingMd),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // View certificate
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing certificate...')),
                  );
                },
                child: const Text('Certificate'),
              ),
              TextButton(
                onPressed: () {
                  // Set reminder
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Setting reminder...')),
                  );
                },
                child: const Text('Remind Me'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Prescription':
        return Colors.blue;
      case 'Lab Report':
        return Colors.green;
      case 'Imaging':
        return Colors.purple;
      default:
        return Theme.of(context).primaryColor;
    }
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

  void _viewDocument(String title, String type) {
    // Navigate to document viewer
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DocumentViewerScreen(
          title: title,
          type: type,
        ),
      ),
    );
  }
}

class DocumentViewerScreen extends StatelessWidget {
  final String title;
  final String type;

  const DocumentViewerScreen({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing document...')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading document...')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.print),
                          title: const Text('Print'),
                          onTap: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Printing document...')),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.edit),
                          title: const Text('Annotate'),
                          onTap: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Opening annotation tools...')),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete),
                          title: const Text('Delete'),
                          onTap: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Deleting document...')),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
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
              _getDocumentIcon(type),
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              type,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Simulate opening document
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening document viewer...')),
                );
              },
              icon: const Icon(Icons.visibility),
              label: const Text('View Document'),
            ),
            const SizedBox(height: 15),
            Text(
              'Document viewer with zoom, annotate, and search features',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDocumentIcon(String type) {
    switch (type) {
      case 'Prescription':
        return Icons.assignment;
      case 'Lab Report':
        return Icons.biotech;
      case 'Imaging':
        return Icons.camera_alt;
      default:
        return Icons.description;
    }
  }
}