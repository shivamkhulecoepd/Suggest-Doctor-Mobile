import 'package:flutter/material.dart';

class VideoConsultationScreen extends StatefulWidget {
  const VideoConsultationScreen({super.key});

  @override
  State<VideoConsultationScreen> createState() => _VideoConsultationScreenState();
}

class _VideoConsultationScreenState extends State<VideoConsultationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controlsFadeController;
  bool _showControls = true;
  bool _isMuted = false;
  bool _isCameraOn = true;
  Offset _localVideoPosition = const Offset(20, 100);
  late AnimationController _localVideoAnimationController;

  @override
  void initState() {
    super.initState();
    _controlsFadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _localVideoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controlsFadeController.dispose();
    _localVideoAnimationController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _toggleCamera() {
    setState(() {
      _isCameraOn = !_isCameraOn;
    });
  }

  void _endCall() {
    // Navigate back to home or previous screen
    Navigator.of(context).pop();
  }

  void _openChat() {
    // Open chat functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening chat...')),
    );
  }

  void _shareScreen() {
    // Share screen functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing screen...')),
    );
  }

  void _addNotes() {
    // Add notes functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Adding notes...')),
    );
  }

  void _prescribe() {
    // Prescribe functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening prescription...')),
    );
  }

  void _openDrawer() {
    // Open side drawer with patient reports
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _buildSideDrawer(),
      body: Stack(
        children: [
          // Main doctor video feed
          Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_call,
                    size: 100,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Dr. Sarah Johnson',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Cardiologist',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
          ),
          
          // Local video overlay (draggable)
          Positioned(
            left: _localVideoPosition.dx,
            top: _localVideoPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _localVideoPosition = Offset(
                    _localVideoPosition.dx + details.delta.dx,
                    _localVideoPosition.dy + details.delta.dy,
                  );
                });
              },
              child: Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      // Local video placeholder
                      Container(
                        color: Colors.grey[800],
                        child: Center(
                          child: Icon(
                            _isCameraOn ? Icons.person : Icons.videocam_off,
                            size: 40,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      // Mute indicator
                      if (_isMuted)
                        const Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            Icons.mic_off,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Top bar with timer and connection indicator
          AnimatedOpacity(
            opacity: _showControls ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              height: 80,
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Connection indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.wifi, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Connected',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Call timer
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '12:45',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Doctor name
                  Text(
                    'Dr. Sarah Johnson',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom controls
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: _showControls ? 40 : -100,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute button
                  _buildControlButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    label: 'Mute',
                    onPressed: _toggleMute,
                    active: _isMuted,
                  ),
                  // Camera toggle
                  _buildControlButton(
                    icon: _isCameraOn ? Icons.videocam : Icons.videocam_off,
                    label: 'Camera',
                    onPressed: _toggleCamera,
                    active: !_isCameraOn,
                  ),
                  // Chat
                  _buildControlButton(
                    icon: Icons.chat_bubble,
                    label: 'Chat',
                    onPressed: _openChat,
                  ),
                  // Share screen
                  _buildControlButton(
                    icon: Icons.screen_share,
                    label: 'Share',
                    onPressed: _shareScreen,
                  ),
                  // End call
                  _buildControlButton(
                    icon: Icons.call_end,
                    label: 'End',
                    onPressed: _endCall,
                    isEndCall: true,
                  ),
                ],
              ),
            ),
          ),
          
          // Additional controls (Add notes, Prescribe)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: _showControls ? 120 : -100,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _addNotes,
                  mini: true,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.note_add, color: Colors.black),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  onPressed: _prescribe,
                  mini: true,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.local_hospital, color: Colors.white),
                ),
              ],
            ),
          ),
          
          // Tap to toggle controls
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleControls,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool active = false,
    bool isEndCall = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isEndCall
                ? Colors.red
                : active
                    ? Colors.grey[700]
                    : Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: isEndCall ? Colors.white : active ? Colors.white : Colors.black,
              size: 24,
            ),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSideDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'John Smith',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Reports section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Reports',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildReportItem(
                    title: 'Blood Test Results',
                    date: 'Today, 10:30 AM',
                    type: 'Lab Report',
                  ),
                  const SizedBox(height: 12),
                  _buildReportItem(
                    title: 'ECG Report',
                    date: 'Yesterday, 2:15 PM',
                    type: 'Diagnostic',
                  ),
                  const SizedBox(height: 12),
                  _buildReportItem(
                    title: 'Prescription',
                    date: 'Nov 1, 2023',
                    type: 'Medication',
                  ),
                ],
              ),
            ),
            
            // Divider
            const Divider(height: 1),
            
            // History section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildHistoryItem(
                    title: 'Cardiology Consultation',
                    date: 'Oct 28, 2023',
                    doctor: 'Dr. Sarah Johnson',
                  ),
                  const SizedBox(height: 12),
                  _buildHistoryItem(
                    title: 'Annual Checkup',
                    date: 'Oct 15, 2023',
                    doctor: 'Dr. Michael Chen',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem({
    required String title,
    required String date,
    required String type,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.description,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date • $type',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required String title,
    required String date,
    required String doctor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$date',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            doctor,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}