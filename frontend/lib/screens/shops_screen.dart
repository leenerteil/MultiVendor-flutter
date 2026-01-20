import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shop_owner_drawer.dart';
import 'shop_screen.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

class Shop {
  final String id;
  final String name;
  final String category;
  final String description;
  final double rating;
  final int productCount;
  final String email;
  final String location;
  final String views;
  final String imageAsset; // Changed from IconData to String for image asset
  final List<String> tags;
  Shop({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.productCount,
    required this.email,
    required this.location,
    required this.views,
    required this.imageAsset,
    required this.tags,
  });
}

class ShopsScreen extends StatefulWidget {
  final bool isShopOwner;
  final bool showBackButton;
  const ShopsScreen({super.key, this.isShopOwner = false, this.showBackButton = false});

  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Shop> _allShops = [
    Shop(
      id: '1',
      name: 'Skin & Grin',
      category: 'beauty',
      description: '✨ وكيل رسمي لمستحضرات لادورا الفاخرة ✨ 🌿منتجات طبيعية مستخلصة من الطبيعة🌿 🛵 نوصل الجمال إلى جميع أنحاء لبنان 🛵',
      rating: 4.7,
      productCount: 15,
      email: 'SkinGrin@gmail.com',
      location: 'حارة حريك',
      views: '20',
      imageAsset: 'assets/images/skin_grin.png', // Image asset path
      tags: ['Skincare', 'Beauty', 'Organic', 'Premium'],
    ),
    Shop(
      id: '2',
      name: 'Hanan Boutique',
      category: 'fashion',
      description: 'Latest fashion trends & designer collections',
      rating: 4.5,
      productCount: 56,
      email: 'info@hananboutique.com',
      location: 'Beirut',
      views: '1.2k',
      imageAsset: 'assets/images/hanan_boutique.png',
      tags: ['Fashion', 'Clothing', 'Designer', 'Trendy'],
    ),
    Shop(
      id: '3',
      name: 'Tech Gadgets',
      category: 'electronics',
      description: 'Latest tech gadgets & smart devices',
      rating: 4.8,
      productCount: 38,
      email: 'sales@techgadgets.com',
      location: 'Tripoli',
      views: '850',
      imageAsset: 'assets/images/tech_gadgets.png',
      tags: ['Electronics', 'Gadgets', 'Smart', 'Tech'],
    ),
    Shop(
      id: '4',
      name: 'FreshMart',
      category: 'groceries',
      description: 'Fresh groceries & daily essentials',
      rating: 4.6,
      productCount: 89,
      email: 'support@freshmart.com',
      location: 'Saida',
      views: '2.5k',
      imageAsset: 'assets/images/freshmart.png',
      tags: ['Groceries', 'Fresh', 'Organic', 'Essentials'],
    ),
    Shop(
      id: '5',
      name: 'Book Haven',
      category: 'books',
      description: 'Wide collection of books & stationery',
      rating: 4.9,
      productCount: 24,
      email: 'hello@bookhaven.com',
      location: 'Jounieh',
      views: '400',
      imageAsset: 'assets/images/book_haven.png',
      tags: ['Books', 'Stationery', 'Educational', 'Novels'],
    ),
    Shop(
      id: '6',
      name: 'Fit Gear',
      category: 'sports',
      description: 'Sports equipment & fitness gear',
      rating: 4.4,
      productCount: 31,
      email: 'team@fitgear.com',
      location: 'Tyre',
      views: '920',
      imageAsset: 'assets/images/fit_gear.png',
      tags: ['Sports', 'Fitness', 'Equipment', 'Gear'],
    ),
  ];

  // Use category keys instead of display names
  final List<String> _categoryKeys = [
    'all',
    'beauty',
    'fashion',
    'electronics',
    'groceries',
    'books',
    'sports',
  ];

  String _selectedCategory = 'all';
  String _searchQuery = '';
  List<Shop> _filteredShops = [];

  @override
  void initState() {
    super.initState();
    _filteredShops = _allShops;
  }

  void _visitShop(Shop shop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopScreen(
          shopName: shop.name,
          shopDescription: shop.description,
          shopEmail: shop.email,
          shopLocation: shop.location,
          shopViews: shop.views,
          shopProductCount: shop.productCount,
          shopCategory: shop.category,
          coverImage: shop.imageAsset,
          logoImage: shop.imageAsset,
          isShopOwner: widget.isShopOwner,
        ),
      ),
    );
  }

  void _filterShops() {
    List<Shop> filtered = _allShops;

    // Apply category filter
    if (_selectedCategory != 'all') {
      filtered = filtered.where((shop) => shop.category == _selectedCategory).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((shop) {
        return shop.name.toLowerCase().contains(query) ||
            _getLocalizedCategoryName(shop.category).toLowerCase().contains(query) ||
            shop.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    setState(() {
      _filteredShops = filtered;
    });
  }

  String _getLocalizedCategoryName(String key) {
    switch (key) {
      case 'beauty':
        return AppLocalizations.of(context)!.beauty;
      case 'fashion':
        return AppLocalizations.of(context)!.fashion;
      case 'electronics':
        return AppLocalizations.of(context)!.electronics;
      case 'groceries':
        return AppLocalizations.of(context)!.groceries;
      case 'books':
        return AppLocalizations.of(context)!.books;
      case 'sports':
        return AppLocalizations.of(context)!.sports;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: widget.isShopOwner ? ShopOwnerDrawer(
        currentScreen: AppLocalizations.of(context)!.shops,
      ) : null,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 16,
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
                Row(
                  children: [
                    // Back Arrow Button (only show when showBackButton is true)
                    if (widget.showBackButton) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (widget.isShopOwner) ...[
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.menu_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            // Main Text
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                AppLocalizations.of(context)!.discoverShops,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
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
                                width: 40,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1CE2D6),
                                  borderRadius: BorderRadius.circular(1.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          AppLocalizations.of(context)!.browseCuratedVendors,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Search Bar with better text alignment
                Container(
                  height: 36,
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
                              isDense: true,
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.searchShopsHint,
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF9E9E9E),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
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
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryKeys.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final categoryKey = _categoryKeys[index];
                      final isSelected = _selectedCategory == categoryKey;
                      String displayText;
                      
                      if (categoryKey == 'all') {
                        displayText = AppLocalizations.of(context)!.all;
                      } else {
                        displayText = _getLocalizedCategoryName(categoryKey);
                      }
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = categoryKey;
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
                            displayText,
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
                          _searchQuery.isNotEmpty
                              ? AppLocalizations.of(context)!.noShopsFound
                              : AppLocalizations.of(context)!.noShopsAvailable,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _searchQuery.isNotEmpty
                              ? AppLocalizations.of(context)!.noResultsFor(_searchQuery)
                              : AppLocalizations.of(context)!.shopsWillAppearHere,
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
                        _getLocalizedCategoryName(shop.category),
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
                                    AppLocalizations.of(context)!.productCount(shop.productCount),
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
                                AppLocalizations.of(context)!.visitShop,
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