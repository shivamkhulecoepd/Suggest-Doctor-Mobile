import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../core/responsive.dart';
import '../../widgets/network_image_widget.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> with TickerProviderStateMixin {
  int _selectedTab = 0;
  final List<String> _tabs = ['Upcoming', 'Past', 'Cancelled'];
  late TabController _tabController;
  
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
  
  // Sample appointment data
  final List<Map<String, dynamic>> _upcomingAppointments = [
    {
      'id': '1',
      'doctor': 'Dr. John Smith',
      'specialty': 'Cardiologist',
      'date': 'Tomorrow',
      'time': '10:00 AM',
      'status': 'Confirmed',
      'clinic': 'City Heart Clinic',
      'fee': '\$50',
    },
    {
      'id': '2',
      'doctor': 'Dr. Sarah Johnson',
      'specialty': 'Dermatologist',
      'date': 'June 20, 2023',
      'time': '2:30 PM',
      'status': 'Confirmed',
      'clinic': 'Skin Care Center',
      'fee': '\$40',
    },
  ];
  
  final List<Map<String, dynamic>> _pastAppointments = [
    {
      'id': '3',
      'doctor': 'Dr. Michael Brown',
      'specialty': 'General Physician',
      'date': 'June 10, 2023',
      'time': '11:00 AM',
      'status': 'Completed',
      'clinic': 'Family Health Clinic',
      'fee': '\$35',
    },
  ];
  
  final List<Map<String, dynamic>> _cancelledAppointments = [
    {
      'id': '4',
      'doctor': 'Dr. Emily Davis',
      'specialty': 'Pediatrician',
      'date': 'June 5, 2023',
      'time': '3:00 PM',
      'status': 'Cancelled',
      'clinic': 'Children\'s Medical Center',
      'fee': '\$45',
    },
  ];

  List<Map<String, dynamic>> _getCurrentAppointments() {
    switch (_selectedTab) {
      case 0:
        return _upcomingAppointments;
      case 1:
        return _pastAppointments;
      case 2:
        return _cancelledAppointments;
      default:
        return _upcomingAppointments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointments = _getCurrentAppointments();
    
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Appointments',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 20),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
            ),
            tabs: _tabs.map((tab) => Tab(
              text: tab,
            )).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _AppointmentsList(
              appointments: _upcomingAppointments,
              onAppointmentTap: (appointment) {
                // Navigate to appointment details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentDetailsScreen(
                      appointment: appointment,
                    ),
                  ),
                );
              },
            ),
            _AppointmentsList(
              appointments: _pastAppointments,
              onAppointmentTap: (appointment) {
                // Navigate to appointment details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentDetailsScreen(
                      appointment: appointment,
                    ),
                  ),
                );
              },
            ),
            _AppointmentsList(
              appointments: _cancelledAppointments,
              onAppointmentTap: (appointment) {
                // Navigate to appointment details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentDetailsScreen(
                      appointment: appointment,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentsList extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;
  final Function(Map<String, dynamic>) onAppointmentTap;
  
  const _AppointmentsList({
    required this.appointments,
    required this.onAppointmentTap,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: Responsive.size(context, 60),
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(height: Responsive.spacing(context, 16)),
            Text(
              'No appointments found',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.spacing(context, 8)),
            Text(
              'Book your first appointment',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: Responsive.spacing(context, 24)),
            ElevatedButton(
              onPressed: () {
                // Navigate to booking screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.spacing(context, 24),
                  vertical: Responsive.spacing(context, 12),
                ),
              ),
              child: Text('Book Appointment',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                ),
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(Responsive.spacing(context, 16)),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _AppointmentCard(
          appointment: appointment,
          onTap: () => onAppointmentTap(appointment),
        );
      },
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final VoidCallback onTap;
  
  const _AppointmentCard({
    required this.appointment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (appointment['status']) {
      case 'Confirmed':
        statusColor = Colors.green;
        break;
      case 'Completed':
        statusColor = Colors.blue;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }
    
    return Card(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 16)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Responsive.size(context, 16)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Responsive.size(context, 16)),
        child: Padding(
          padding: EdgeInsets.all(Responsive.spacing(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor info
              Row(
                children: [
                  NetworkImageWidget(
                    imageUrl: 'https://via.placeholder.com/150',
                    width: Responsive.size(context, 50),
                    height: Responsive.size(context, 50),
                    isCircle: true,
                  ),
                  SizedBox(width: Responsive.spacing(context, 12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment['doctor'],
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Responsive.spacing(context, 4)),
                        Text(
                          appointment['specialty'],
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.spacing(context, 12), 
                      vertical: Responsive.spacing(context, 6)
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
                    ),
                    child: Text(
                      appointment['status'],
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: Responsive.spacing(context, 16)),
              
              // Appointment details
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: Responsive.size(context, 16),
                    color: Colors.grey,
                  ),
                  SizedBox(width: Responsive.spacing(context, 8)),
                  Text(
                    '${appointment['date']} at ${appointment['time']}',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.location_on,
                    size: Responsive.size(context, 16),
                    color: Colors.grey,
                  ),
                  SizedBox(width: Responsive.spacing(context, 4)),
                  Text(
                    appointment['clinic'],
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: Responsive.spacing(context, 16)),
              
              // Action buttons
              Row(
                children: [
                  if (appointment['status'] == 'Confirmed') ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Join video call
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 12)),
                        ),
                        child: Text('Join Video Call',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Responsive.spacing(context, 8)),
                  ],
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Reschedule
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                        ),
                        padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 12)),
                      ),
                      child: Text('Reschedule',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.spacing(context, 8)),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Cancel
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                        ),
                        padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 12)),
                      ),
                      child: Text('Cancel',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Appointment details screen
class AppointmentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> appointment;
  
  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.spacing(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appointment status card
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 20)),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Responsive.size(context, 16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: Responsive.size(context, 10),
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointment Status',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.spacing(context, 12), 
                          vertical: Responsive.spacing(context, 6)
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
                        ),
                        child: Text(
                          'Confirmed',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 12),
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: Responsive.spacing(context, 24)),
                  
                  // Doctor info
                  Row(
                    children: [
                      NetworkImageWidget(
                        imageUrl: 'https://via.placeholder.com/150',
                        width: Responsive.size(context, 60),
                        height: Responsive.size(context, 60),
                        isCircle: true,
                      ),
                      SizedBox(width: Responsive.spacing(context, 16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. John Smith',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 18),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 4)),
                            Text(
                              'Cardiologist',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 14),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            SizedBox(height: Responsive.spacing(context, 4)),
                            Text(
                              'City Heart Clinic',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: Responsive.spacing(context, 24)),
                  
                  // Appointment details
                  _DetailItem(
                    icon: Icons.calendar_today,
                    label: 'Date & Time',
                    value: 'Tomorrow, 10:00 AM',
                  ),
                  
                  SizedBox(height: Responsive.spacing(context, 16)),
                  
                  _DetailItem(
                    icon: Icons.attach_money,
                    label: 'Consultation Fee',
                    value: '\$50',
                  ),
                  
                  SizedBox(height: Responsive.spacing(context, 16)),
                  
                  _DetailItem(
                    icon: Icons.confirmation_number,
                    label: 'Booking ID',
                    value: 'BK-2023-001245',
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Responsive.spacing(context, 24)),
            
            // Additional information
            Text(
              'Additional Information',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: Responsive.spacing(context, 16)),
            
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoItem(
                    label: 'Symptoms',
                    value: 'Chest pain and shortness of breath',
                  ),
                  SizedBox(height: 12),
                  _InfoItem(
                    label: 'Notes',
                    value: 'Please bring previous ECG reports if available',
                  ),
                  SizedBox(height: 12),
                  _InfoItem(
                    label: 'Prescriptions',
                    value: 'No prescriptions available yet',
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Responsive.spacing(context, 24)),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Join video call
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 16)),
                    ),
                    child: Text(
                      'Join Video Call',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 12)),
                Container(
                  width: Responsive.size(context, 50),
                  height: Responsive.size(context, 50),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Responsive.size(context, 25)),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.phone,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      // Call clinic
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: Responsive.spacing(context, 16)),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Reschedule
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 16)),
                    ),
                    child: Text(
                      'Reschedule',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.spacing(context, 12)),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Cancel appointment
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Responsive.size(context, 12)),
                      ),
                      side: const BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 16)),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  
  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Responsive.size(context, 40),
          height: Responsive.size(context, 40),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
          ),
          child: Center(
            child: Icon(
              icon,
              size: Responsive.size(context, 20),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SizedBox(width: Responsive.spacing(context, 16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: Responsive.spacing(context, 4)),
              Text(
                value,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  
  const _InfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: Responsive.spacing(context, 4)),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
          ),
        ),
      ],
    );
  }
}