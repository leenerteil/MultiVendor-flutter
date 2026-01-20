import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/order.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({super.key});

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  // Mock Data matching the structure
  final List<Order> _orders = [
    Order(
      id: '6d9a2996',
      date: '01 Dec 2025 10:27',
      shopName: 'Daisy',
      shopLogo: 'assets/images/logo1.png', 
      totalAmount: 63.00,
      status: 'COMPLETED',
      deliveryStatus: 'Delivered',
      itemCount: 4,
      firstItemName: 'Disco Star Rainbow Wand',
      otherItemsCount: 2,
    ),
    Order(
      id: '8f2b1102',
      date: '28 Nov 2025 14:15',
      shopName: 'Tech Haven',
      shopLogo: 'assets/images/logo2.png',
      totalAmount: 129.50,
      status: 'COMPLETED',
      deliveryStatus: 'Delivered',
      itemCount: 2,
      firstItemName: 'Wireless Bluetooth Earbuds',
      otherItemsCount: 1,
    ),
    Order(
      id: '3c7e5541',
      date: '15 Nov 2025 09:30',
      shopName: 'Green Earth',
      shopLogo: 'assets/images/logo3.png',
      totalAmount: 45.00,
      status: 'CANCELLED',
      deliveryStatus: 'Cancelled',
      itemCount: 3,
      firstItemName: 'Bamboo Toothbrush Set',
      otherItemsCount: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.myOrders,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3D5150),
          ),
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF3D5150)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Subtitle
            Text(
              AppLocalizations.of(context)!.trackOrdersSubtitle,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF3D5150).withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Orders List
            ListView.separated(
              itemCount: _orders.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildOrderCard(_orders[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEF0F2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Order ID, Date, Status Badge
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.orderNumber(order.id),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color(0xFF3D5150),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 6),
                        Text(
                          order.date,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF3D5150).withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      if (order.status == 'COMPLETED')
                        const Icon(Icons.check_circle_outline, size: 12, color: Color(0xFF3D5150)),
                      if (order.status == 'COMPLETED') const SizedBox(width: 4),
                      Text(
                        order.status == 'COMPLETED' 
                            ? AppLocalizations.of(context)!.completed 
                            : AppLocalizations.of(context)!.cancelled,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF3D5150),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEF0F2)),

          // Middle Section: Item Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shop Logo Placeholder
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                    image: order.shopLogo.startsWith('assets') 
                        ? DecorationImage(image: AssetImage(order.shopLogo), fit: BoxFit.cover, onError: (_,__) {}) 
                        : null, /* Placeholder if not asset for now */
                  ),
                  child: order.shopLogo.startsWith('assets') ? null : const Icon(Icons.store, color: Colors.grey),
                ),
                const SizedBox(width: 14),
                
                // Item Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.shopName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF3D5150),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.itemsInOrder(order.itemCount.toString()),
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.orderItemFormat(order.firstItemName, '1'),
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (order.otherItemsCount > 0)
                        Text(
                          AppLocalizations.of(context)!.moreItems(order.otherItemsCount.toString()),
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1CE2D6), fontWeight: FontWeight.w500),
                        ),
                    ],
                  ),
                ),

                // Total Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${order.totalAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: const Color(0xFF1CE2D6),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.totalAmountLabel,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Section: Delivery and Action
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border(top: BorderSide(color: const Color(0xFFEEF0F2))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 16,
                      color: order.deliveryStatus == 'Cancelled' ? Colors.red : const Color(0xFF2E7D32),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      order.deliveryStatus == 'Cancelled' 
                          ? AppLocalizations.of(context)!.cancelled 
                          : AppLocalizations.of(context)!.delivered,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: order.deliveryStatus == 'Cancelled' ? Colors.red : const Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to details (To be implemented)
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1CE2D6),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                         BoxShadow(
                          color: const Color(0xFF1CE2D6).withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                         ),
                      ],
                    ),
                    child: const Icon(Icons.visibility_outlined, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
