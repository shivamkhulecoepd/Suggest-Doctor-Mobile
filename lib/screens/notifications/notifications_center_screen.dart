import 'package:flutter/material.dart';
import '../../core/constants.dart';

class NotificationsCenterScreen extends StatefulWidget {
  const NotificationsCenterScreen({super.key});

  @override
  State<NotificationsCenterScreen> createState() => _NotificationsCenterScreenState();
}

class _NotificationsCenterScreenState extends State<NotificationsCenterScreen> {
  // Sample data
  final List<NotificationGroup> _notificationGroups = [
    NotificationGroup(
      type: 'Reminders',
      notifications: [
        AppNotification(
          id: '1',
          title: 'Appointment Reminder',
          message: 'Your appointment with Dr. Sarah Johnson is in 1 hour',
          time: '10 mins ago',
          type: 'reminder',
          isUnread: true,
          action: 'View Appointment',
          relatedId: 'apt_001',
        ),
        AppNotification(
          id: '2',
          title: 'Medication Reminder',
          message: 'Time to take your Lisinopril 10mg',
          time: '25 mins ago',
          type: 'reminder',
          isUnread: true,
          action: 'Mark as Taken',
          relatedId: 'med_001',
        ),
        AppNotification(
          id: '3',
          title: 'Lab Report Ready',
          message: 'Your Complete Blood Count report is ready',
          time: '1 hour ago',
          type: 'reminder',
          isUnread: false,
          action: 'View Report',
          relatedId: 'lab_001',
        ),
      ],
    ),
    NotificationGroup(
      type: 'Promotional',
      notifications: [
        AppNotification(
          id: '4',
          title: 'Special Offer',
          message: 'Get 20% off on your next lab test booking',
          time: '2 hours ago',
          type: 'promotional',
          isUnread: false,
          action: 'View Offer',
          relatedId: 'offer_001',
        ),
        AppNotification(
          id: '5',
          title: 'Health Tip',
          message: '5 ways to maintain a healthy heart',
          time: '5 hours ago',
          type: 'promotional',
          isUnread: false,
          action: 'Read More',
          relatedId: 'tip_001',
        ),
      ],
    ),
    NotificationGroup(
      type: 'System',
      notifications: [
        AppNotification(
          id: '6',
          title: 'App Update',
          message: 'A new version of the app is available for download',
          time: '1 day ago',
          type: 'system',
          isUnread: false,
          action: 'Update Now',
          relatedId: 'update_001',
        ),
        AppNotification(
          id: '7',
          title: 'Security Alert',
          message: 'Your password was changed successfully',
          time: '2 days ago',
          type: 'system',
          isUnread: false,
          action: 'View Details',
          relatedId: 'security_001',
        ),
      ],
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var group in _notificationGroups) {
        for (var notification in group.notifications) {
          notification.isUnread = false;
        }
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read')),
    );
  }

  void _clearAllNotifications() {
    setState(() {
      _notificationGroups.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications cleared')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (_hasUnreadNotifications())
            IconButton(
              icon: const Icon(Icons.mark_email_read),
              onPressed: _markAllAsRead,
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Open notification settings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsScreen(),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'mark_all_read':
                  _markAllAsRead();
                  break;
                case 'clear_all':
                  _clearAllNotifications();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'mark_all_read',
                child: Text('Mark all as read'),
              ),
              const PopupMenuItem<String>(
                value: 'clear_all',
                child: Text('Clear all notifications'),
              ),
            ],
          ),
        ],
      ),
      body: _notificationGroups.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
              onRefresh: () async {
                // Refresh notifications
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                itemCount: _notificationGroups.length,
                itemBuilder: (context, groupIndex) {
                  final group = _notificationGroups[groupIndex];
                  return _buildNotificationGroup(group);
                },
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'No notifications',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            'Your notifications will appear here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationGroup(NotificationGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingMd),
          child: Text(
            group.type,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Column(
            children: group.notifications.map((notification) {
              return _buildNotificationItem(notification);
            }).toList(),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
      ],
    );
  }

  Widget _buildNotificationItem(AppNotification notification) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          // Remove notification from its group
          for (var group in _notificationGroups) {
            group.notifications.removeWhere((n) => n.id == notification.id);
          }
          // Remove empty groups
          _notificationGroups.removeWhere((group) => group.notifications.isEmpty);
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notification dismissed'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // In a real app, you would restore the notification
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification restored')),
                );
              },
            ),
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppConstants.spacingMd),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.spacingMd),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getNotificationColor(notification.type).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getNotificationIcon(notification.type),
            color: _getNotificationColor(notification.type),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: notification.isUnread ? FontWeight.bold : FontWeight.normal,
                    ),
              ),
            ),
            if (notification.isUnread)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConstants.spacingXs),
            Text(
              notification.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingXs),
            Text(
              notification.time,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
          ],
        ),
        trailing: TextButton(
          onPressed: () => _handleNotificationAction(notification),
          child: Text(notification.action),
        ),
        onTap: () => _handleNotificationTap(notification),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.radiusMd),
            bottom: Radius.circular(AppConstants.radiusMd),
          ),
        ),
      ),
    );
  }

  void _handleNotificationTap(AppNotification notification) {
    // Mark as read when tapped
    setState(() {
      notification.isUnread = false;
    });
    
    // Handle notification tap based on type
    _handleNotificationAction(notification);
  }

  void _handleNotificationAction(AppNotification notification) {
    switch (notification.action) {
      case 'View Appointment':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Viewing appointment details...')),
        );
        break;
      case 'Mark as Taken':
        setState(() {
          notification.isUnread = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medication marked as taken')),
        );
        break;
      case 'View Report':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Viewing lab report...')),
        );
        break;
      case 'View Offer':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Viewing special offer...')),
        );
        break;
      case 'Read More':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reading health tip...')),
        );
        break;
      case 'Update Now':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Updating app...')),
        );
        break;
      case 'View Details':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Viewing details...')),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Performing action: ${notification.action}')),
        );
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'reminder':
        return Icons.alarm;
      case 'promotional':
        return Icons.local_offer;
      case 'system':
        return Icons.settings;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'reminder':
        return Colors.blue;
      case 'promotional':
        return Colors.green;
      case 'system':
        return Colors.orange;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  bool _hasUnreadNotifications() {
    for (var group in _notificationGroups) {
      for (var notification in group.notifications) {
        if (notification.isUnread) {
          return true;
        }
      }
    }
    return false;
  }
}

