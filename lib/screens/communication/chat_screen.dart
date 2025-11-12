import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import '../../widgets/network_image_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _conversations = [
    {
      'id': '1',
      'name': 'Dr. John Smith',
      'specialty': 'Cardiologist',
      'lastMessage': 'Your test results look good!',
      'time': '10:30 AM',
      'unread': 2,
      'online': true,
    },
    {
      'id': '2',
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Dermatologist',
      'lastMessage': 'I\'ve reviewed your photos',
      'time': 'Yesterday',
      'unread': 0,
      'online': false,
    },
    {
      'id': '3',
      'name': 'Support Team',
      'specialty': 'Customer Support',
      'lastMessage': 'How can we help you today?',
      'time': 'Jun 10',
      'unread': 1,
      'online': true,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search,
              size: Responsive.size(context, 24),
            ),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert,
              size: Responsive.size(context, 24),
            ),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(Responsive.spacing(context, 16)),
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          return _ConversationItem(
            conversation: _conversations[index],
            onTap: () {
              // Navigate to chat
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatDetailScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ConversationItem extends StatelessWidget {
  final Map<String, dynamic> conversation;
  final VoidCallback onTap;
  
  const _ConversationItem({
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
          child: Row(
            children: [
              Stack(
                children: [
                  NetworkImageWidget(
                    imageUrl: 'https://via.placeholder.com/150',
                    width: Responsive.size(context, 50),
                    height: Responsive.size(context, 50),
                    isCircle: true,
                  ),
                  if (conversation['online'])
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: Responsive.size(context, 12),
                        height: Responsive.size(context, 12),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: Responsive.spacing(context, 16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation['name'],
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          conversation['time'],
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 12),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.spacing(context, 4)),
                    Text(
                      conversation['specialty'],
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(height: Responsive.spacing(context, 4)),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation['lastMessage'],
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 14),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conversation['unread'] > 0)
                          Container(
                            padding: EdgeInsets.all(Responsive.spacing(context, 6)),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2196F3),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              conversation['unread'].toString(),
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 12),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Chat detail screen
class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'id': '1',
      'sender': 'doctor',
      'text': 'Hello! How are you feeling today?',
      'time': '10:30 AM',
      'status': 'delivered',
    },
    {
      'id': '2',
      'sender': 'user',
      'text': 'Hi doctor, I\'m feeling better now. The medication is working well.',
      'time': '10:32 AM',
      'status': 'read',
    },
    {
      'id': '3',
      'sender': 'doctor',
      'text': 'That\'s great to hear! I\'ve reviewed your test results and everything looks good.',
      'time': '10:35 AM',
      'status': 'delivered',
    },
    {
      'id': '4',
      'sender': 'doctor',
      'text': 'Here are some additional tips to maintain your health:',
      'time': '10:36 AM',
      'status': 'delivered',
    },
    {
      'id': '5',
      'sender': 'doctor',
      'text': '1. Continue taking your medication as prescribed\n2. Maintain a healthy diet\n3. Get regular exercise\n4. Schedule a follow-up appointment in 2 weeks',
      'time': '10:37 AM',
      'status': 'delivered',
    },
  ];
  
  final TextEditingController _messageController = TextEditingController();
  
  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      // Add message to list
      setState(() {
        _messages.add({
          'id': DateTime.now().toString(),
          'sender': 'user',
          'text': _messageController.text,
          'time': 'Just now',
          'status': 'sent',
        });
      });
      
      // Clear input
      _messageController.clear();
      
      // Scroll to bottom
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            size: Responsive.size(context, 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                NetworkImageWidget(
                  imageUrl: 'https://via.placeholder.com/150',
                  width: Responsive.size(context, 40),
                  height: Responsive.size(context, 40),
                  isCircle: true,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: Responsive.size(context, 10),
                    height: Responsive.size(context, 10),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: Responsive.spacing(context, 12)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. John Smith',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone,
              size: Responsive.size(context, 24),
            ),
            onPressed: () {
              // Voice call
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam,
              size: Responsive.size(context, 24),
            ),
            onPressed: () {
              // Video call
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert,
              size: Responsive.size(context, 24),
            ),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(Responsive.spacing(context, 16)),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _MessageBubble(
                  message: message,
                  isMe: message['sender'] == 'user',
                );
              },
            ),
          ),
          
          // Message input
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 16)),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: Responsive.size(context, 10),
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Attachment button
                IconButton(
                  icon: Icon(Icons.attach_file,
                    size: Responsive.size(context, 24),
                  ),
                  onPressed: () {
                    // Show attachment options
                  },
                ),
                
                // Text input
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(Responsive.size(context, 20)),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Responsive.spacing(context, 16),
                          vertical: Responsive.spacing(context, 12),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                      ),
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                ),
                
                // Send button
                IconButton(
                  icon: Icon(Icons.send,
                    size: Responsive.size(context, 24),
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isMe;
  
  const _MessageBubble({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spacing(context, 16)),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 12)),
            decoration: BoxDecoration(
              color: isMe
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Responsive.size(context, 16)),
                topRight: Radius.circular(Responsive.size(context, 16)),
                bottomLeft: Radius.circular(isMe ? Responsive.size(context, 16) : 0),
                bottomRight: Radius.circular(isMe ? 0 : Responsive.size(context, 16)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message['text'],
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: isMe ? Colors.white : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 4)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message['time'],
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              if (isMe) ...[
                SizedBox(width: Responsive.spacing(context, 4)),
                _MessageStatusIcon(status: message['status']),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _MessageStatusIcon extends StatelessWidget {
  final String status;
  
  const _MessageStatusIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 'sent':
        return Icon(
          Icons.check,
          size: Responsive.size(context, 12),
          color: Colors.grey,
        );
      case 'delivered':
        return Icon(
          Icons.check_circle,
          size: Responsive.size(context, 12),
          color: Colors.grey,
        );
      case 'read':
        return Icon(
          Icons.check_circle,
          size: Responsive.size(context, 12),
          color: Colors.blue,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}