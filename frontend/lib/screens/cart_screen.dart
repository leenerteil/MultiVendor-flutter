import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  final VoidCallback onItemRemoved;
  final VoidCallback onCheckout;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onItemRemoved,
    required this.onCheckout,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<Product, int> _itemQuantities = {};

  @override
  void initState() {
    super.initState();
    _updateQuantities();
  }

  void _updateQuantities() {
    _itemQuantities = {};
    for (var item in widget.cartItems) {
      _itemQuantities[item] = (_itemQuantities[item] ?? 0) + 1;
    }
  }

  double _calculateSubtotal() {
    double subtotal = 0;
    _itemQuantities.forEach((product, quantity) {
      final price = double.parse(product.price.replaceAll('\$', ''));
      subtotal += price * quantity;
    });
    return subtotal;
  }

  double _calculateTotal() {
    return _calculateSubtotal() + 5.99; // Shipping fee
  }

  void _removeItem(Product product) {
    widget.onItemRemoved();
    setState(() {
      widget.cartItems.remove(product);
      _updateQuantities();
    });
    
    // Show removal animation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${product.name} removed from cart',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF3D5150),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _updateQuantity(Product product, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _removeItem(product);
      } else {
        // Update quantity by adding/removing items
        final currentCount = widget.cartItems.where((item) => item == product).length;
        final difference = newQuantity - currentCount;
        
        if (difference > 0) {
          // Add more items
          for (int i = 0; i < difference; i++) {
            widget.cartItems.add(product);
          }
        } else if (difference < 0) {
          // Remove items
          for (int i = 0; i < difference.abs(); i++) {
            widget.cartItems.remove(product);
          }
        }
        _updateQuantities();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final uniqueItems = _itemQuantities.keys.toList();
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with Gradient
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF3D5150),
                  const Color(0xFF1CE2D6).withOpacity(0.8),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3D5150).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button and Title
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'My Cart',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.shopping_cart_checkout_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Cart Items List
          Expanded(
            child: widget.cartItems.isEmpty
                ? _buildEmptyCart()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        
                        // Cart Items Count
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1CE2D6),
                                    Color(0xFF3D5150),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${widget.cartItems.length} items',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Text(
                                      'Clear Cart?',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF3D5150),
                                      ),
                                    ),
                                    content: Text(
                                      'Are you sure you want to remove all items from your cart?',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF3D5150).withOpacity(0.7),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF666666),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            widget.cartItems.clear();
                                            _itemQuantities.clear();
                                          });
                                        },
                                        child: Text(
                                          'Clear All',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF1CE2D6),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.red.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Clear All',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Cart Items List
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: uniqueItems.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final product = uniqueItems[index];
                              final quantity = _itemQuantities[product] ?? 0;
                              final price = double.parse(
                                  product.price.replaceAll('\$', ''));
                              
                              return _buildCartItem(product, quantity, price);
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),

          // Bottom Summary and Checkout
          if (widget.cartItems.isNotEmpty) _buildBottomSummary(),
        ],
      ),
    );
  }

  Widget _buildCartItem(Product product, int quantity, double price) {
    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) => _removeItem(product),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                product: product,
                onAddToCart: () {},
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                product.color.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFF0F0F0),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: product.color.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              // Product Image/Icon
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: product.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: product.color.withOpacity(0.2),
                  ),
                ),
                child: Center(
                  child: Icon(
                    product.icon,
                    color: product.color,
                    size: 32,
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF3D5150),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.shop,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF3D5150).withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Price and Quantity
                    Row(
                      children: [
                        Text(
                          product.price,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1CE2D6),
                          ),
                        ),
                        const Spacer(),
                        
                        // Quantity Selector
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Decrease
                              GestureDetector(
                                onTap: () => _updateQuantity(product, quantity - 1),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: quantity > 1
                                        ? const Color(0xFF1CE2D6)
                                        : const Color(0xFFF5F5F5),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: quantity > 1
                                        ? Colors.white
                                        : const Color(0xFFBDBDBD),
                                  ),
                                ),
                              ),
                              
                              // Quantity Display
                              Container(
                                width: 40,
                                height: 32,
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: Text(
                                  quantity.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF3D5150),
                                  ),
                                ),
                              ),
                              
                              // Increase
                              GestureDetector(
                                onTap: () => _updateQuantity(product, quantity + 1),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1CE2D6),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    // Total for this item
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Total: \$${(price * quantity).toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF3D5150).withOpacity(0.8),
                        ),
                      ),
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

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFF1CE2D6).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: const Color(0xFF1CE2D6),
              size: 80,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Your cart is empty',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3D5150),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Looks like you haven\'t added any products to your cart yet. Start shopping to fill it up!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF3D5150).withOpacity(0.6),
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1CE2D6),
                    Color(0xFF3D5150),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1CE2D6).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Start Shopping',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Order Summary
            Row(
              children: [
                Text(
                  'Order Summary',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3D5150),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1CE2D6),
                        Color(0xFF3D5150),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${widget.cartItems.length} items',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Summary Details
            _buildSummaryRow('Subtotal', '\$${_calculateSubtotal().toStringAsFixed(2)}'),
            _buildSummaryRow('Shipping', '\$5.99'),
            const Divider(
              color: Color(0xFFF0F0F0),
              height: 24,
              thickness: 2,
            ),
            _buildSummaryRow(
              'Total',
              '\$${_calculateTotal().toStringAsFixed(2)}',
              isTotal: true,
            ),
            
            const SizedBox(height: 20),
            
            // Checkout Button
            GestureDetector(
              onTap: widget.cartItems.isNotEmpty
                  ? () {
                      widget.onCheckout();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order placed successfully!',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '\$${_calculateTotal().toStringAsFixed(2)} will be charged',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: const Color(0xFF3D5150),
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                      
                      // Clear cart after checkout
                      Future.delayed(const Duration(milliseconds: 500), () {
                        setState(() {
                          widget.cartItems.clear();
                          _itemQuantities.clear();
                        });
                      });
                    }
                  : null,
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1CE2D6),
                      Color(0xFF3D5150),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1CE2D6).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.shopping_basket_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Proceed to Checkout',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Continue Shopping
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Continue Shopping',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1CE2D6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: const Color(0xFF3D5150).withOpacity(isTotal ? 1 : 0.7),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? 20 : 15,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w700,
              color: isTotal ? const Color(0xFF1CE2D6) : const Color(0xFF3D5150),
            ),
          ),
        ],
      ),
    );
  }
}