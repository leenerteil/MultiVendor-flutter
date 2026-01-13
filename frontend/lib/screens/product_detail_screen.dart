import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product _currentProduct;
  int _quantity = 1;
  double _rating = 0;
  bool _isFavorite = false;
  final bool _inStock = true; // Stock availability state
  final int _views = 8; // Product views count

  @override
  void initState() {
    super.initState();
    _currentProduct = widget.product;
    _isFavorite = _currentProduct.isFavorite;
  }

  void _addToCart() {
    for (int i = 0; i < _quantity; i++) {
      widget.onAddToCart();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_quantity item${_quantity > 1 ? 's' : ''} added to cart',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1CE2D6),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3D5150),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    Text(
                      'Product Details',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    // Favorite Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                          _currentProduct.isFavorite = _isFavorite;
                        });
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Larger Product Image Section
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(30),
                    height: 300, // Increased height
                    decoration: BoxDecoration(
                      color: _currentProduct.color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: _currentProduct.color.withOpacity(0.15),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _currentProduct.color.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        _currentProduct.icon,
                        color: _currentProduct.color,
                        size: 200, // Larger icon
                      ),
                    ),
                  ),

                  // Image Thumbnails
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildImageThumbnail(_currentProduct.color, true),
                        const SizedBox(width: 16),
                        _buildImageThumbnail(
                          _currentProduct.color.withOpacity(0.7),
                          false,
                        ),
                        const SizedBox(width: 16),
                        _buildImageThumbnail(
                          _currentProduct.color.withOpacity(0.4),
                          false,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Product Info Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Text(
                          _currentProduct.name,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3D5150),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Shop Name, Views and Rating Row
                        Row(
                          children: [
                            // Shop Name
                            Row(
                              children: [
                                Icon(
                                  Icons.store_rounded,
                                  color: const Color(0xFF3D5150).withOpacity(0.6),
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _currentProduct.shop,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xFF3D5150).withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            
                            // Views Button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3D5150).withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF3D5150).withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.remove_red_eye_rounded,
                                    color: Color(0xFF3D5150),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '$_views',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF3D5150),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            
                            // Rating Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC107).withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFFFC107).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFFFC107),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _currentProduct.rating.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF3D5150),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Price and Stock Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF1CE2D6).withOpacity(0.08),
                                const Color(0xFF3D5150).withOpacity(0.04),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF1CE2D6).withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF3D5150).withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _currentProduct.price,
                                    style: GoogleFonts.poppins(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1CE2D6),
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Stock Availability
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        _inStock ? Icons.check_circle : Icons.cancel,
                                        color: _inStock ? Colors.green : Colors.red,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        _inStock ? 'In Stock' : 'Out of Stock',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _inStock ? Colors.green : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _currentProduct.color.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _currentProduct.color.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      _currentProduct.category,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: _currentProduct.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Product Description
                        Text(
                          'Description',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF3D5150),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'High-quality ${_currentProduct.name.toLowerCase()} designed for exceptional performance. Crafted with premium materials and attention to detail, this product offers reliability and style. Perfect for everyday use with features that enhance your experience.',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF3D5150).withOpacity(0.7),
                            height: 1.6,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Smaller Quantity Selector
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFF0F0F0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Select Quantity',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF3D5150),
                                    ),
                                  ),
                                  Text(
                                    'Stock: ${_inStock ? 'Available' : 'Unavailable'}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: _inStock ? Colors.green : Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Minus Button (smaller)
                                  GestureDetector(
                                    onTap: _quantity > 1
                                        ? () {
                                            setState(() {
                                              _quantity--;
                                            });
                                          }
                                        : null,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: _quantity > 1
                                            ? const Color(0xFF1CE2D6)
                                            : const Color(0xFFE0E0E0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color: _quantity > 1
                                            ? Colors.white
                                            : const Color(0xFF9E9E9E),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  
                                  // Quantity Display (smaller)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          _quantity.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFF1CE2D6),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          _quantity == 1 ? 'item' : 'items',
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: const Color(0xFF9E9E9E),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  
                                  // Plus Button (smaller)
                                  GestureDetector(
                                    onTap: _inStock
                                        ? () {
                                            setState(() {
                                              _quantity++;
                                            });
                                          }
                                        : null,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: _inStock
                                            ? const Color(0xFF1CE2D6)
                                            : const Color(0xFFE0E0E0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: _inStock
                                            ? Colors.white
                                            : const Color(0xFF9E9E9E),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Rating Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFF0F0F0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rate this product',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  5,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _rating = (index + 1).toDouble();
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Icon(
                                        Icons.star_rounded,
                                        color: index < _rating.toInt()
                                            ? const Color(0xFFFFC107)
                                            : const Color(0xFFE0E0E0),
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  _rating > 0
                                      ? 'You rated ${_rating.toInt()} star${_rating == 1 ? '' : 's'}'
                                      : 'Tap stars to rate',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF666666),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add to Cart Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: GestureDetector(
                onTap: _inStock ? _addToCart : null,
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _inStock
                          ? [
                              const Color(0xFF1CE2D6),
                              const Color(0xFF3D5150),
                            ]
                          : [
                              const Color(0xFFE0E0E0),
                              const Color(0xFFBDBDBD),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _inStock
                        ? [
                            BoxShadow(
                              color: const Color(0xFF1CE2D6).withOpacity(0.4),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(_inStock ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _inStock ? Icons.shopping_cart_rounded : Icons.block,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _inStock ? 'Add to Cart' : 'Out of Stock',
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageThumbnail(Color color, bool isActive) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive
              ? _currentProduct.color
              : _currentProduct.color.withOpacity(0.15),
          width: isActive ? 2 : 1.5,
        ),
      ),
      child: Center(
        child: Icon(
          _currentProduct.icon,
          color: color,
          size: 32,
        ),
      ),
    );
  }
}