import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suggest_doctor/core/responsive.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../widgets/network_image_widget.dart';
import '../../core/constants.dart';

class AppointmentsScreenNew extends StatefulWidget {
  const AppointmentsScreenNew({super.key});

  @override
  State<AppointmentsScreenNew> createState() => _AppointmentsScreenNewState();
}

class _AppointmentsScreenNewState extends State<AppointmentsScreenNew>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isCalendarView = false;
  DateTime _selectedDate = DateTime.now();
  Map<String, dynamic> _currentFilters = {
    'consultationType': 'All Types',
    'specialty': 'All Specialties',
    'dateRange': 'All Time',
  };

  final List<Map<String, dynamic>> _mockAppointments = [
    {
      "id": 1,
      "doctorName": "Dr. Sarah Johnson",
      "specialty": "Gynecologist",
      "consultationType": "Video",
      "dateTime": DateTime.now().add(const Duration(hours: 2)),
      "status": "confirmed",
      "doctorImage":
          "https://images.unsplash.com/photo-1659353887233-05d1180eb691",
      "semanticLabel":
          "Professional headshot of a female doctor with short blonde hair wearing a white medical coat and stethoscope",
      "fee": "₹499",
      "symptoms": ["Irregular periods", "Abdominal pain"],
    },
    {
      "id": 2,
      "doctorName": "Dr. Michael Chen",
      "specialty": "Pediatrician",
      "consultationType": "Clinic",
      "dateTime": DateTime.now().add(const Duration(days: 1, hours: 3)),
      "status": "confirmed",
      "doctorImage":
          "https://img.rocket.new/generatedImages/rocket_gen_img_154cf9514-1762273978819.png",
      "semanticLabel":
          "Professional portrait of an Asian male doctor with dark hair wearing glasses and a white medical coat",
      "fee": "₹799",
      "symptoms": ["Child fever", "Cough"],
    },
    {
      "id": 3,
      "doctorName": "Dr. Priya Sharma",
      "specialty": "Cardiologist",
      "consultationType": "Home Visit",
      "dateTime": DateTime.now().add(const Duration(days: 2)),
      "status": "confirmed",
      "doctorImage":
          "https://images.unsplash.com/photo-1666887360476-7eaa054d1abd",
      "semanticLabel":
          "Professional photo of an Indian female doctor with long dark hair wearing a white medical coat with a stethoscope around her neck",
      "fee": "₹1299",
      "symptoms": ["Chest pain", "High blood pressure"],
    },
    {
      "id": 4,
      "doctorName": "Dr. Robert Wilson",
      "specialty": "Dentist",
      "consultationType": "Video",
      "dateTime": DateTime.now().subtract(const Duration(days: 3)),
      "status": "completed",
      "doctorImage":
          "https://img.rocket.new/generatedImages/rocket_gen_img_1456d520e-1762274360201.png",
      "semanticLabel":
          "Professional headshot of a middle-aged Caucasian male dentist with gray hair wearing a white dental coat",
      "fee": "₹699",
      "symptoms": ["Tooth pain", "Gum bleeding"],
    },
    {
      "id": 5,
      "doctorName": "Dr. Anjali Patel",
      "specialty": "Dermatologist",
      "consultationType": "Chat",
      "dateTime": DateTime.now().subtract(const Duration(days: 7)),
      "status": "completed",
      "doctorImage":
          "https://img.rocket.new/generatedImages/rocket_gen_img_10be715ed-1762274654067.png",
      "semanticLabel":
          "Professional portrait of an Indian female dermatologist with shoulder-length dark hair wearing a white medical coat",
      "fee": "₹299",
      "symptoms": ["Skin rash", "Acne"],
    },
    {
      "id": 6,
      "doctorName": "Dr. James Thompson",
      "specialty": "Orthopedic",
      "consultationType": "Clinic",
      "dateTime": DateTime.now().subtract(const Duration(days: 14)),
      "status": "cancelled",
      "doctorImage":
          "https://img.rocket.new/generatedImages/rocket_gen_img_10bba829f-1762274249288.png",
      "semanticLabel":
          "Professional photo of a Caucasian male orthopedic surgeon with brown hair wearing surgical scrubs",
      "fee": "₹999",
      "symptoms": ["Back pain", "Joint stiffness"],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        // title: 'Appointments',
        title: Text(
          'Appointments',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        // variant: CustomAppBarVariant.withActions,
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 8)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isCalendarView ? Icons.view_list : Icons.calendar_today,
                color: Theme.of(context).colorScheme.primary,
                size: Responsive.size(context, 24),
              ),
            ),
            onPressed: () {
              setState(() {
                _isCalendarView = !_isCalendarView;
              });
            },
            tooltip: _isCalendarView ? 'List View' : 'Calendar View',
          ),
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(Responsive.spacing(context, 8)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.filter_list,
                color: Theme.of(context).colorScheme.primary,
                size: Responsive.size(context, 24),
              ),
            ),
            onPressed: _showFilterBottomSheet,
            tooltip: 'Filter',
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: _isCalendarView ? _buildCalendarView() : _buildListView(),
    );
  }

  Widget _buildListView() {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildUpcomingAppointments(), _buildPastAppointments()],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    return CalendarViewWidget(
      appointments: _getFilteredAppointments(),
      onDateSelected: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
      selectedDate: _selectedDate,
    );
  }

  Widget _buildTabBar() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final upcomingCount = _getUpcomingAppointments().length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(1.w),
        labelColor: Colors.white,
        unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.7),
        labelStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Upcoming'),
                if (upcomingCount > 0) ...[
                  SizedBox(width: 2.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: LightColors.warning,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      upcomingCount.toString(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Tab(text: 'Past'),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    final upcomingAppointments = _getUpcomingAppointments();

    if (upcomingAppointments.isEmpty) {
      return _buildEmptyState(
        'No Upcoming Appointments',
        'You don\'t have any scheduled appointments. Book a consultation with our expert doctors.',
        'Book Appointment',
        () => Navigator.pushNamed(context, '/booking-screen'),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshAppointments,
      color: LightColors.primary,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 1.h, bottom: 10.h),
        itemCount: upcomingAppointments.length,
        itemBuilder: (context, index) {
          final appointment = upcomingAppointments[index];
          return AppointmentCardWidget(
            appointment: appointment,
            isUpcoming: true,
            onReschedule: () => _rescheduleAppointment(appointment),
            onCancel: () => _cancelAppointment(appointment),
            onJoin: () => _joinConsultation(appointment),
            onContact: () => _contactDoctor(appointment),
          );
        },
      ),
    );
  }

  Widget _buildPastAppointments() {
    final pastAppointments = _getPastAppointments();

    if (pastAppointments.isEmpty) {
      return _buildEmptyState(
        'No Past Appointments',
        'Your consultation history will appear here once you complete your first appointment.',
        'Browse Doctors',
        () => Navigator.pushNamed(context, '/home-screen'),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshAppointments,
      color: LightColors.primary,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 1.h, bottom: 10.h),
        itemCount: pastAppointments.length,
        itemBuilder: (context, index) {
          final appointment = pastAppointments[index];
          return AppointmentCardWidget(
            appointment: appointment,
            isUpcoming: false,
            onBookAgain: () => _bookAgain(appointment),
            onViewDetails: () => _viewAppointmentDetails(appointment),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(
    String title,
    String description,
    String buttonText,
    VoidCallback onPressed,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Icons.event_note,
                  color: colorScheme.primary,
                  size: 48,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: onPressed,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  buttonText,
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

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => AppointmentFilterWidget(
          currentFilters: _currentFilters,
          onFiltersChanged: (filters) {
            setState(() {
              _currentFilters = filters;
            });
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredAppointments() {
    List<Map<String, dynamic>> filtered = List.from(_mockAppointments);

    // Apply consultation type filter
    if (_currentFilters['consultationType'] != 'All Types') {
      filtered = filtered
          .where(
            (appointment) =>
                (appointment['consultationType'] as String?) ==
                _currentFilters['consultationType'],
          )
          .toList();
    }

    // Apply specialty filter
    if (_currentFilters['specialty'] != 'All Specialties') {
      filtered = filtered
          .where(
            (appointment) =>
                (appointment['specialty'] as String?) ==
                _currentFilters['specialty'],
          )
          .toList();
    }

    // Apply date range filter
    if (_currentFilters['dateRange'] != 'All Time') {
      final now = DateTime.now();
      DateTime? startDate;

      switch (_currentFilters['dateRange']) {
        case 'Today':
          startDate = DateTime(now.year, now.month, now.day);
          filtered = filtered.where((appointment) {
            final appointmentDate = appointment['dateTime'] as DateTime;
            return appointmentDate.isAfter(startDate!) &&
                appointmentDate.isBefore(
                  startDate.add(const Duration(days: 1)),
                );
          }).toList();
          break;
        case 'This Week':
          startDate = now.subtract(Duration(days: now.weekday - 1));
          filtered = filtered.where((appointment) {
            final appointmentDate = appointment['dateTime'] as DateTime;
            return appointmentDate.isAfter(startDate!) &&
                appointmentDate.isBefore(
                  startDate.add(const Duration(days: 7)),
                );
          }).toList();
          break;
        case 'This Month':
          startDate = DateTime(now.year, now.month, 1);
          filtered = filtered.where((appointment) {
            final appointmentDate = appointment['dateTime'] as DateTime;
            return appointmentDate.month == now.month &&
                appointmentDate.year == now.year;
          }).toList();
          break;
        case 'Last 3 Months':
          startDate = DateTime(now.year, now.month - 3, now.day);
          filtered = filtered.where((appointment) {
            final appointmentDate = appointment['dateTime'] as DateTime;
            return appointmentDate.isAfter(startDate!);
          }).toList();
          break;
        case 'Last 6 Months':
          startDate = DateTime(now.year, now.month - 6, now.day);
          filtered = filtered.where((appointment) {
            final appointmentDate = appointment['dateTime'] as DateTime;
            return appointmentDate.isAfter(startDate!);
          }).toList();
          break;
      }
    }

    return filtered;
  }

  List<Map<String, dynamic>> _getUpcomingAppointments() {
    final now = DateTime.now();
    return _getFilteredAppointments()
        .where(
          (appointment) => (appointment['dateTime'] as DateTime).isAfter(now),
        )
        .toList()
      ..sort(
        (a, b) =>
            (a['dateTime'] as DateTime).compareTo(b['dateTime'] as DateTime),
      );
  }

  List<Map<String, dynamic>> _getPastAppointments() {
    final now = DateTime.now();
    return _getFilteredAppointments()
        .where(
          (appointment) => (appointment['dateTime'] as DateTime).isBefore(now),
        )
        .toList()
      ..sort(
        (a, b) =>
            (b['dateTime'] as DateTime).compareTo(a['dateTime'] as DateTime),
      );
  }

  Future<void> _refreshAppointments() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Refresh appointments data
    });
  }

  void _rescheduleAppointment(Map<String, dynamic> appointment) {
    Navigator.pushNamed(context, '/booking-screen');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Redirecting to reschedule appointment with ${appointment['doctorName']}',
        ),
        backgroundColor: LightColors.warning,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _cancelAppointment(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Appointment'),
        content: Text(
          'Are you sure you want to cancel your appointment with ${appointment['doctorName']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Keep Appointment'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Appointment cancelled successfully'),
                  backgroundColor: LightColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            child: Text('Cancel Appointment'),
          ),
        ],
      ),
    );
  }

  void _joinConsultation(Map<String, dynamic> appointment) {
    final consultationType = appointment['consultationType'] as String;
    String route = '/home-screen';

    switch (consultationType.toLowerCase()) {
      case 'video':
        route = '/home-screen'; // Would be video consultation screen
        break;
      case 'chat':
        route = '/home-screen'; // Would be chat consultation screen
        break;
      default:
        route = '/home-screen';
    }

    Navigator.pushNamed(context, route);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Joining $consultationType consultation with ${appointment['doctorName']}',
        ),
        backgroundColor: LightColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _contactDoctor(Map<String, dynamic> appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contacting ${appointment['doctorName']}...'),
        backgroundColor: LightColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _bookAgain(Map<String, dynamic> appointment) {
    Navigator.pushNamed(context, '/doctor-profile-screen');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Booking another appointment with ${appointment['doctorName']}',
        ),
        backgroundColor: LightColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _viewAppointmentDetails(Map<String, dynamic> appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAppointmentDetailsModal(appointment),
    );
  }

  Widget _buildAppointmentDetailsModal(Map<String, dynamic> appointment) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final DateTime appointmentDate = appointment["dateTime"] as DateTime;
    final String doctorName = (appointment["doctorName"] as String?) ?? "";
    final String specialty = (appointment["specialty"] as String?) ?? "";
    final String consultationType =
        (appointment["consultationType"] as String?) ?? "";
    final String status = (appointment["status"] as String?) ?? "";
    final String fee = (appointment["fee"] as String?) ?? "";
    final List<String> symptoms = ((appointment["symptoms"] as List?) ?? [])
        .cast<String>();

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Appointment Details',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: colorScheme.outline.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.close,
                        color: colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem('Doctor', doctorName, theme, colorScheme),
                    _buildDetailItem(
                      'Specialty',
                      specialty,
                      theme,
                      colorScheme,
                    ),
                    _buildDetailItem(
                      'Consultation Type',
                      consultationType,
                      theme,
                      colorScheme,
                    ),
                    _buildDetailItem(
                      'Date & Time',
                      '${_formatDate(appointmentDate)} at ${_formatTime(appointmentDate)}',
                      theme,
                      colorScheme,
                    ),
                    _buildDetailItem('Status', status, theme, colorScheme),
                    _buildDetailItem('Fee', fee, theme, colorScheme),
                    if (symptoms.isNotEmpty) ...[
                      SizedBox(height: 3.h),
                      Text(
                        'Symptoms Discussed',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Wrap(
                        spacing: 2.w,
                        runSpacing: 1.h,
                        children: symptoms
                            .map(
                              (symptom) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: colorScheme.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  symptom,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    String label,
    String value,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30.w,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    if (appointmentDate == today) {
      return "Today";
    } else if (appointmentDate == today.add(const Duration(days: 1))) {
      return "Tomorrow";
    } else if (appointmentDate == today.subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return "${dateTime.day} ${months[dateTime.month - 1]}, ${dateTime.year}";
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
  }
}

enum CustomAppBarVariant {
  standard,
  withSearch,
  withProfile,
  withBackButton,
  withActions,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final CustomAppBarVariant variant;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final VoidCallback? onSearchTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    this.title,
    this.variant = CustomAppBarVariant.standard,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.onSearchTap,
    this.onProfileTap,
    this.onNotificationTap,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        title: title != null
            ? Text(
                title!,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: foregroundColor ?? colorScheme.onSurface,
                ),
              )
            : null,
        centerTitle: centerTitle,
        backgroundColor: Colors.transparent,
        foregroundColor: foregroundColor ?? colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: _buildLeading(context),
        actions: _buildActions(context),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    switch (variant) {
      case CustomAppBarVariant.withBackButton:
        return IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        );
      case CustomAppBarVariant.withProfile:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap:
                onProfileTap ??
                () => Navigator.pushNamed(context, '/profile-screen'),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow.withAlpha(26),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha(26),
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        );
      default:
        return automaticallyImplyLeading && Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Back',
              )
            : null;
    }
  }

  List<Widget>? _buildActions(BuildContext context) {
    if (actions != null) return actions;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case CustomAppBarVariant.withSearch:
        return [
          IconButton(
            icon: const Icon(Icons.search, size: 24),
            onPressed: onSearchTap ?? () {},
            tooltip: 'Search',
          ),
          const SizedBox(width: 8),
        ];

      case CustomAppBarVariant.withActions:
        return [
          IconButton(
            icon: const Icon(Icons.search, size: 24),
            onPressed: onSearchTap ?? () {},
            tooltip: 'Search',
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 24),
                onPressed: onNotificationTap ?? () {},
                tooltip: 'Notifications',
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 4),
            child: GestureDetector(
              onTap:
                  onProfileTap ??
                  () => Navigator.pushNamed(context, '/profile-screen'),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withAlpha(26),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: colorScheme.primary.withAlpha(26),
                  child: Icon(
                    Icons.person,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ];

      default:
        return null;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppointmentCardWidget extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final bool isUpcoming;
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;
  final VoidCallback? onJoin;
  final VoidCallback? onContact;
  final VoidCallback? onBookAgain;
  final VoidCallback? onViewDetails;

  const AppointmentCardWidget({
    super.key,
    required this.appointment,
    required this.isUpcoming,
    this.onReschedule,
    this.onCancel,
    this.onJoin,
    this.onContact,
    this.onBookAgain,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final String status = (appointment["status"] as String?) ?? "confirmed";
    final bool canJoin =
        isUpcoming &&
        status == "confirmed" &&
        _isWithinJoinWindow(appointment["dateTime"] as DateTime?);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMainContent(context, theme, colorScheme, canJoin),
          if (isUpcoming)
            _buildUpcomingActions(context, theme, colorScheme, canJoin),
          if (!isUpcoming) _buildPastActions(context, theme, colorScheme),
        ],
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    bool canJoin,
  ) {
    final DateTime appointmentDate = appointment["dateTime"] as DateTime;
    final String doctorName = (appointment["doctorName"] as String?) ?? "";
    final String specialty = (appointment["specialty"] as String?) ?? "";
    final String consultationType =
        (appointment["consultationType"] as String?) ?? "";
    final String status = (appointment["status"] as String?) ?? "confirmed";
    final String doctorImage = (appointment["doctorImage"] as String?) ?? "";
    final String semanticLabel =
        (appointment["semanticLabel"] as String?) ?? "";

    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 15.w,
                height: 15.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorScheme.primary.withValues(alpha: 0.1),
                ),
                child: doctorImage.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: NetworkImageWidget(
                          imageUrl: doctorImage,
                          width: 15.w,
                          height: 15.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.person,
                          color: colorScheme.primary,
                          size: 24,
                        ),
                      ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      specialty,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(context, theme, status, canJoin),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  context,
                  theme,
                  'calendar_today',
                  _formatDate(appointmentDate),
                  colorScheme,
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  context,
                  theme,
                  'access_time',
                  _formatTime(appointmentDate),
                  colorScheme,
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  context,
                  theme,
                  _getConsultationIcon(consultationType),
                  consultationType,
                  colorScheme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(
    BuildContext context,
    ThemeData theme,
    String status,
    bool canJoin,
  ) {
    final colorScheme = theme.colorScheme;

    Color badgeColor;
    String badgeText;

    if (canJoin) {
      badgeColor = LightColors.success;
      badgeText = "Ready to Join";
    } else {
      switch (status.toLowerCase()) {
        case 'confirmed':
          badgeColor = colorScheme.primary;
          badgeText = "Confirmed";
          break;
        case 'completed':
          badgeColor = LightColors.success;
          badgeText = "Completed";
          break;
        case 'cancelled':
          badgeColor = LightColors.error;
          badgeText = "Cancelled";
          break;
        case 'rescheduled':
          badgeColor = LightColors.warning;
          badgeText = "Rescheduled";
          break;
        default:
          badgeColor = colorScheme.outline;
          badgeText = status;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        badgeText,
        style: theme.textTheme.labelSmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    ThemeData theme,
    String iconName,
    String text,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Icon(_getIconData(iconName), color: colorScheme.primary, size: 16),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingActions(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    bool canJoin,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          if (canJoin) ...[
            Expanded(
              flex: 2,
              child: _buildActionButton(
                context,
                theme,
                "Join Consultation",
                LightColors.success,
                Colors.white,
                onJoin,
                isPrimary: true,
              ),
            ),
            SizedBox(width: 2.w),
          ],
          Expanded(
            child: _buildActionButton(
              context,
              theme,
              "Reschedule",
              Colors.transparent,
              colorScheme.primary,
              onReschedule,
              borderColor: colorScheme.primary,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: _buildActionButton(
              context,
              theme,
              "Cancel",
              Colors.transparent,
              LightColors.error,
              onCancel,
              borderColor: LightColors.error,
            ),
          ),
          SizedBox(width: 2.w),
          GestureDetector(
            onTap: onContact,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.phone, color: colorScheme.primary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastActions(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              context,
              theme,
              "Book Again",
              colorScheme.primary,
              Colors.white,
              onBookAgain,
              isPrimary: true,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: _buildActionButton(
              context,
              theme,
              "View Details",
              Colors.transparent,
              colorScheme.primary,
              onViewDetails,
              borderColor: colorScheme.primary,
            ),
          ),
          SizedBox(width: 2.w),
          GestureDetector(
            onTap: () => _downloadPrescription(context),
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.download, color: colorScheme.primary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    ThemeData theme,
    String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback? onPressed, {
    Color? borderColor,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: borderColor != null
                ? Border.all(color: borderColor, width: 1)
                : null,
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: backgroundColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: theme.textTheme.labelMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  bool _isWithinJoinWindow(DateTime? appointmentDateTime) {
    if (appointmentDateTime == null) return false;
    final now = DateTime.now();
    final difference = appointmentDateTime.difference(now).inMinutes;
    return difference <= 10 && difference >= -5;
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'calendar_today':
        return Icons.calendar_today;
      case 'access_time':
        return Icons.access_time;
      case 'videocam':
        return Icons.videocam;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'chat':
        return Icons.chat;
      case 'home':
        return Icons.home;
      case 'medical_services':
        return Icons.medical_services;
      case 'person':
        return Icons.person;
      case 'event_note':
        return Icons.event_note;
      case 'close':
        return Icons.close;
      case 'chevron_left':
        return Icons.chevron_left;
      case 'chevron_right':
        return Icons.chevron_right;
      case 'event_available':
        return Icons.event_available;
      case 'phone':
        return Icons.phone;
      case 'download':
        return Icons.download;
      default:
        return Icons.help;
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    if (appointmentDate == today) {
      return "Today";
    } else if (appointmentDate == today.add(const Duration(days: 1))) {
      return "Tomorrow";
    } else if (appointmentDate == today.subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return "${dateTime.day} ${months[dateTime.month - 1]}";
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
  }

  String _getConsultationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return 'videocam';
      case 'clinic':
        return 'local_hospital';
      case 'chat':
        return 'chat';
      case 'home visit':
        return 'home';
      default:
        return 'medical_services';
    }
  }

  void _downloadPrescription(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Prescription downloaded successfully'),
        backgroundColor: LightColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class AppointmentFilterWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onFiltersChanged;
  final Map<String, dynamic> currentFilters;

  const AppointmentFilterWidget({
    super.key,
    required this.onFiltersChanged,
    required this.currentFilters,
  });

  @override
  State<AppointmentFilterWidget> createState() =>
      _AppointmentFilterWidgetState();
}

class _AppointmentFilterWidgetState extends State<AppointmentFilterWidget> {
  late Map<String, dynamic> _filters;

  final List<String> _consultationTypes = [
    'All Types',
    'Video',
    'Clinic',
    'Chat',
    'Home Visit',
  ];

  final List<String> _specialties = [
    'All Specialties',
    'Gynecologist',
    'Pediatrician',
    'Cardiologist',
    'Dentist',
    'Orthopedic',
    'Dermatologist',
    'Neurologist',
    'General Physician',
  ];

  final List<String> _dateRanges = [
    'All Time',
    'Today',
    'This Week',
    'This Month',
    'Last 3 Months',
    'Last 6 Months',
  ];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context, colorScheme),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection(
                    context,
                    'Consultation Type',
                    'consultationType',
                    _consultationTypes,
                    colorScheme,
                  ),
                  SizedBox(height: 3.h),
                  _buildFilterSection(
                    context,
                    'Specialty',
                    'specialty',
                    _specialties,
                    colorScheme,
                  ),
                  SizedBox(height: 3.h),
                  _buildFilterSection(
                    context,
                    'Date Range',
                    'dateRange',
                    _dateRanges,
                    colorScheme,
                  ),
                  SizedBox(height: 4.h),
                  _buildActionButtons(context, colorScheme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Filter Appointments',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: colorScheme.outline.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.close, color: colorScheme.onSurface, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    String title,
    String filterKey,
    List<String> options,
    ColorScheme colorScheme,
  ) {
    final theme = Theme.of(context);
    final selectedValue = _filters[filterKey] as String? ?? options.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _filters[filterKey] = option;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primary : colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.outline.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  option,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected ? Colors.white : colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _clearFilters,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  'Clear All',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: _applyFilters,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Apply Filters',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _clearFilters() {
    setState(() {
      _filters = {
        'consultationType': 'All Types',
        'specialty': 'All Specialties',
        'dateRange': 'All Time',
      };
    });
  }

  void _applyFilters() {
    widget.onFiltersChanged(_filters);
    Navigator.pop(context);
  }
}

class CalendarViewWidget extends StatefulWidget {
  final List<Map<String, dynamic>> appointments;
  final Function(DateTime) onDateSelected;
  final DateTime selectedDate;

  const CalendarViewWidget({
    super.key,
    required this.appointments,
    required this.onDateSelected,
    required this.selectedDate,
  });

  @override
  State<CalendarViewWidget> createState() => _CalendarViewWidgetState();
}

class _CalendarViewWidgetState extends State<CalendarViewWidget> {
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDate;
  }

  // Helper to safely convert nullable TextStyle? to non-nullable TextStyle
  TextStyle _safeStyle(
    TextStyle? base, {
    Color? color,
    FontWeight? fontWeight,
  }) {
    return (base ?? const TextStyle()).copyWith(
      color: color,
      fontWeight: fontWeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCalendarHeader(context, colorScheme),
          _buildCalendar(context, colorScheme),
          _buildSelectedDateAppointments(context, colorScheme),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: colorScheme.primary, size: 24),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              'Appointment Calendar',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _calendarFormat = _calendarFormat == CalendarFormat.month
                    ? CalendarFormat.week
                    : CalendarFormat.month;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _calendarFormat == CalendarFormat.month ? 'Week' : 'Month',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: TableCalendar<Map<String, dynamic>>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        selectedDayPredicate: (day) {
          return isSameDay(widget.selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
          widget.onDateSelected(selectedDay);
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: _safeStyle(
            theme.textTheme.bodyMedium,
            color: colorScheme.onSurface,
          ),
          holidayTextStyle: _safeStyle(
            theme.textTheme.bodyMedium,
            color: LightColors.error,
          ),
          defaultTextStyle: _safeStyle(
            theme.textTheme.bodyMedium,
            color: colorScheme.onSurface,
          ),
          selectedTextStyle: _safeStyle(
            theme.textTheme.bodyMedium,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          todayTextStyle: _safeStyle(
            theme.textTheme.bodyMedium,
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          selectedDecoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          todayDecoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: LightColors.warning,
            shape: BoxShape.circle,
          ),
          markersMaxCount: 3,
          canMarkersOverflow: true,
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: colorScheme.onSurface,
            size: 20,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: colorScheme.onSurface,
            size: 20,
          ),
          titleTextStyle: _safeStyle(
            theme.textTheme.titleMedium,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: _safeStyle(
            theme.textTheme.labelMedium,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
          weekendStyle: _safeStyle(
            theme.textTheme.labelMedium,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedDateAppointments(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    final theme = Theme.of(context);
    final dayAppointments = _getEventsForDay(widget.selectedDate);

    if (dayAppointments.isEmpty) {
      return Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Icon(
              Icons.event_available,
              color: colorScheme.onSurface.withValues(alpha: 0.3),
              size: 48,
            ),
            SizedBox(height: 2.h),
            Text(
              'No appointments on this date',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointments on ${_formatSelectedDate(widget.selectedDate)}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 2.h),
          ...dayAppointments
              .map(
                (appointment) =>
                    _buildAppointmentItem(context, appointment, colorScheme),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(
    BuildContext context,
    Map<String, dynamic> appointment,
    ColorScheme colorScheme,
  ) {
    final theme = Theme.of(context);
    final DateTime appointmentTime = appointment["dateTime"] as DateTime;
    final String doctorName = (appointment["doctorName"] as String?) ?? "";
    final String consultationType =
        (appointment["consultationType"] as String?) ?? "";
    final String status = (appointment["status"] as String?) ?? "confirmed";

    Color statusColor;
    switch (status.toLowerCase()) {
      case 'confirmed':
        statusColor = colorScheme.primary;
        break;
      case 'completed':
        statusColor = LightColors.success;
        break;
      case 'cancelled':
        statusColor = LightColors.error;
        break;
      default:
        statusColor = LightColors.warning;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 12.w,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 14,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      _formatTime(appointmentTime),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Icon(
                      _getConsultationIcon(consultationType),
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 14,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      consultationType,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: theme.textTheme.labelSmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return widget.appointments.where((appointment) {
      final appointmentDate = appointment["dateTime"] as DateTime;
      return isSameDay(appointmentDate, day);
    }).toList();
  }

  String _formatSelectedDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return "${date.day} ${months[date.month - 1]}, ${date.year}";
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
  }

  IconData _getConsultationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return Icons.videocam;
      case 'clinic':
        return Icons.local_hospital;
      case 'chat':
        return Icons.chat;
      case 'home visit':
        return Icons.home;
      default:
        return Icons.medical_services;
    }
  }
}
