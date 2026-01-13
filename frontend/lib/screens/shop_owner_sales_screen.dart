import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shop_owner_drawer.dart';

class OrdersManagementScreen extends StatefulWidget {
  const OrdersManagementScreen({super.key});

  @override
  State<OrdersManagementScreen> createState() => _OrdersManagementScreenState();
}

class _OrdersManagementScreenState extends State<OrdersManagementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedFilter = 'All';
  
  List<Map<String, dynamic>> _orders = [
    {
      'orderId': '#ORD-001',
      'date': 'Jan 15, 2024',
      'customer': 'John Doe',
      'customerEmail': 'john@example.com',
      'customerPhone': '+1 234-567-8901',
      'address': '123 Main St, New York, NY 10001',
      'items': [
        {'name': 'Wireless Headphones', 'quantity': 1, 'price': 89.99},
        {'name': 'Charging Cable', 'quantity': 2, 'price': 19.99},
      ],
      'total': '\$129.97',
      'subtotal': '\$129.97',
      'shipping': '\$0.00',
      'tax': '\$0.00',
      'status': 'Pending',
      'statusColor': Colors.blue,
      'paymentMethod': 'Credit Card',
      'shippingMethod': 'Standard Shipping',
      'notes': 'Please package carefully',
    },
    {
      'orderId': '#ORD-002',
      'date': 'Jan 14, 2024',
      'customer': 'Jane Smith',
      'customerEmail': 'jane@example.com',
      'customerPhone': '+1 234-567-8902',
      'address': '456 Oak Ave, Los Angeles, CA 90001',
      'items': [
        {'name': 'Smart Watch', 'quantity': 1, 'price': 199.99},
      ],
      'total': '\$199.99',
      'subtotal': '\$199.99',
      'shipping': '\$0.00',
      'tax': '\$0.00',
      'status': 'Shipped',
      'statusColor': Colors.orange,
      'paymentMethod': 'PayPal',
      'shippingMethod': 'Express Shipping',
      'notes': 'Gift wrapping requested',
    },
    {
      'orderId': '#ORD-003',
      'date': 'Jan 13, 2024',
      'customer': 'Mike Johnson',
      'customerEmail': 'mike@example.com',
      'customerPhone': '+1 234-567-8903',
      'address': '789 Pine Rd, Chicago, IL 60601',
      'items': [
        {'name': 'Running Shoes', 'quantity': 1, 'price': 129.99},
        {'name': 'Sports Socks', 'quantity': 3, 'price': 9.99},
      ],
      'total': '\$159.96',
      'subtotal': '\$159.96',
      'shipping': '\$0.00',
      'tax': '\$0.00',
      'status': 'Completed',
      'statusColor': Colors.green,
      'paymentMethod': 'Credit Card',
      'shippingMethod': 'Standard Shipping',
      'notes': '',
    },
    {
      'orderId': '#ORD-004',
      'date': 'Jan 12, 2024',
      'customer': 'Sarah Wilson',
      'customerEmail': 'sarah@example.com',
      'customerPhone': '+1 234-567-8904',
      'address': '321 Elm St, Houston, TX 77001',
      'items': [
        {'name': 'Coffee Mug', 'quantity': 1, 'price': 19.99},
        {'name': 'Coffee Beans', 'quantity': 2, 'price': 14.99},
      ],
      'total': '\$49.97',
      'subtotal': '\$49.97',
      'shipping': '\$0.00',
      'tax': '\$0.00',
      'status': 'Canceled',
      'statusColor': Colors.red,
      'paymentMethod': 'Credit Card',
      'shippingMethod': 'Standard Shipping',
      'notes': 'Customer requested cancellation',
    },
    {
      'orderId': '#ORD-005',
      'date': 'Jan 11, 2024',
      'customer': 'David Brown',
      'customerEmail': 'david@example.com',
      'customerPhone': '+1 234-567-8905',
      'address': '654 Maple Dr, Miami, FL 33101',
      'items': [
        {'name': 'Laptop Bag', 'quantity': 1, 'price': 79.99},
        {'name': 'Wireless Mouse', 'quantity': 1, 'price': 29.99},
        {'name': 'USB Hub', 'quantity': 1, 'price': 49.99},
      ],
      'total': '\$159.97',
      'subtotal': '\$159.97',
      'shipping': '\$0.00',
      'tax': '\$0.00',
      'status': 'Pending',
      'statusColor': Colors.blue,
      'paymentMethod': 'Apple Pay',
      'shippingMethod': 'Express Shipping',
      'notes': 'Priority order',
    },
  ];

  List<String> _exportOptions = ['Excel', 'CSV', 'PDF', 'Word'];

  // Filter orders based on selected filter
  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedFilter == 'All') return _orders;
    return _orders.where((order) => order['status'] == _selectedFilter).toList();
  }

  // Count orders by status
  int _getOrderCount(String status) {
    if (status == 'All') return _orders.length;
    return _orders.where((order) => order['status'] == status).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: const ShopOwnerDrawer(currentScreen: 'Dashboard'),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1CE2D6),
                    Color(0xFF3D5150),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  children: [
                    // Top Bar with Menu Button
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.menu_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Orders Management',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                            onSelected: (value) {
                              if (value == 'export_all') {
                                _showExportDialog();
                              } else if (value == 'refresh') {
                                _refreshOrders();
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem<String>(
                                value: 'export_all',
                                child: Row(
                                  children: [
                                    Icon(Icons.download, size: 18),
                                    SizedBox(width: 8),
                                    Text('Export All Orders'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'refresh',
                                child: Row(
                                  children: [
                                    Icon(Icons.refresh, size: 18),
                                    SizedBox(width: 8),
                                    Text('Refresh Orders'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Stats Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickStat(
                            icon: Icons.shopping_bag_outlined,
                            label: 'Total',
                            value: _orders.length.toString(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildQuickStat(
                            icon: Icons.attach_money,
                            label: 'Revenue',
                            value: '\$${_calculateTotalRevenue().toInt()}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Status Filter Chips
            SizedBox(
              height: 40,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('All', _getOrderCount('All')),
                  const SizedBox(width: 8),
                  _buildFilterChip('Pending', _getOrderCount('Pending')),
                  const SizedBox(width: 8),
                  _buildFilterChip('Shipped', _getOrderCount('Shipped')),
                  const SizedBox(width: 8),
                  _buildFilterChip('Completed', _getOrderCount('Completed')),
                  const SizedBox(width: 8),
                  _buildFilterChip('Canceled', _getOrderCount('Canceled')),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Section Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Orders',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3D5150),
                    ),
                  ),
                  GestureDetector(
                    onTap: _showExportDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1CE2D6),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1CE2D6).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.download_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Export',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Orders List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = _filteredOrders[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Dismissible(
                      key: Key(order['orderId']),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await _showDeleteConfirmation(order['orderId']);
                      },
                      onDismissed: (direction) {
                        _deleteOrder(order['orderId']);
                      },
                      child: _buildOrderCard(
                        order: order,
                        index: index,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int count) {
    final isSelected = _selectedFilter == label;
    Color chipColor;
    
    switch (label) {
      case 'Pending':
        chipColor = Colors.blue;
        break;
      case 'Shipped':
        chipColor = Colors.orange;
        break;
      case 'Completed':
        chipColor = Colors.green;
        break;
      case 'Canceled':
        chipColor = Colors.red;
        break;
      default:
        chipColor = const Color(0xFF3D5150);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? chipColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? chipColor : Colors.grey.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: chipColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF3D5150),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.3)
                    : chipColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : chipColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required Map<String, dynamic> order,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showOrderDetails(order);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    // Order Icon
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: order['statusColor'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: order['statusColor'],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Order Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                order['orderId'],
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: order['statusColor'].withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  order['status'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: order['statusColor'],
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                order['customer'],
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Price and Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          order['total'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1CE2D6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 12,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              order['date'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showOrderDetails(order);
                        },
                        icon: const Icon(Icons.visibility_outlined, size: 16),
                        label: Text(
                          'View',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF3D5150),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showStatusUpdateDialog(order);
                        },
                        icon: const Icon(Icons.update, size: 16),
                        label: Text(
                          'Update',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: order['statusColor'],
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Details',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF3D5150),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Order Summary
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Order ID', order['orderId']),
                          const SizedBox(height: 12),
                          _buildDetailRow('Date', order['date']),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: order['statusColor'].withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  order['status'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: order['statusColor'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildDetailRow('Total', order['total']),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Customer Information
                    Text(
                      'Customer Information',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D5150),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['customer'],
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            order['customerEmail'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order['customerPhone'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            order['address'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),

                    // Payment Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Method',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  order['paymentMethod'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Shipping Address with Mock Map
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping Address',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3D5150),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.withOpacity(0.1)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Mock Map Section
                              Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    // Grid pattern mock map
                                    Opacity(
                                      opacity: 0.1,
                                      child: GridView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: 100,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 10,
                                        ),
                                        itemBuilder: (context, index) => Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: 0.3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Center(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    const Icon(Icons.map_outlined,
                                        size: 20, color: Color(0xFF1CE2D6)),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        order['address'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    
                    // Order Items
                    Text(
                      'Order Items',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D5150),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...((order['items'] as List<dynamic>)).map<Widget>((item) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Qty: ${item['quantity']}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\$${item['price'].toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    
                    const SizedBox(height: 20),
                    
                    // Notes
                    if (order['notes'].isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notes',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF3D5150),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              order['notes'],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[600],
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3D5150),
          ),
        ),
      ],
    );
  }

  void _showStatusUpdateDialog(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Update Order Status',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select new status for ${order['orderId']}',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 16),
            _buildStatusOption('Pending', Colors.blue, order),
            _buildStatusOption('Shipped', Colors.orange, order),
            _buildStatusOption('Completed', Colors.green, order),
            _buildStatusOption('Canceled', Colors.red, order),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(String status, Color color, Map<String, dynamic> order) {
    return ListTile(
      leading: Icon(Icons.circle, color: color, size: 16),
      title: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _updateOrderStatus(order['orderId'], status, color);
      },
    );
  }

  void _updateOrderStatus(String orderId, String newStatus, Color statusColor) {
    setState(() {
      final index = _orders.indexWhere((order) => order['orderId'] == orderId);
      if (index != -1) {
        _orders[index]['status'] = newStatus;
        _orders[index]['statusColor'] = statusColor;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order $orderId status updated to $newStatus'),
        backgroundColor: statusColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showExportDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 500,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Export Orders',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF3D5150),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Drag format to export zone or click to export',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Export Options with Drag & Drop
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.all(16),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2.2,
                            ),
                            itemCount: _exportOptions.length,
                            itemBuilder: (context, index) {
                              final option = _exportOptions[index];
                              return Draggable<String>(
                                data: option,
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    width: 150,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color(0xFF1CE2D6)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Export as $option',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1CE2D6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () => _exportOrders(option, this.context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFF1CE2D6).withOpacity(0.5),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            _getExportIcon(option),
                                            color: const Color(0xFF1CE2D6),
                                            size: 24,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            option,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF3D5150),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Drop Zone
                        DragTarget<String>(
                          onWillAcceptWithDetails: (data) => true,
                          onAcceptWithDetails: (data) {
                            _exportOrders(data.data, this.context);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: candidateData.isNotEmpty
                                    ? const Color(0xFF1CE2D6).withOpacity(0.1)
                                    : const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: candidateData.isNotEmpty
                                      ? const Color(0xFF1CE2D6)
                                      : Colors.grey.withOpacity(0.3),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_download,
                                      color: candidateData.isNotEmpty
                                          ? const Color(0xFF1CE2D6)
                                          : Colors.grey[600],
                                      size: 30,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Drop here to export',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: candidateData.isNotEmpty
                                            ? const Color(0xFF1CE2D6)
                                            : Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Export All Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _exportAllOrders(this.context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3D5150),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.download_for_offline, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Export All Orders',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getExportIcon(String format) {
    switch (format) {
      case 'Excel':
        return Icons.table_chart;
      case 'CSV':
        return Icons.table_view;
      case 'PDF':
        return Icons.picture_as_pdf;
      case 'Word':
        return Icons.description;
      default:
        return Icons.download;
    }
  }

  void _exportOrders(String format, BuildContext context) {
    final count = _filteredOrders.length;
    final filterText = _selectedFilter == 'All' ? '' : ' ($_selectedFilter)';
    
    // Close the dialog first if it's still showing
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            CircularProgressIndicator(
              color: _getFormatColor(format),
            ),
            const SizedBox(height: 24),
            Text(
              'Exporting $count orders$filterText...',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3D5150),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Preparing your $format file',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

    // Simulate export process
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      
      // Create export content
      final exportContent = _generateExportContent(format);
      
      // Show success dialog with actual export content
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Export Successful!',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3D5150),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your $format file is ready:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'orders_${DateTime.now().millisecondsSinceEpoch}.${format.toLowerCase()}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: _getFormatColor(format),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Size: ${exportContent.length ~/ 1024} KB',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Orders: $count',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Preview:',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 100,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(6),
                  // border: Border.all(color:),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    exportContent.substring(0, exportContent.length > 300 ? 300 : exportContent.length),
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$format file downloaded successfully!'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _getFormatColor(format),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Download',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _exportAllOrders(BuildContext context) {
    Navigator.pop(context); // Close the dialog
    
    // Show format selection dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Export All Orders',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _exportOptions.map((format) {
            return ListTile(
              leading: Icon(_getExportIcon(format), color: _getFormatColor(format)),
              title: Text(format),
              onTap: () {
                Navigator.pop(context);
                _exportOrders(format, context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _getFormatColor(String format) {
    switch (format) {
      case 'Excel':
        return Colors.green;
      case 'CSV':
        return Colors.blue;
      case 'PDF':
        return Colors.red;
      case 'Word':
        return Colors.blue;
      default:
        return const Color(0xFF1CE2D6);
    }
  }

  String _generateExportContent(String format) {
    final filteredOrders = _filteredOrders;
    final buffer = StringBuffer();
    
    // Add header based on format
    if (format == 'Excel' || format == 'CSV') {
      buffer.writeln('Order ID,Date,Customer,Total,Status,Items');
      for (var order in filteredOrders) {
        final items = order['items'] as List<dynamic>;
        final itemsStr = items.map((item) => 
          '${item['name']} (x${item['quantity']})').join('; ');
        
        buffer.writeln('${order['orderId']},${order['date']},${order['customer']},${order['total']},${order['status']},"$itemsStr"');
      }
    } else if (format == 'PDF') {
      buffer.writeln('ORDERS REPORT');
      buffer.writeln('Generated: ${DateTime.now()}');
      buffer.writeln('Filter: $_selectedFilter');
      buffer.writeln('Total Orders: ${filteredOrders.length}');
      buffer.writeln('\n---\n');
      
      for (var order in filteredOrders) {
        buffer.writeln('Order ID: ${order['orderId']}');
        buffer.writeln('Date: ${order['date']}');
        buffer.writeln('Customer: ${order['customer']}');
        buffer.writeln('Total: ${order['total']}');
        buffer.writeln('Status: ${order['status']}');
        buffer.writeln('Items:');
        final items = order['items'] as List<dynamic>;
        for (var item in items) {
          buffer.writeln('  • ${item['name']} x${item['quantity']} - \$${item['price']}');
        }
        buffer.writeln('\n---\n');
      }
    } else if (format == 'Word') {
      buffer.writeln('Orders Document');
      buffer.writeln('===============\n');
      buffer.writeln('Date: ${DateTime.now()}');
      buffer.writeln('Orders Count: ${filteredOrders.length}\n');
      
      for (var order in filteredOrders) {
        buffer.writeln('Order: ${order['orderId']}');
        buffer.writeln('-------------------------');
        buffer.writeln('Customer: ${order['customer']}');
        buffer.writeln('Order Date: ${order['date']}');
        buffer.writeln('Status: ${order['status']}');
        buffer.writeln('Total Amount: ${order['total']}');
        buffer.writeln('\nItems Ordered:');
        final items = order['items'] as List<dynamic>;
        for (var item in items) {
          buffer.writeln('• ${item['name']} (Quantity: ${item['quantity']}, Price: \$${item['price']})');
        }
        buffer.writeln('\n');
      }
    }
    
    return buffer.toString();
  }

  Future<bool?> _showDeleteConfirmation(String orderId) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Cancel Order',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to cancel order $orderId? This action cannot be undone.',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'No',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Yes, Cancel Order',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteOrder(String orderId) {
    setState(() {
      final orderIndex = _orders.indexWhere((order) => order['orderId'] == orderId);
      if (orderIndex != -1) {
        final order = _orders.removeAt(orderIndex);
        
        // Add snackbar with undo option
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order $orderId has been canceled'),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'UNDO',
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  _orders.insert(orderIndex, order);
                });
              },
            ),
          ),
        );
      }
    });
  }

  double _calculateTotalRevenue() {
    double total = 0;
    for (var order in _orders) {
      // Remove $ sign and convert to double
      final totalString = order['total'].toString();
      final numericString = totalString.replaceAll('\$', '');
      total += double.tryParse(numericString) ?? 0;
    }
    return total.roundToDouble();
  }

  void _refreshOrders() {
    setState(() {
      // Simulate refreshing orders
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Refreshing orders...'),
          duration: Duration(seconds: 1),
        ),
      );
    });
  }
}