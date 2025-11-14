class Medicine {
  final String id;
  final String name;
  final String brand;
  final String manufacturer;
  final String category;
  final String dosageForm; // tablet, syrup, injection, etc.
  final String description;
  final String composition;
  final double price;
  final double? discountedPrice;
  final int discountPercentage;
  final bool inStock;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool prescriptionRequired;
  final List<String> tags; // e.g., ['fever', 'pain relief', 'generic']

  Medicine({
    required this.id,
    required this.name,
    required this.brand,
    required this.manufacturer,
    required this.category,
    required this.dosageForm,
    required this.description,
    required this.composition,
    required this.price,
    this.discountedPrice,
    this.discountPercentage = 0,
    required this.inStock,
    required this.imageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.prescriptionRequired,
    required this.tags,
  });

  // Calculate final price considering discount
  double get finalPrice => discountedPrice ?? price;

  // Check if medicine is on discount
  bool get isOnDiscount => discountedPrice != null && discountedPrice! < price;

  // Get discount amount
  double get discountAmount => price - (discountedPrice ?? price);
}

class CartItem {
  final Medicine medicine;
  int quantity;
  DateTime addedAt;

  CartItem({
    required this.medicine,
    required this.quantity,
    required this.addedAt,
  });

  double get totalPrice => medicine.finalPrice * quantity;
}

class Order {
  final String orderId;
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double deliveryFee;
  final double totalAmount;
  final String status;
  final DateTime orderDate;
  final String deliveryAddress;
  final String paymentMethod;

  Order({
    required this.orderId,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.deliveryFee,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    required this.deliveryAddress,
    required this.paymentMethod,
  });
}