import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class OrdersDeliveriesScreen extends StatefulWidget {
  const OrdersDeliveriesScreen({super.key});

  @override
  State<OrdersDeliveriesScreen> createState() => _OrdersDeliveriesScreenState();
}

class _OrdersDeliveriesScreenState extends State<OrdersDeliveriesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Ongoing', 'Past'];

  // Sample data
  final List<Order> _ongoingOrders = [
    Order(
      id: 'ORD-789456',
      type: 'Medicine Order',
      status: 'Out for Delivery',
      date: 'Nov 20, 2023',
      estimatedDelivery: 'Nov 20, 2023 by 5:00 PM',
      totalAmount: 49.99,
      items: 3,
      pharmacyName: 'MediCare Pharmacy',
      trackingSteps: [
        TrackingStep(
          title: 'Order Placed',
          description: 'Your order has been placed',
          time: '10:30 AM',
          completed: true,
        ),
        TrackingStep(
          title: 'Order Confirmed',
          description: 'Pharmacy has confirmed your order',
          time: '11:15 AM',
          completed: true,
        ),
        TrackingStep(
          title: 'Packed',
          description: 'Your order has been packed',
          time: '12:45 PM',
          completed: true,
        ),
        TrackingStep(
          title: 'Out for Delivery',
          description: 'Order is out for delivery',
          time: '2:30 PM',
          completed: true,
        ),
        TrackingStep(
          title: 'Delivered',
          description: 'Order will be delivered soon',
          time: '',
          completed: false,
        ),
      ],
      courierName: 'John Doe',
      courierPhone: '+1 (555) 123-4567',
      courierLocation: '1.2 km away',
    ),
    Order(
      id: 'LAB-123456',
      type: 'Lab Test',
      status: 'Sample Collected',
      date: 'Nov 19, 2023',
      estimatedDelivery: 'Nov 22, 2023',
      totalAmount: 0.0,
      items: 1,
      pharmacyName: 'City Lab Services',
      trackingSteps: [
        TrackingStep(
          title: 'Booking Confirmed',
          description: 'Your lab test booking is confirmed',
          time: '9:00 AM',
          completed: true,
        ),
        TrackingStep(
          title: 'Phlebotomist Assigned',
          description: 'Phlebotomist assigned for sample collection',
          time: '10:30 AM',
          completed: true,
        ),
        TrackingStep(
          title: 'Sample Collected',
          description: 'Sample has been collected from your home',
          time: '11:45 AM',
          completed: true,
        ),
        TrackingStep(
          title: 'Sample in Lab',
          description: 'Sample reached the lab for testing',
          time: '1:30 PM',
          completed: true,
        ),
        TrackingStep(
          title: 'Report Generation',
          description: 'Reports are being generated',
          time: '',
          completed: false,
        ),
        TrackingStep(
          title: 'Reports Ready',
          description: 'Reports are ready for download',
          time: '',
          completed: false,
        ),
      ],
      courierName: '',
      courierPhone: '',
      courierLocation: '',
    ),
  ];

  final List<Order> _pastOrders = [
    Order(
      id: 'ORD-456789',
      type: 'Medicine Order',
      status: 'Delivered',
      date: 'Nov 15, 2023',
      estimatedDelivery: 'Nov 15, 2023',
      totalAmount: 29.99,
      items: 2,
      pharmacyName: 'HealthPlus Pharmacy',
      trackingSteps: [],
      courierName: '',
      courierPhone: '',
      courierLocation: '',
    ),
    Order(
      id: 'LAB-789123',
      type: 'Lab Test',
      status: 'Completed',
      date: 'Nov 10, 2023',
      estimatedDelivery: 'Nov 12, 2023',
      totalAmount: 0.0,
      items: 1,
      pharmacyName: 'General Diagnostics',
      trackingSteps: [],
      courierName: '',
      courierPhone: '',
      courierLocation: '',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders & Deliveries'),
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
                          'Filter Orders',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: AppConstants.spacingMd),
                        FilterChip(
                          label: const Text('All'),
                          selected: true,
                          onSelected: (bool selected) {},
                        ),
                        const SizedBox(height: AppConstants.spacingSm),
                        FilterChip(
                          label: const Text('Medicine Orders'),
                          selected: false,
                          onSelected: (bool selected) {},
                        ),
                        const SizedBox(height: AppConstants.spacingSm),
                        FilterChip(
                          label: const Text('Lab Tests'),
                          selected: false,
                          onSelected: (bool selected) {},
                        ),
                        const SizedBox(height: AppConstants.spacingMd),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Apply Filters'),
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
                _buildOngoingOrdersTab(),
                _buildPastOrdersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOngoingOrdersTab() {
    if (_ongoingOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_shipping,
              size: 80,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'No ongoing orders',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              'Your ongoing orders will appear here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh orders
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          ..._ongoingOrders.map((order) => _buildOrderCard(order)).toList(),
        ],
      ),
    );
  }

  Widget _buildPastOrdersTab() {
    if (_pastOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'No past orders',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              'Your past orders will appear here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh orders
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          ..._pastOrders.map((order) => _buildPastOrderCard(order)).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
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
          // Order header
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingSm),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getOrderIcon(order.type),
                    color: Colors.white,
                    size: AppConstants.iconSm,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.type,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: AppConstants.spacingXs),
                      Text(
                        order.id,
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
                    color: _getStatusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: _getStatusColor(order.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Order details
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pharmacy/Lab name
                Text(
                  order.pharmacyName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingXs),
                Text(
                  order.date,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingMd),

                // Items and amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${order.items} ${order.items == 1 ? 'item' : 'items'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (order.totalAmount > 0)
                      Text(
                        '\$${order.totalAmount.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingMd),

                // Tracking steps
                if (order.trackingSteps.isNotEmpty) ...[
                  Text(
                    'Tracking',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  ...order.trackingSteps.map((step) {
                    return _buildTrackingStep(step);
                  }).toList(),
                  const SizedBox(height: AppConstants.spacingMd),
                ],

                // Courier info
                if (order.courierName.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(AppConstants.spacingSm),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_shipping,
                          color: Colors.blue,
                          size: AppConstants.iconSm,
                        ),
                        const SizedBox(width: AppConstants.spacingSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Courier: ${order.courierName}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                order.courierLocation,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.color,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () {
                            // Call courier
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Calling ${order.courierName}...'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                ],

                // Estimated delivery
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingSm),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.green,
                        size: AppConstants.iconSm,
                      ),
                      const SizedBox(width: AppConstants.spacingSm),
                      Expanded(
                        child: Text(
                          'Estimated delivery: ${order.estimatedDelivery}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMd),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // View details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(order: order),
                          ),
                        );
                      },
                      child: const Text('View Details'),
                    ),
                    if (order.status == 'Delivered')
                      TextButton(
                        onPressed: () {
                          // Track on map
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TrackingMapScreen(),
                            ),
                          );
                        },
                        child: const Text('Track on Map'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastOrderCard(Order order) {
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
          // Order header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingSm),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getOrderIcon(order.type),
                  color: Colors.white,
                  size: AppConstants.iconSm,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.type,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingXs),
                    Text(
                      order.id,
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
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: _getStatusColor(order.status),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Pharmacy/Lab name and date
          Text(
            order.pharmacyName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppConstants.spacingXs),
          Text(
            order.date,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // Items and amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${order.items} ${order.items == 1 ? 'item' : 'items'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (order.totalAmount > 0)
                Text(
                  '\$${order.totalAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
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
                  // View details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen(order: order),
                    ),
                  );
                },
                child: const Text('View Details'),
              ),
              if (order.type == 'Medicine Order')
                TextButton(
                  onPressed: () {
                    // Reorder
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reordering items...')),
                    );
                  },
                  child: const Text('Reorder'),
                ),
              TextButton(
                onPressed: () {
                  // View invoice
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing invoice...')),
                  );
                },
                child: const Text('Invoice'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingStep(TrackingStep step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: step.completed
                  ? Theme.of(context).primaryColor
                  : Colors.grey.withOpacity(0.3),
            ),
            child: step.completed
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight:
                            step.completed ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
                Text(
                  step.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                if (step.time.isNotEmpty)
                  Text(
                    step.time,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getOrderIcon(String type) {
    switch (type) {
      case 'Medicine Order':
        return Icons.local_pharmacy;
      case 'Lab Test':
        return Icons.biotech;
      default:
        return Icons.shopping_cart;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
      case 'completed':
        return Colors.green;
      case 'out for delivery':
        return Colors.blue;
      case 'packed':
        return Colors.purple;
      case 'sample collected':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Theme.of(context).primaryColor;
    }
  }
}

class Order {
  final String id;
  final String type;
  final String status;
  final String date;
  final String estimatedDelivery;
  final double totalAmount;
  final int items;
  final String pharmacyName;
  final List<TrackingStep> trackingSteps;
  final String courierName;
  final String courierPhone;
  final String courierLocation;

  Order({
    required this.id,
    required this.type,
    required this.status,
    required this.date,
    required this.estimatedDelivery,
    required this.totalAmount,
    required this.items,
    required this.pharmacyName,
    required this.trackingSteps,
    required this.courierName,
    required this.courierPhone,
    required this.courierLocation,
  });
}

class TrackingStep {
  final String title;
  final String description;
  final String time;
  final bool completed;

  TrackingStep({
    required this.title,
    required this.description,
    required this.time,
    required this.completed,
  });
}

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order summary
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.type,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingSm,
                          vertical: AppConstants.spacingXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                        ),
                        child: Text(
                          order.status,
                          style: TextStyle(
                            color: _getStatusColor(order.status),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    order.pharmacyName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.spacingXs),
                  Text(
                    order.date,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${order.items} ${order.items == 1 ? 'item' : 'items'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (order.totalAmount > 0)
                        Text(
                          '\$${order.totalAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.spacingMd),

            // Tracking timeline
            if (order.trackingSteps.isNotEmpty) ...[
              Text(
                'Tracking Timeline',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
                child: Column(
                  children: order.trackingSteps.map((step) {
                    return _buildTrackingStep(context, step);
                  }).toList(),
                ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
            ],

            // Courier info
            if (order.courierName.isNotEmpty) ...[
              Text(
                'Courier Information',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacingMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.courierName,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Courier',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.color,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () {
                            // Call courier
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Calling ${order.courierName}...'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    Container(
                      padding: const EdgeInsets.all(AppConstants.spacingSm),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusXs),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: AppConstants.iconSm,
                          ),
                          const SizedBox(width: AppConstants.spacingSm),
                          Text(
                            order.courierLocation,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
            ],

            // Estimated delivery
            Text(
              'Delivery Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.green,
                      ),
                      const SizedBox(width: AppConstants.spacingMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estimated Delivery',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              order.estimatedDelivery,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Track on map
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrackingMapScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Track on Map'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.spacingMd),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Contact support
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contacting support...')),
                      );
                    },
                    child: const Text('Contact Support'),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Download invoice
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Downloading invoice...')),
                      );
                    },
                    child: const Text('Invoice'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep(BuildContext context, TrackingStep step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: step.completed
                  ? Theme.of(context).primaryColor
                  : Colors.grey.withOpacity(0.3),
            ),
            child: step.completed
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight:
                            step.completed ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
                Text(
                  step.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                if (step.time.isNotEmpty)
                  Text(
                    step.time,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
      case 'completed':
        return Colors.green;
      case 'out for delivery':
        return Colors.blue;
      case 'packed':
        return Colors.purple;
      case 'sample collected':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class TrackingMapScreen extends StatelessWidget {
  const TrackingMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Tracking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Text(
              'Live Tracking Map',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              'Track your order in real-time',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingLg),
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              margin: const EdgeInsets.all(AppConstants.spacingMd),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Icon(
                          Icons.local_shipping,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacingMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Courier: John Doe',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              '1.2 km away',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () {
                          // Call courier
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Calling courier...')),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Placed'),
                      Text('Out for Delivery'),
                      Text('Delivered'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingMd),
            ElevatedButton(
              onPressed: () {
                // Refresh location
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Refreshing location...')),
                );
              },
              child: const Text('Refresh Location'),
            ),
          ],
        ),
      ),
    );
  }
}