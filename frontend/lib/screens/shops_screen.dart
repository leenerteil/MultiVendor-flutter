import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Shop {
  final String id;
  final String name;
  final String category;
  final String description;
  final double rating;
  final int productCount;
  final String imageAsset; // Changed from IconData to String for image asset
  final List<String> tags;
  bool isFavorite;

  Shop({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.productCount,
    required this.imageAsset,
    required this.tags,
    this.isFavorite = false,
  });
}

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  final List<Shop> _allShops = [
    Shop(
      id: '1',
      name: 'Skin & Grin',
      category: 'Beauty',
      description: 'Premium skincare products for radiant skin',
      rating: 4.7,
      productCount: 42,
      imageAsset: 'assets/images/skin_grin.png', // Image asset path
      tags: ['Skincare', 'Beauty', 'Organic', 'Premium'],
    ),
    Shop(
      id: '2',
      name: 'Hanan Boutique',
      category: 'Fashion',
      description: 'Latest fashion trends & designer collections',
      rating: 4.5,
      productCount: 56,
      imageAsset: 'assets/images/hanan_boutique.png',
      tags: ['Fashion', 'Clothing', 'Designer', 'Trendy'],
    ),
    Shop(
      id: '3',
      name: 'Tech Gadgets',
      category: 'Electronics',
      description: 'Latest tech gadgets & smart devices',
      rating: 4.8,
      productCount: 38,
      imageAsset: 'assets/images/tech_gadgets.png',
      tags: ['Electronics', 'Gadgets', 'Smart', 'Tech'],
    ),
    Shop(
      id: '4',
      name: 'FreshMart',
      category: 'Groceries',
      description: 'Fresh groceries & daily essentials',
      rating: 4.6,
      productCount: 89,
      imageAsset: 'assets/images/freshmart.png',
      tags: ['Groceries', 'Fresh', 'Organic', 'Essentials'],
    ),
    Shop(
      id: '5',
      name: 'Book Haven',
      category: 'Books',
      description: 'Wide collection of books & stationery',
      rating: 4.9,
      productCount: 24,
      imageAsset: 'assets/images/book_haven.png',
      tags: ['Books', 'Stationery', 'Educational', 'Novels'],
    ),
    Shop(
      id: '6',
      name: 'Fit Gear',
      category: 'Sports',
      description: 'Sports equipment & fitness gear',
      rating: 4.4,
      productCount: 31,
      imageAsset: 'assets/images/fit_gear.png',
      tags: ['Sports', 'Fitness', 'Equipment', 'Gear'],
    ),
  ];

  final List<String> _categories = [
    'All',
    'Beauty',
    'Fashion',
    'Electronics',
    'Groceries',
    'Books',
    'Sports',
  ];

  String _selectedCategory = 'All';
  String _searchQuery = '';
  int _favoriteCount = 0; // Initial favorite count
  List<Shop> _filteredShops = [];

  @override
  void initState() {
    super.initState();
    _filteredShops = _allShops;
  }

  void _toggleFavorite(Shop shop) {
    setState(() {
      shop.isFavorite = !shop.isFavorite;
      if (shop.isFavorite) {
        _favoriteCount++;
      } else {
        _favoriteCount--;
      }
    });
  }

  void _visitShop(Shop shop) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Visiting ${shop.name}...'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _filterShops() {
    List<Shop> filtered = _allShops;

    // Apply category filter
    if (_selectedCategory != 'All') {
      filtered = filtered.where((shop) => shop.category == _selectedCategory).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((shop) {
        return shop.name.toLowerCase().contains(query) ||
            shop.category.toLowerCase().contains(query) ||
            shop.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    setState(() {
      _filteredShops = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF3D5150),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            // Main Text
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                'Discover Shops',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // Decorative Underline
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: 50, // Halfy underline
                                height: 3,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1CE2D6),
                                  borderRadius: BorderRadius.circular(1.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Browse our curated collection of vendors',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    // Favorite Badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1CE2D6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        if (_favoriteCount > 0)
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '$_favoriteCount',
                                style: const TextStyle(
                                  color: Color(0xFF3D5150),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search Bar with better text alignment
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF3D5150),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                                _filterShops();
                              });
                            },
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF3D5150),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search shops by name...',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF9E9E9E),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal:0,vertical: 10),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Categories Filter
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                            _filterShops();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF1CE2D6)
                                : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected
                                ? null
                                : Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Text(
                            category,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.white70,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Shops List
          Expanded(
            child: _filteredShops.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store_mall_directory,
                          size: 64,
                          color: const Color(0xFF3D5150).withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No shops found',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search or category',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF999999),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _filteredShops.length,
                    itemBuilder: (context, index) {
                      final shop = _filteredShops[index];
                      return _buildShopCard(shop);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopCard(Shop shop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop Header with Image
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: AssetImage(shop.imageAsset),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Stack(
              children: [
                // Dark overlay for better text visibility
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
                // Favorite Button
                Positioned(
                  right: 20,
                  top: 20,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(shop),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        shop.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: shop.isFavorite ? Colors.red : const Color(0xFF3D5150),
                        size: 20,
                      ),
                    ),
                  ),
                ),
                // Shop Name Overlay at bottom
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.name,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        shop.category,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Shop Details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  shop.description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF666666),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: shop.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1CE2D6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF1CE2D6).withOpacity(0.3)),
                      ),
                      child: Text(
                        '#$tag',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1CE2D6),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Stats and Action Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Stats
                    Expanded(
                      child: Row(
                        children: [
                          // Rating
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFB300),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${shop.rating}',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          // Products Count
                          Flexible(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.inventory_2_outlined,
                                  color: Color(0xFF3D5150),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    '${shop.productCount} products',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF666666),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Visit Shop Button
                    ElevatedButton(
                      onPressed: () => _visitShop(shop),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF1CE2D6),
                              const Color(0xFF3D5150),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Visit Shop',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                            ],
                          ),
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
    );
  }
}