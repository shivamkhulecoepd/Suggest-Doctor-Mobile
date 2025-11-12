import 'package:flutter/material.dart';

class BookingFlowScreen extends StatefulWidget {
  const BookingFlowScreen({super.key});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  int _currentStep = 0;
  final List<String> _steps = [
    'Select Mode',
    'Choose Clinic',
    'Pick Slot',
    'Patient Info',
    'Add-ons',
    'Payment',
  ];
  
  // Booking data
  String _selectedMode = 'In-Clinic';
  String _selectedClinic = 'City Heart Clinic';
  String _selectedDate = 'Tomorrow';
  String _selectedTime = '10:00 AM';
  Map<String, dynamic> _patientInfo = {
    'name': 'John Doe',
    'age': 35,
    'gender': 'Male',
    'symptoms': '',
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        onStepTapped: (step) {
          // Only allow tapping previous steps
          if (step < _currentStep) {
            setState(() {
              _currentStep = step;
            });
          }
        },
        steps: [
          _buildStep(
            title: 'Select Mode',
            content: _buildModeSelection(),
          ),
          _buildStep(
            title: 'Choose Clinic',
            content: _buildClinicSelection(),
          ),
          _buildStep(
            title: 'Pick Slot',
            content: _buildSlotSelection(),
          ),
          _buildStep(
            title: 'Patient Info',
            content: _buildPatientInfo(),
          ),
          _buildStep(
            title: 'Add-ons',
            content: _buildAddons(),
          ),
          _buildStep(
            title: 'Payment',
            content: _buildPayment(),
          ),
        ],
      ),
    );
  }
  
  Step _buildStep({required String title, required Widget content}) {
    return Step(
      title: Text(title),
      content: content,
      isActive: _steps.indexOf(title) == _currentStep,
      state: _steps.indexOf(title) < _currentStep 
          ? StepState.complete 
          : _steps.indexOf(title) == _currentStep 
              ? StepState.editing 
              : StepState.indexed,
    );
  }
  
  Widget _buildModeSelection() {
    return Column(
      children: [
        _ModeOption(
          title: 'In-Clinic',
          subtitle: 'Visit the doctor at clinic',
          icon: Icons.local_hospital,
          selected: _selectedMode == 'In-Clinic',
          onTap: () {
            setState(() {
              _selectedMode = 'In-Clinic';
            });
          },
        ),
        const SizedBox(height: 16),
        _ModeOption(
          title: 'Home Visit',
          subtitle: 'Doctor visits at your home',
          icon: Icons.home,
          selected: _selectedMode == 'Home Visit',
          onTap: () {
            setState(() {
              _selectedMode = 'Home Visit';
            });
          },
        ),
        const SizedBox(height: 16),
        _ModeOption(
          title: 'Video Consult',
          subtitle: 'Online video consultation',
          icon: Icons.video_call,
          selected: _selectedMode == 'Video Consult',
          onTap: () {
            setState(() {
              _selectedMode = 'Video Consult';
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildClinicSelection() {
    return Column(
      children: [
        _ClinicOption(
          name: 'City Heart Clinic',
          address: '123 Medical Street, Health District',
          rating: 4.5,
          distance: '2.5 km',
          selected: _selectedClinic == 'City Heart Clinic',
          onTap: () {
            setState(() {
              _selectedClinic = 'City Heart Clinic';
            });
          },
        ),
        const SizedBox(height: 16),
        _ClinicOption(
          name: 'MediCare Hospital',
          address: '456 Health Avenue, Medical Zone',
          rating: 4.8,
          distance: '1.8 km',
          selected: _selectedClinic == 'MediCare Hospital',
          onTap: () {
            setState(() {
              _selectedClinic = 'MediCare Hospital';
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildSlotSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date selection
        const Text(
          'Select Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _DateChip(
                date: 'Today',
                weekday: 'Mon',
                selected: _selectedDate == 'Today',
                onTap: () {
                  setState(() {
                    _selectedDate = 'Today';
                  });
                },
              ),
              const SizedBox(width: 8),
              _DateChip(
                date: 'Tomorrow',
                weekday: 'Tue',
                selected: _selectedDate == 'Tomorrow',
                onTap: () {
                  setState(() {
                    _selectedDate = 'Tomorrow';
                  });
                },
              ),
              const SizedBox(width: 8),
              _DateChip(
                date: 'Wed',
                weekday: '15 Jun',
                selected: _selectedDate == 'Wed',
                onTap: () {
                  setState(() {
                    _selectedDate = 'Wed';
                  });
                },
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Time slots
        const Text(
          'Available Slots',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _TimeSlot(
              time: '10:00 AM',
              type: _selectedMode,
              available: true,
              selected: _selectedTime == '10:00 AM',
              onTap: () {
                setState(() {
                  _selectedTime = '10:00 AM';
                });
              },
            ),
            _TimeSlot(
              time: '11:00 AM',
              type: _selectedMode,
              available: true,
              selected: _selectedTime == '11:00 AM',
              onTap: () {
                setState(() {
                  _selectedTime = '11:00 AM';
                });
              },
            ),
            _TimeSlot(
              time: '2:00 PM',
              type: _selectedMode,
              available: false,
              selected: _selectedTime == '2:00 PM',
              onTap: () {
                // Not available
              },
            ),
            _TimeSlot(
              time: '4:00 PM',
              type: _selectedMode,
              available: true,
              selected: _selectedTime == '4:00 PM',
              onTap: () {
                setState(() {
                  _selectedTime = '4:00 PM';
                });
              },
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildPatientInfo() {
    return Column(
      children: [
        TextFormField(
          initialValue: _patientInfo['name'],
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _patientInfo['name'] = value;
            });
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: _patientInfo['age'].toString(),
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _patientInfo['age'] = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _patientInfo['gender'],
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {
                  setState(() {
                    _patientInfo['gender'] = value!;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          initialValue: _patientInfo['symptoms'],
          decoration: const InputDecoration(
            labelText: 'Symptoms (Optional)',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          onChanged: (value) {
            setState(() {
              _patientInfo['symptoms'] = value;
            });
          },
        ),
      ],
    );
  }
  
  Widget _buildAddons() {
    return Column(
      children: [
        _AddonOption(
          title: 'Add Test',
          subtitle: 'Include diagnostic tests with your appointment',
          icon: Icons.biotech,
          selected: false,
          onTap: () {
            // Add test functionality
          },
        ),
        const SizedBox(height: 16),
        _AddonOption(
          title: 'Consultation Notes',
          subtitle: 'Add notes for the doctor',
          icon: Icons.note,
          selected: false,
          onTap: () {
            // Add notes functionality
          },
        ),
        const SizedBox(height: 16),
        _AddonOption(
          title: 'Attach Reports',
          subtitle: 'Upload previous medical reports',
          icon: Icons.attach_file,
          selected: false,
          onTap: () {
            // Attach reports functionality
          },
        ),
      ],
    );
  }
  
  Widget _buildPayment() {
    return Column(
      children: [
        // Fee breakdown
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Column(
            children: [
              _FeeItem(
                label: 'Consultation Fee',
                amount: '\$50',
              ),
              const Divider(),
              _FeeItem(
                label: 'Booking Fee',
                amount: '\$5',
              ),
              const Divider(),
              _FeeItem(
                label: 'Total',
                amount: '\$55',
                isTotal: true,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Payment methods
        const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _PaymentMethod(
          name: 'Credit Card',
          icon: Icons.credit_card,
          selected: true,
          onTap: () {
            // Payment method selection
          },
        ),
        const SizedBox(height: 8),
        _PaymentMethod(
          name: 'Debit Card',
          icon: Icons.credit_card,
          selected: false,
          onTap: () {
            // Payment method selection
          },
        ),
        const SizedBox(height: 8),
        _PaymentMethod(
          name: 'UPI',
          icon: Icons.account_balance,
          selected: false,
          onTap: () {
            // Payment method selection
          },
        ),
        
        const SizedBox(height: 24),
        
        // Coupon code
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Coupon Code (Optional)',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.local_offer),
          ),
        ),
      ],
    );
  }
  
  void _onStepContinue() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      // Final step - complete booking
      _completeBooking();
    }
  }
  
  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    } else {
      Navigator.pop(context);
    }
  }
  
  void _completeBooking() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Confirmed'),
          content: const Text('Your appointment has been successfully booked!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Close booking flow
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// UI Components
class _ModeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  
  const _ModeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: selected
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  icon,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClinicOption extends StatelessWidget {
  final String name;
  final String address;
  final double rating;
  final String distance;
  final bool selected;
  final VoidCallback onTap;
  
  const _ClinicOption({
    required this.name,
    required this.address,
    required this.rating,
    required this.distance,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: selected
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.local_hospital,
                  color: Color(0xFF2196F3),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          distance,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final String date;
  final String weekday;
  final bool selected;
  final VoidCallback onTap;
  
  const _DateChip({
    required this.date,
    required this.weekday,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            weekday,
            style: TextStyle(
              fontSize: 12,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      selected: selected,
      onSelected: (selected) {
        if (selected) onTap();
      },
      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      backgroundColor: Theme.of(context).cardColor,
      labelStyle: TextStyle(
        color: selected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).dividerColor,
        ),
      ),
    );
  }
}

class _TimeSlot extends StatelessWidget {
  final String time;
  final String type;
  final bool available;
  final bool selected;
  final VoidCallback onTap;
  
  const _TimeSlot({
    required this.time,
    required this.type,
    required this.available,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!available) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          time,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      );
    }
    
    return ChoiceChip(
      label: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time),
          Text(
            type,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
      selected: selected,
      onSelected: (selected) {
        if (selected) onTap();
      },
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).cardColor,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class _AddonOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  
  const _AddonOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.check_box : Icons.check_box_outline_blank,
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeeItem extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;
  
  const _FeeItem({
    required this.label,
    required this.amount,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethod extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  
  const _PaymentMethod({
    required this.name,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 2 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: selected
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (selected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}