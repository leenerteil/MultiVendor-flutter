import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_detail_screen.dart';
import '../models/product.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

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
  String _selectedCategory = "all";
  String _selectedBrand = "all";
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
      category: 'skincare',
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
      category: 'skincare',
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
      category: 'skincare',
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
      category: 'masks',
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
      category: 'masks',
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
      category: 'toners',
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
      category: 'suncare',
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
      category: 'lipCare',
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
      category: 'bodyCare',
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
      category: 'cleansers',
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
      category: 'essences',
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
      category: 'bodyCare',
      shop: 'Skin & Grin',
      rating: 4.1,
      color: const Color(0xFFFFF3CD),
      icon: Icons.spa,
      isFavorite: false,
      cartQuantity: 0,
    ),
  ];

  // Filter Options specific to this shop
  final List<String> _categoryKeys = [
    "all",
    "skincare",
    "masks",
    "toners",
    "suncare",
    "lipCare",
    "bodyCare",
    "cleansers",
    "essences",
  ];

  final List<String> _brands = [
    "all",
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

  String _getLocalizedCategoryName(String key) {
    switch (key) {
      case 'skincare':
        return AppLocalizations.of(context)!.skincare;
      case 'masks':
        return AppLocalizations.of(context)!.masks;
      case 'toners':
        return AppLocalizations.of(context)!.toners;
      case 'suncare':
        return AppLocalizations.of(context)!.suncare;
      case 'lipCare':
        return AppLocalizations.of(context)!.lipCare;
      case 'bodyCare':
        return AppLocalizations.of(context)!.bodyCare;
      case 'cleansers':
        return AppLocalizations.of(context)!.cleansers;
      case 'essences':
        return AppLocalizations.of(context)!.essences;
      default:
        return key;
    }
  }

  List<Product> _getFilteredProducts() {
    return _shopProducts.where((product) {
      // Category filter
      bool categoryMatch = _selectedCategory == "all" ||
          product.category == _selectedCategory;

      // Brand filter
      bool brandMatch = _selectedBrand == "all" ||
          product.shop.toLowerCase().contains(_selectedBrand.toLowerCase());

      // Price filter
      double price = double.parse(product.price.replaceAll('\$', ''));
      bool priceMatch = price >= _minPrice && price <= _maxPrice;

      // Search filter
      bool searchMatch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          _getLocalizedCategoryName(product.category).toLowerCase().contains(_searchQuery.toLowerCase());

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
            expandedHeight: 280,
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
                            width: 80,
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
                                    _buildCompactStat(
                                      Icons.grid_view_rounded, 
                                      AppLocalizations.of(context)!.itemsCount(widget.shopProductCount)
                                    ),
                                    const SizedBox(width: 12),
                                    _buildCompactStat(
                                      Icons.visibility_rounded, 
                                      AppLocalizations.of(context)!.viewsCount(widget.shopViews)
                                    ),
                                    const SizedBox(width: 12),
                                    _buildCompactStat(
                                      Icons.category_rounded, 
                                      _getLocalizedCategoryName(widget.shopCategory)
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
                    style: GoogleFonts.poppins(
                      fontSize: 13, 
                      color: const Color(0xFF3D5150).withOpacity(0.8), 
                      height: 1.5
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),

          // 3. Search & Filter Bar (Sticky) - No space when closed
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchAndFilterHeaderDelegate(
              searchQuery: _searchQuery,
              onSearchChanged: (val) => setState(() => _searchQuery = val),
              isFiltersExpanded: _isFiltersExpanded,
              onFilterToggle: () => setState(() => _isFiltersExpanded = !_isFiltersExpanded),
              selectedCategory: _selectedCategory,
              categoryKeys: _categoryKeys,
              selectedBrand: _selectedBrand,
              brands: _brands,
              minPrice: _minPrice,
              maxPrice: _maxPrice,
              onPriceChanged: (val) {
                setState(() {
                  _minPrice = val.start;
                  _maxPrice = val.end;
                });
              },
              onCategoryChanged: (val) => setState(() => _selectedCategory = val),
              onBrandChanged: (val) => setState(() => _selectedBrand = val),
              getLocalizedCategoryName: _getLocalizedCategoryName,
            ),
          ),

          // 4. Product Grid - directly after the search/filter bar
          filteredProducts.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty 
                              ? AppLocalizations.of(context)!.noProductsAvailable
                              : AppLocalizations.of(context)!.noProductsFound,
                            style: GoogleFonts.poppins(color: Colors.grey)
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                  child: Text(
                    '$count', 
                    style: const TextStyle(
                      fontSize: 8, 
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                    )
                  ),
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
        Text(
          text, 
          style: GoogleFonts.poppins(
            color: Colors.white70, 
            fontSize: 11
          )
        ),
      ],
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
                                  _getLocalizedCategoryName(product.category),
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF3D5150).withOpacity(0.6),
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
                                AppLocalizations.of(context)!.inCartCount(product.cartQuantity),
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  color: const Color(0xFF3D5150).withOpacity(0.5),
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

// Custom delegate for the search and filter header


class _SearchAndFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final bool isFiltersExpanded;
  final VoidCallback onFilterToggle;
  final String selectedCategory;
  final List<String> categoryKeys;
  final String selectedBrand;
  final List<String> brands;
  final double minPrice;
  final double maxPrice;
  final Function(RangeValues) onPriceChanged;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onBrandChanged;
  final String Function(String) getLocalizedCategoryName;

  _SearchAndFilterHeaderDelegate({
    required this.searchQuery,
    required this.onSearchChanged,
    required this.isFiltersExpanded,
    required this.onFilterToggle,
    required this.selectedCategory,
    required this.categoryKeys,
    required this.selectedBrand,
    required this.brands,
    required this.minPrice,
    required this.maxPrice,
    required this.onPriceChanged,
    required this.onCategoryChanged,
    required this.onBrandChanged,
    required this.getLocalizedCategoryName,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFF8F9FA),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search Bar - Always visible
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      onChanged: onSearchChanged,
                      controller: TextEditingController(text: searchQuery),
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchInShopHint,
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
                  onTap: onFilterToggle,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isFiltersExpanded ? const Color(0xFF3D5150) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      color: isFiltersExpanded ? Colors.white : const Color(0xFF3D5150),
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Filters (Collapsible) - Only shows when expanded
          if (isFiltersExpanded)
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),              
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                     
                      Row(
                        children: [
                          Expanded(
                            child: _buildCompactDropdown(
                              context,
                              selectedCategory, 
                              categoryKeys, 
                              AppLocalizations.of(context)!.category,
                              isCategory: true,
                              onChanged: onCategoryChanged,
                              getLocalizedCategoryName: getLocalizedCategoryName,
                            )
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildCompactDropdown(
                              context,
                              selectedBrand, 
                              brands, 
                              AppLocalizations.of(context)!.brand,
                              onChanged: onBrandChanged,
                              getLocalizedCategoryName: getLocalizedCategoryName,
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${AppLocalizations.of(context)!.priceRange}: \$${minPrice.toInt()} - \$${maxPrice.toInt()}',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF3D5150)
                        )
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 30, 
                        child: RangeSlider(
                          values: RangeValues(minPrice, maxPrice),
                          min: 0,
                          max: 500,
                          divisions: 10,
                          activeColor: const Color(0xFF1CE2D6),
                          inactiveColor: Colors.grey[200],
                          onChanged: onPriceChanged,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCompactDropdown(
    BuildContext context,
    String value, 
    List<String> items, 
    String label, {
    bool isCategory = false,
    required ValueChanged<String> onChanged,
    required String Function(String) getLocalizedCategoryName,
  }) {
    String getDisplayText(String item) {
      if (item == 'all') {
        return AppLocalizations.of(context)!.all;
      }
      if (isCategory) {
        return getLocalizedCategoryName(item);
      }
      return item;
    }

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF3D5150), size: 18),
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF3D5150)),
          items: items.map((e) => DropdownMenuItem(
            value: e, 
            child: Text(
              getDisplayText(e),
              style: GoogleFonts.poppins(fontSize: 11),
            )
          )).toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => isFiltersExpanded ? 190 : 70;  // Increased from 155 to 190
  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant _SearchAndFilterHeaderDelegate oldDelegate) {
    return searchQuery != oldDelegate.searchQuery ||
        isFiltersExpanded != oldDelegate.isFiltersExpanded ||
        selectedCategory != oldDelegate.selectedCategory ||
        selectedBrand != oldDelegate.selectedBrand ||
        minPrice != oldDelegate.minPrice ||
        maxPrice != oldDelegate.maxPrice;
  }
}