class NotificationGroup {
  final String type;
  final List<AppNotification> notifications;

  NotificationGroup({
    required this.type,
    required this.notifications,
  });
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final String time;
  final String type;
  bool isUnread;
  final String action;
  final String relatedId;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isUnread,
    required this.action,
    required this.relatedId,
  });
}

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _enableNotifications = true;
  bool _reminderNotifications = true;
  bool _promotionalNotifications = true;
  bool _systemNotifications = true;
  String _notificationSound = 'Default';
  bool _vibrate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // Enable notifications
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _enableNotifications,
            onChanged: (value) {
              setState(() {
                _enableNotifications = value;
              });
            },
          ),
          
          const Divider(),
          
          // Notification categories
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppConstants.spacingMd),
            child: Text(
              'Notification Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          SwitchListTile(
            title: const Text('Reminders'),
            subtitle: const Text('Appointment and medication reminders'),
            value: _reminderNotifications,
            onChanged: _enableNotifications
                ? (value) {
                    setState(() {
                      _reminderNotifications = value;
                    });
                  }
                : null,
          ),
          
          SwitchListTile(
            title: const Text('Promotional'),
            subtitle: const Text('Special offers and health tips'),
            value: _promotionalNotifications,
            onChanged: _enableNotifications
                ? (value) {
                    setState(() {
                      _promotionalNotifications = value;
                    });
                  }
                : null,
          ),
          
          SwitchListTile(
            title: const Text('System'),
            subtitle: const Text('App updates and security alerts'),
            value: _systemNotifications,
            onChanged: _enableNotifications
                ? (value) {
                    setState(() {
                      _systemNotifications = value;
                    });
                  }
                : null,
          ),
          
          const Divider(),
          
          // Notification sound
          ListTile(
            title: const Text('Notification Sound'),
            subtitle: Text(_notificationSound),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _enableNotifications
                ? () {
                    // Show sound selection dialog
                    _showSoundSelectionDialog();
                  }
                : null,
          ),
          
          const Divider(),
          
          // Vibration
          SwitchListTile(
            title: const Text('Vibrate'),
            value: _vibrate,
            onChanged: _enableNotifications
                ? (value) {
                    setState(() {
                      _vibrate = value;
                    });
                  }
                : null,
          ),
          
          const Divider(),
          
          // Do not disturb
          ListTile(
            title: const Text('Do Not Disturb'),
            subtitle: const Text('Schedule quiet hours'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Show DND settings
              _showDndSettingsDialog();
            },
          ),
          
          const Divider(),
          
          // Reset settings
          ListTile(
            title: const Text('Reset to Default'),
            textColor: Colors.red,
            onTap: () {
              setState(() {
                _enableNotifications = true;
                _reminderNotifications = true;
                _promotionalNotifications = true;
                _systemNotifications = true;
                _notificationSound = 'Default';
                _vibrate = true;
              });
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset to default')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSoundSelectionDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification Sound',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              ...['Default', 'Bell', 'Chime', 'Ding', 'None'].map((sound) {
                return RadioListTile<String>(
                  title: Text(sound),
                  value: sound,
                  groupValue: _notificationSound,
                  onChanged: (value) {
                    setState(() {
                      _notificationSound = value!;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showDndSettingsDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do Not Disturb',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              const Text('Schedule quiet hours when you don\'t want to receive notifications.'),
              const SizedBox(height: AppConstants.spacingMd),
              SwitchListTile(
                title: const Text('Enable DND'),
                value: false,
                onChanged: (value) {},
              ),
              const SizedBox(height: AppConstants.spacingMd),
              const Text('Start Time'),
              const SizedBox(height: AppConstants.spacingSm),
              ListTile(
                title: const Text('10:00 PM'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Show time picker
                },
              ),
              const SizedBox(height: AppConstants.spacingMd),
              const Text('End Time'),
              const SizedBox(height: AppConstants.spacingSm),
              ListTile(
                title: const Text('7:00 AM'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Show time picker
                },
              ),
              const SizedBox(height: AppConstants.spacingMd),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}