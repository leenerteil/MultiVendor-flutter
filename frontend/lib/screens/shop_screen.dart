import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_detail_screen.dart';
import '../models/product.dart';

class ShopScreen extends StatefulWidget {
  final String shopName;
  final String shopDescription;
  final String shopEmail;
  final String shopLocation;
  final String shopViews;
  final int shopProductCount;
  final String shopCategory;
  final String coverImage;
  final String logoImage;
  final bool isShopOwner;

  const ShopScreen({
    super.key,
    required this.shopName,
    required this.shopDescription,
    required this.shopEmail,
    required this.shopLocation,
    required this.shopViews,
    required this.shopProductCount,
    required this.shopCategory,
    required this.coverImage,
    required this.logoImage,
    this.isShopOwner = false,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _selectedCategory = "All";
  String _selectedBrand = "All";
  double _minPrice = 0;
  double _maxPrice = 500;
  String _searchQuery = "";
  int _cartCount = 0;
  int _favoriteCount = 0;
  bool _isFiltersExpanded = false;

  // Mock Shop Products Data (Cosmetics)
  final List<Product> _shopProducts = [
    Product(
      id: '1',
      name: 'Luxury Night Cream',
      price: '\$89.99',
      category: 'Skincare',
      shop: 'Skin & Grin',
      rating: 4.5,
      color: const Color(0xFFF4E2DE),
      icon: Icons.spa,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '2',
      name: 'Vitamin C Serum',
      price: '\$59.99',
      category: 'Skincare',
      shop: 'Skin & Grin',
      rating: 4.7,
      color: const Color(0xFFFFF3CD),
      icon: Icons.water_drop,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '3',
      name: 'Anti-Aging Eye Cream',
      price: '\$75.50',
      category: 'Skincare',
      shop: 'Skin & Grin',
      rating: 4.3,
      color: const Color(0xFFE8F5E9),
      icon: Icons.remove_red_eye,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '4',
      name: 'Hydrating Face Mask',
      price: '\$34.99',
      category: 'Masks',
      shop: 'Skin & Grin',
      rating: 4.8,
      color: const Color(0xFFE3F2FD),
      icon: Icons.face,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '5',
      name: 'Detox Clay Mask',
      price: '\$45.50',
      category: 'Masks',
      shop: 'Skin & Grin',
      rating: 4.2,
      color: const Color(0xFFF3E5F5),
      icon: Icons.spa,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '6',
      name: 'Rose Water Toner',
      price: '\$29.99',
      category: 'Toners',
      shop: 'Skin & Grin',
      rating: 4.6,
      color: const Color(0xFFFFE0E0),
      icon: Icons.water,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '7',
      name: 'Sunscreen SPF 50',
      price: '\$42.99',
      category: 'Suncare',
      shop: 'Skin & Grin',
      rating: 4.4,
      color: const Color(0xFFFFF8E1),
      icon: Icons.wb_sunny,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '8',
      name: 'Lip Repair Balm',
      price: '\$18.99',
      category: 'Lip Care',
      shop: 'Skin & Grin',
      rating: 4.9,
      color: const Color(0xFFFCE4EC),
      icon: Icons.face,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '9',
      name: 'Hand Cream',
      price: '\$22.99',
      category: 'Body Care',
      shop: 'Skin & Grin',
      rating: 4.3,
      color: const Color(0xFFE8F5E9),
      icon: Icons.back_hand,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '10',
      name: 'Facial Cleanser',
      price: '\$39.99',
      category: 'Cleansers',
      shop: 'Skin & Grin',
      rating: 4.2,
      color: const Color(0xFFE0F7FA),
      icon: Icons.wash,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '11',
      name: 'Brightening Essence',
      price: '\$65.99',
      category: 'Essences',
      shop: 'Skin & Grin',
      rating: 4.5,
      color: const Color(0xFFF3E5F5),
      icon: Icons.auto_awesome,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '12',
      name: 'Body Lotion',
      price: '\$54.99',
      category: 'Body Care',
      shop: 'Skin & Grin',
      rating: 4.1,
      color: const Color(0xFFFFF3CD),
      icon: Icons.spa,
      isFavorite: false,
      cartQuantity: 0,
    ),
  ];

  // Filter Options specific to this shop
  final List<String> _categories = [
    "All",
    "Skincare",
    "Masks",
    "Toners",
    "Suncare",
    "Lip Care",
    "Body Care",
    "Cleansers",
    "Essences",
  ];

  final List<String> _brands = [
    "All",
    "Skin & Grin",
    "Luxury Line",
    "Natural Collection",
    "Premium Series",
  ];

  void _toggleFavorite(Product product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
      if (product.isFavorite) {
        _favoriteCount++;
      } else {
        _favoriteCount--;
      }
    });
  }

  void _addToCart(Product product) {
    setState(() {
      product.cartQuantity++;
      _cartCount++;
    });
  }

