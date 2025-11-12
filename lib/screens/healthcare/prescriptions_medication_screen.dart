import 'package:flutter/material.dart';
import '../../core/constants.dart';

class PrescriptionsMedicationScreen extends StatefulWidget {
  const PrescriptionsMedicationScreen({super.key});

  @override
  State<PrescriptionsMedicationScreen> createState() =>
      _PrescriptionsMedicationScreenState();
}

class _PrescriptionsMedicationScreenState
    extends State<PrescriptionsMedicationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Prescriptions', 'My Medications', 'Schedule'];

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

  void _orderMedicines() {
    // Navigate to pharmacy order flow
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to pharmacy order flow...')),
    );
  }

  void _scanBarcode() {
    // Open barcode scanner
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening barcode scanner...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescriptions & Medications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: _scanBarcode,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _orderMedicines,
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
                _buildMyMedicationsTab(),
                _buildScheduleTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _orderMedicines,
        icon: const Icon(Icons.local_pharmacy),
        label: const Text('Order Medicines'),
        backgroundColor: Theme.of(context).primaryColor,
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
          _buildPrescriptionCard(
            doctor: 'Dr. Sarah Johnson',
            specialty: 'Cardiologist',
            date: 'Nov 15, 2023',
            medications: [
              Medication(
                name: 'Lisinopril',
                dosage: '10mg',
                frequency: 'Once daily',
                duration: '30 days',
                refills: 2,
              ),
              Medication(
                name: 'Atorvastatin',
                dosage: '20mg',
                frequency: 'Once daily at bedtime',
                duration: '30 days',
                refills: 1,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildPrescriptionCard(
            doctor: 'Dr. Michael Chen',
            specialty: 'General Physician',
            date: 'Oct 28, 2023',
            medications: [
              Medication(
                name: 'Amoxicillin',
                dosage: '500mg',
                frequency: 'Three times daily',
                duration: '7 days',
                refills: 0,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildPrescriptionCard(
            doctor: 'Dr. Emily Roberts',
            specialty: 'Pain Management',
            date: 'Oct 10, 2023',
            medications: [
              Medication(
                name: 'Ibuprofen',
                dosage: '400mg',
                frequency: 'As needed',
                duration: '14 days',
                refills: 3,
              ),
              Medication(
                name: 'Acetaminophen',
                dosage: '500mg',
                frequency: 'As needed',
                duration: '14 days',
                refills: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyMedicationsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh medications
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          _buildMedicationCard(
            name: 'Lisinopril',
            dosage: '10mg',
            frequency: 'Once daily',
            nextRefill: 'Dec 15, 2023',
            reminderEnabled: true,
            isControlled: false,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildMedicationCard(
            name: 'Atorvastatin',
            dosage: '20mg',
            frequency: 'Once daily at bedtime',
            nextRefill: 'Dec 15, 2023',
            reminderEnabled: true,
            isControlled: false,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildMedicationCard(
            name: 'Ibuprofen',
            dosage: '400mg',
            frequency: 'As needed',
            nextRefill: 'Nov 24, 2023',
            reminderEnabled: false,
            isControlled: false,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          _buildMedicationCard(
            name: 'Acetaminophen',
            dosage: '500mg',
            frequency: 'As needed',
            nextRefill: 'Nov 24, 2023',
            reminderEnabled: false,
            isControlled: false,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's date
          Text(
            'Today, Nov 20, 2023',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Morning medications
          Text(
            'Morning (8:00 AM)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          _buildScheduleItem(
            medication: 'Lisinopril 10mg',
            dosage: '1 tablet',
            taken: true,
          ),
          const SizedBox(height: AppConstants.spacingXs),
          _buildScheduleItem(
            medication: 'Atorvastatin 20mg',
            dosage: '1 tablet',
            taken: true,
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Afternoon medications
          Text(
            'Afternoon (1:00 PM)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          _buildScheduleItem(
            medication: 'Ibuprofen 400mg',
            dosage: '1 tablet',
            taken: false,
            asNeeded: true,
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Evening medications
          Text(
            'Evening (7:00 PM)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          _buildScheduleItem(
            medication: 'Acetaminophen 500mg',
            dosage: '1 tablet',
            taken: false,
            asNeeded: true,
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Bedtime medications
          Text(
            'Bedtime (10:00 PM)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          _buildScheduleItem(
            medication: 'Atorvastatin 20mg',
            dosage: '1 tablet',
            taken: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionCard({
    required String doctor,
    required String specialty,
    required String date,
    required List<Medication> medications,
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
          // Doctor info
          Row(
            children: [
              CircleAvatar(
                radius: AppConstants.avatarSm,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.person,
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
                      doctor,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      specialty,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                date,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Medications list
          Column(
            children: medications.map((med) {
              return _buildMedicationItem(med);
            }).toList(),
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // View prescription
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing prescription...')),
                  );
                },
                child: const Text('View Details'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Order all medications
                  _orderMedicinesFromPrescription(medications);
                },
                child: const Text('Order All'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationItem(Medication medication) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.spacingXs,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Text(
                  '${medication.dosage} • ${medication.frequency}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Text(
                  '${medication.duration} • ${medication.refills} refills remaining',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              // Order this specific medication
              _orderSingleMedication(medication);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard({
    required String name,
    required String dosage,
    required String frequency,
    required String nextRefill,
    required bool reminderEnabled,
    required bool isControlled,
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
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              if (isControlled)
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
                    'Controlled',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingXs),

          Text(
            '$dosage • $frequency',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: AppConstants.spacingMd),

          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: AppConstants.iconSm,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
              const SizedBox(width: AppConstants.spacingXs),
              Text(
                'Next refill: $nextRefill',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
              const Spacer(),
              Switch(
                value: reminderEnabled,
                onChanged: (value) {
                  // Toggle reminder
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value
                            ? 'Reminder enabled for $name'
                            : 'Reminder disabled for $name',
                      ),
                    ),
                  );
                },
              ),
              Text(
                reminderEnabled ? 'On' : 'Off',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMd),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ElevatedButton(
                onPressed: () {
                  // Reorder medication
                  _reorderMedication(name);
                },
                child: const Text('Reorder'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem({
    required String medication,
    required String dosage,
    required bool taken,
    bool asNeeded = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingSm),
      decoration: BoxDecoration(
        color: taken
            ? Colors.green.withOpacity(0.1)
            : asNeeded
                ? Colors.orange.withOpacity(0.1)
                : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
        border: Border.all(
          color: taken
              ? Colors.green
              : asNeeded
                  ? Colors.orange
                  : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: taken
                  ? Colors.green
                  : asNeeded
                      ? Colors.orange
                      : Colors.transparent,
              border: Border.all(
                color: taken
                    ? Colors.green
                    : asNeeded
                        ? Colors.orange
                        : Colors.grey,
              ),
            ),
            child: taken
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: AppConstants.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        decoration: taken ? TextDecoration.lineThrough : null,
                      ),
                ),
                Text(
                  dosage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
              ],
            ),
          ),
          if (!taken)
            TextButton(
              onPressed: () {
                // Mark as taken
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Marked $medication as taken')),
                );
              },
              child: const Text('Take'),
            ),
        ],
      ),
    );
  }

  void _orderMedicinesFromPrescription(List<Medication> medications) {
    // Navigate to pharmacy order with these medications
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ordering ${medications.length} medications from prescription',
        ),
      ),
    );
  }

  void _orderSingleMedication(Medication medication) {
    // Navigate to pharmacy order with this medication
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ordering ${medication.name}'),
      ),
    );
  }

  void _reorderMedication(String medicationName) {
    // Reorder medication
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reordering $medicationName'),
      ),
    );
  }
}

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;
  final int refills;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.refills,
  });
}