  List<Product> _getFilteredProducts() {
    return _shopProducts.where((product) {
      // Category filter
      bool categoryMatch = _selectedCategory == "All" ||
          product.category == _selectedCategory;

      // Brand filter
      bool brandMatch = _selectedBrand == "All" ||
          product.shop.toLowerCase().contains(_selectedBrand.toLowerCase());

      // Price filter
      double price = double.parse(product.price.replaceAll('\$', ''));
      bool priceMatch = price >= _minPrice && price <= _maxPrice;

      // Search filter
      bool searchMatch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase());

      return categoryMatch && brandMatch && priceMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // 1. Compact Header (SliverAppBar)
          SliverAppBar(
            expandedHeight: 280, // Reduced from 340
            pinned: true,
            backgroundColor: const Color(0xFF3D5150),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
               Row(
                children: [
                  _buildHeaderIcon(
                    icon: _favoriteCount > 0 ? Icons.favorite : Icons.favorite_border,
                    count: _favoriteCount,
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  _buildHeaderIcon(
                    icon: Icons.shopping_cart_outlined,
                    count: _cartCount,
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Cover Image
                  Image(
                    image: widget.coverImage.startsWith('assets/')
                        ? AssetImage(widget.coverImage)
                        : NetworkImage(widget.coverImage) as ImageProvider,
                    fit: BoxFit.cover,
                    color: const Color(0xFF3D5150).withOpacity(0.6),
                    colorBlendMode: BlendMode.darken,
                  ),
                  // Content Overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF3D5150).withOpacity(0.9),
                            const Color(0xFF3D5150),
                          ],
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Logo
                          Container(
                            width: 80, // Smaller logo
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: widget.logoImage.startsWith('assets/')
                                  ? Image.asset(widget.logoImage, fit: BoxFit.cover)
                                  : Image.network(widget.logoImage, fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Name & Stats
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.shopName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildCompactStat(Icons.grid_view_rounded, '${widget.shopProductCount} Items'),
                                    const SizedBox(width: 12),
                                    _buildCompactStat(Icons.visibility_rounded, widget.shopViews),
                                    const SizedBox(width: 12),
                                    _buildCompactStat(Icons.category_rounded, widget.shopCategory),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Info Section (Collapsible/Compact)
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 14, color: const Color(0xFF3D5150).withOpacity(0.7)),
                      const SizedBox(width: 4),
                      Text(widget.shopLocation, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF3D5150))),
                      const SizedBox(width: 16),
                      Icon(Icons.email, size: 14, color: const Color(0xFF3D5150).withOpacity(0.7)),
                      const SizedBox(width: 4),
                      Text(widget.shopEmail, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF3D5150))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.shopDescription,
                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF3D5150).withOpacity(0.8), height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),

          // 3. Search & Filter Bar (Sticky)
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            toolbarHeight: 70,
            backgroundColor: const Color(0xFFF8F9FA),
            elevation: 0,
            flexibleSpace: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                children: [
                  // Search Field
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val),
                        style: GoogleFonts.poppins(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search in shop...',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                          prefixIcon: const Icon(Icons.search, color: Color(0xFF3D5150), size: 20),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Filter Toggle Button
                  GestureDetector(
                    onTap: () => setState(() => _isFiltersExpanded = !_isFiltersExpanded),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _isFiltersExpanded ? const Color(0xFF3D5150) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: _isFiltersExpanded ? Colors.white : const Color(0xFF3D5150),
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Collapsible Filters
          SliverToBoxAdapter(
            child: AnimatedCrossFade(
              firstChild: Container(height: 0),
              secondChild: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filters', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF3D5150))),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildCompactDropdown(_selectedCategory, _categories, 'Category')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCompactDropdown(_selectedBrand, _brands, 'Brand')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Price Range: \$${_minPrice.toInt()} - \$${_maxPrice.toInt()}', 
                         style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF3D5150))),
                    RangeSlider(
                      values: RangeValues(_minPrice, _maxPrice),
                      min: 0,
                      max: 500,
                      divisions: 10,
                      activeColor: const Color(0xFF1CE2D6),
                      inactiveColor: Colors.grey[200],
                      onChanged: (val) => setState(() {
                        _minPrice = val.start;
                        _maxPrice = val.end;
                      }),
                    ),
                  ],
                ),
              ),
              crossFadeState: _isFiltersExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ),

          // 5. Product Grid
          filteredProducts.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text('No products found', style: GoogleFonts.poppins(color: Colors.grey)),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.60,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildProductCard(filteredProducts[index]),
                      childCount: filteredProducts.length,
                    ),
                  ),
                ),
           const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon({required IconData icon, required int count, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            if (count > 0)
              Positioned(
                top: -8,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Color(0xFF1CE2D6), shape: BoxShape.circle),
                  child: Text('$count', style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 14),
        const SizedBox(width: 4),
        Text(text, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  Widget _buildCompactDropdown(String value, List<String> items, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF3D5150)),
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF3D5150)),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) {
             if (val == null) return;
             setState(() {
               if (label == 'Category') _selectedCategory = val;
               if (label == 'Brand') _selectedBrand = val;
             });
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
              onAddToCart: () => _addToCart(product),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with Favorite Button
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: product.color.withOpacity(0.08),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      product.icon,
                      color: product.color,
                      size: 48,
                    ),
                  ),
                ),
                // Favorite Button
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(product),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite
                            ? Colors.red
                            : const Color(0xFF3D5150),
                        size: 16,
                      ),
                    ),
                  ),
                ),
                // Brand Name Badge
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      product.shop,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D5150),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D5150),
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Category and Rating in same row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Category
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.category_rounded,
                                color: const Color(0xFF3D5150).withOpacity(0.5),
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  product.category,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color:
                                        const Color(0xFF3D5150).withOpacity(0.6),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Rating
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: const Color(0xFFFFC107),
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                product.rating.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Price and Cart Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.price,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1CE2D6),
                              ),
                            ),
                            if (product.cartQuantity > 0)
                              Text(
                                '${product.cartQuantity} in cart',
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  color:
                                      const Color(0xFF3D5150).withOpacity(0.5),
                                ),
                              ),
                          ],
                        ),
                        // Add to Cart Button
                        GestureDetector(
                          onTap: () => _addToCart(product),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3D5150),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}