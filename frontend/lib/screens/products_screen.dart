import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_detail_screen.dart';
import '../models/product.dart';
import '../widgets/shop_owner_drawer.dart';
import '../widgets/custom_screen_header.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

class ProductsScreen extends StatefulWidget {
  final bool isShopOwner;
  final bool showBackButton;
  const ProductsScreen({
    super.key,
    this.isShopOwner = false,
    this.showBackButton = false,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedCategory = "all";
  String _selectedBrand = "all";
  double _minPrice = 0;
  double _maxPrice = 1000;
  String _searchQuery = "";
  int _cartCount = 0;
  int _favoriteCount = 0;
  
  // New state variables
  bool _showSearchBar = false;
  bool _showFilterPanel = false;
  RangeValues _priceRange = const RangeValues(0, 1000);

  // Mock Products Data
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Wireless Bluetooth Headphones',
      price: '\$89.99',
      category: 'electronics',
      shop: 'AudioTech',
      rating: 4.2,
      color: const Color(0xFF1CE2D6),
      icon: Icons.headphones,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '2',
      name: 'Smart Fitness Watch',
      price: '\$199.99',
      category: 'electronics',
      shop: 'FitGear',
      rating: 4.5,
      color: const Color(0xFF3D5150),
      icon: Icons.watch,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '3',
      name: 'Premium Running Shoes',
      price: '\$129.99',
      category: 'sports',
      shop: 'SportStyle',
      rating: 4.3,
      color: const Color(0xFF1CE2D6),
      icon: Icons.directions_run,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '4',
      name: 'Organic Green Tea Pack',
      price: '\$14.99',
      category: 'groceries',
      shop: 'HealthFoods',
      rating: 4.7,
      color: const Color(0xFF3D5150),
      icon: Icons.local_drink,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '5',
      name: 'Modern Desk Lamp',
      price: '\$45.50',
      category: 'homeGarden',
      shop: 'HomeEssentials',
      rating: 4.0,
      color: const Color(0xFF1CE2D6),
      icon: Icons.lightbulb,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '6',
      name: 'Leather Handbag',
      price: '\$159.99',
      category: 'fashion',
      shop: 'FashionBoutique',
      rating: 4.6,
      color: const Color(0xFF3D5150),
      icon: Icons.shopping_bag,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '7',
      name: 'Smartphone 128GB',
      price: '\$699.99',
      category: 'electronics',
      shop: 'TechWorld',
      rating: 4.4,
      color: const Color(0xFF1CE2D6),
      icon: Icons.smartphone,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '8',
      name: 'Yoga Mat Premium',
      price: '\$29.99',
      category: 'sports',
      shop: 'WellnessShop',
      rating: 4.1,
      color: const Color(0xFF3D5150),
      icon: Icons.self_improvement,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '9',
      name: 'Coffee Maker',
      price: '\$89.99',
      category: 'homeGarden',
      shop: 'KitchenPro',
      rating: 4.3,
      color: const Color(0xFF1CE2D6),
      icon: Icons.coffee,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '10',
      name: 'Men\'s Casual Shirt',
      price: '\$39.99',
      category: 'fashion',
      shop: 'UrbanFashion',
      rating: 4.2,
      color: const Color(0xFF3D5150),
      icon: Icons.face_retouching_natural,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '11',
      name: 'Gaming Keyboard',
      price: '\$79.99',
      category: 'electronics',
      shop: 'GameZone',
      rating: 4.5,
      color: const Color(0xFF1CE2D6),
      icon: Icons.keyboard,
      isFavorite: false,
      cartQuantity: 0,
    ),
    Product(
      id: '12',
      name: 'Scented Candles Set',
      price: '\$24.99',
      category: 'homeGarden',
      shop: 'HomeEssentials',
      rating: 4.8,
      color: const Color(0xFF3D5150),
      icon: Icons.local_fire_department,
      isFavorite: false,
      cartQuantity: 0,
    ),
  ];

  final List<String> _categoryKeys = [
    "all",
    "electronics",
    "fashion",
    "homeGarden",
    "sports",
    "groceries",
    "beauty",
    "books",
  ];

  final List<String> _brands = [
    "all",
    "Apple",
    "Samsung",
    "Nike",
    "Sony",
    "Adidas",
    "Amazon",
    "Google",
    "Microsoft",
    "LG",
  ];

  // New: Active filter chips
  List<Map<String, dynamic>> _activeFilters = [];

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

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (_showSearchBar) {
        _showFilterPanel = false;
      }
    });
  }

  void _toggleFilterPanel() {
    setState(() {
      _showFilterPanel = !_showFilterPanel;
      if (_showFilterPanel) {
        _showSearchBar = false;
      }
    });
  }

  void _applyFilters() {
    setState(() {
      _minPrice = _priceRange.start;
      _maxPrice = _priceRange.end;
      _updateActiveFilters();
      _showFilterPanel = false;
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedBrand = "all";
      _priceRange = const RangeValues(0, 1000);
      _minPrice = 0;
      _maxPrice = 1000;
      _activeFilters.clear();
      _showFilterPanel = false;
    });
  }

  void _updateActiveFilters() {
    _activeFilters.clear();
    
    // Add brand filter if not "all"
    if (_selectedBrand != "all") {
      _activeFilters.add({
        'type': 'brand',
        'label': _getLocalizedBrandName(_selectedBrand),
        'value': _selectedBrand,
      });
    }
    
    // Add price filter if not default
    if (_priceRange.start > 0 || _priceRange.end < 1000) {
      _activeFilters.add({
        'type': 'price',
        'label': '\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
        'value': _priceRange,
      });
    }
  }

  void _removeFilter(String type) {
    setState(() {
      _activeFilters.removeWhere((filter) => filter['type'] == type);
      
      if (type == 'brand') {
        _selectedBrand = "all";
      } else if (type == 'price') {
        _priceRange = const RangeValues(0, 1000);
        _minPrice = 0;
        _maxPrice = 1000;
      }
    });
  }

  String _getLocalizedCategoryName(String key) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'electronics':
        return l10n.electronics;
      case 'fashion':
        return l10n.fashion;
      case 'homeGarden':
        return l10n.homeGarden;
      case 'sports':
        return l10n.sports;
      case 'groceries':
        return l10n.groceries;
      case 'beauty':
        return l10n.beauty;
      case 'books':
        return l10n.books;
      default:
        return key;
    }
  }

  String _getLocalizedBrandName(String brand) {
    final l10n = AppLocalizations.of(context)!;
    if (brand == 'all') {
      return l10n.allBrands;
    }
    return brand;
  }

  List<Product> _getFilteredProducts() {
    return _products.where((product) {
      bool categoryMatch = _selectedCategory == "all" ||
          product.category == _selectedCategory;
      bool brandMatch = _selectedBrand == "all" ||
          product.shop.toLowerCase().contains(_selectedBrand.toLowerCase());
      double price = double.parse(product.price.replaceAll('\$', ''));
      bool priceMatch = price >= _minPrice && price <= _maxPrice;
      bool searchMatch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.shop.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          _getLocalizedCategoryName(product.category)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      return categoryMatch && brandMatch && priceMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();
    // final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: widget.isShopOwner
          ? ShopOwnerDrawer(
              currentScreen: AppLocalizations.of(context)!.products,
            )
          : null,
      body: Stack(
        children: [
          Column(
            children: [
              // Dark Header Section
              CustomScreenHeader(
                isShopOwner: widget.isShopOwner,
                showBackButton: widget.showBackButton,
                favoriteCount: _favoriteCount,
                cartCount: _cartCount,
                onSearchTap: _toggleSearchBar,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                AppLocalizations.of(context)!.products,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
                          AppLocalizations.of(context)!.discoverProductsSubtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    // Search Bar (shown when toggled)
                    if (_showSearchBar)
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 16),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(Icons.search,
                                  color: Color(0xFF3D5150), size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      _searchQuery = value;
                                    });
                                  },
                                  autofocus: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xFF3D5150),
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of(context)!.searchHint,
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF9E9E9E),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 10),
                                  ),
                                ),
                              ),
                              if (_searchQuery.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    color: Color(0xFF3D5150),
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Category Tabs Section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categoryKeys.map((category) {
                      final isSelected = _selectedCategory == category;
                      final categoryName = category == "all"
                          ? AppLocalizations.of(context)!.all
                          : _getLocalizedCategoryName(category);
                      
                      return Padding(
                        padding: EdgeInsets.only(
                          left: category == "all" ? 16 : 0,
                          right: category == _categoryKeys.last ? 16 : 8,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF3D5150)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF3D5150)
                                    : const Color(0xFFE0E0E0),
                              ),
                            ),
                            child: Text(
                              categoryName,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF3D5150),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Filter Bar - SIMPLIFIED: No bottom border
              Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Results Count
                    Text(
                      AppLocalizations.of(context)!.productsFound(filteredProducts.length),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF3D5150),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // Filter Button
                    GestureDetector(
                      onTap: _toggleFilterPanel,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _selectedBrand != "all" || _priceRange.start > 0 || _priceRange.end < 1000
                              ? const Color(0xFF1CE2D6).withOpacity(0.1)
                              : const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _selectedBrand != "all" || _priceRange.start > 0 || _priceRange.end < 1000
                                ? const Color(0xFF1CE2D6)
                                : const Color(0xFFE0E0E0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list_rounded,
                              color: _selectedBrand != "all" || _priceRange.start > 0 || _priceRange.end < 1000
                                  ? const Color(0xFF1CE2D6)
                                  : const Color(0xFF3D5150),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              AppLocalizations.of(context)!.filters,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _selectedBrand != "all" || _priceRange.start > 0 || _priceRange.end < 1000
                                    ? const Color(0xFF1CE2D6)
                                    : const Color(0xFF3D5150),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Active Filters Chips - SIMPLIFIED: No bottom border
              if (_activeFilters.isNotEmpty)
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                  color: const Color(0xFFF8F9FA),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ..._activeFilters.map((filter) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(
                              label: Text(
                                filter['label'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              deleteIcon: const Icon(
                                Icons.close_rounded,
                                size: 16,
                                color: Color(0xFF3D5150),
                              ),
                              onDeleted: () => _removeFilter(filter['type']),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                          );
                        }),
                        if (_activeFilters.isNotEmpty)
                          GestureDetector(
                            onTap: _resetFilters,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.clearAll,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF1CE2D6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

              // Add a simple divider line
              if (_activeFilters.isEmpty) // Only show divider when there are no active filters
                Container(
                  height: 1,
                  color: Colors.grey[200],
                  margin: EdgeInsets.zero,
                ),

              // Products Grid - DIRECTLY UNDER THE FILTER BAR
              if (filteredProducts.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return _buildProductCard(filteredProducts[index]);
                      },
                    ),
                  ),
                )
              else
                // Empty State
                  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1), // Compensate for divider
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 60,
                            color: const Color(0xFF3D5150).withOpacity(0.2),
                          ),
                          const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? AppLocalizations.of(context)!.noProductsAvailable
                              : AppLocalizations.of(context)!.noProductsFound,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF3D5150),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.adjustFiltersHint,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF3D5150).withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (_searchQuery.isNotEmpty ||
                            _selectedCategory != "all" ||
                            _selectedBrand != "all" ||
                            _priceRange.start > 0 ||
                            _priceRange.end < 1000)
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: ElevatedButton(
                              onPressed: _resetFilters,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3D5150),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.clearAllFilters,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                  ),
            ],
          ),

          // Filter Panel (Slide-up Modal)
          if (_showFilterPanel)
            Positioned.fill(
              child: GestureDetector(
                onTap: _toggleFilterPanel,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),

          if (_showFilterPanel)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with close button
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 8,
                        top: 16,
                        bottom: 12,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.filters,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF3D5150),
                            ),
                          ),
                          IconButton(
                            onPressed: _toggleFilterPanel,
                            icon: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Color(0xFF3D5150),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Divider
                    Container(
                      height: 1,
                      color: Colors.grey[200],
                    ),
                    
                    // Scrollable filter content
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.7,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Brand Filter Section
                            _buildFilterSection(
                              title: AppLocalizations.of(context)!.brand,
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: _brands.map((brand) {
                                  final isSelected = _selectedBrand == brand;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedBrand = isSelected ? "all" : brand;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF3D5150)
                                            : const Color(0xFFF8F9FA),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFF3D5150)
                                              : Colors.grey[300]!,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        _getLocalizedBrandName(brand),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF3D5150),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Price Range Filter Section
                            _buildFilterSection(
                              title: AppLocalizations.of(context)!.priceRange,
                              child: Column(
                                children: [
                                  RangeSlider(
                                    values: _priceRange,
                                    min: 0,
                                    max: 1000,
                                    divisions: 20,
                                    labels: RangeLabels(
                                      '\$${_priceRange.start.toInt()}',
                                      '\$${_priceRange.end.toInt()}',
                                    ),
                                    activeColor: const Color(0xFF3D5150),
                                    inactiveColor: const Color(0xFFE0E0E0),
                                    onChanged: (values) {
                                      setState(() {
                                        _priceRange = values;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildAlignedPriceInput(
                                        '\$${_priceRange.start.toInt()}',
                                        _priceRange.start,
                                        (value) {
                                          if (value >= 0 && value <= _priceRange.end) {
                                            setState(() {
                                              _priceRange = RangeValues(value, _priceRange.end);
                                            });
                                          }
                                        },
                                      ),
                                      const SizedBox(width: 16),
                                      _buildAlignedPriceInput(
                                        '\$${_priceRange.end.toInt()}',
                                        _priceRange.end,
                                        (value) {
                                          if (value >= _priceRange.start && value <= 1000) {
                                            setState(() {
                                              _priceRange = RangeValues(_priceRange.start, value);
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Apply & Reset Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: _resetFilters,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF3D5150).withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.reset,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF3D5150),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: _applyFilters,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF3D5150),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.apply,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
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

  Widget _buildFilterSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3D5150),
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildAlignedPriceInput(String label, double value, ValueChanged<double> onChanged) {
    return Container(
      width: 100,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Text(
              '\$',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3D5150),
                height: 1.0,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextFormField(
              initialValue: value.toInt().toString(),
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3D5150),
                height: 1.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 1),
                isDense: true,
              ),
              textAlignVertical: TextAlignVertical.center,
              onChanged: (text) {
                if (text.isNotEmpty) {
                  final parsedValue = double.tryParse(text);
                  if (parsedValue != null) {
                    onChanged(parsedValue);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

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
                  right: isRTL ? null : 6,
                  left: isRTL ? 6 : null,
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
                  left: isRTL ? null : 6,
                  right: isRTL ? 6 : null,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      textAlign: isRTL ? TextAlign.right : TextAlign.left,
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
                                    color:
                                        const Color(0xFF3D5150).withOpacity(0.6),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign:
                                      isRTL ? TextAlign.right : TextAlign.left,
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
                          crossAxisAlignment: isRTL
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.price,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1CE2D6),
                              ),
                              textAlign:
                                  isRTL ? TextAlign.right : TextAlign.left,
                            ),
                            if (product.cartQuantity > 0)
                              Text(
                                AppLocalizations.of(context)!
                                    .inCartCount(product.cartQuantity),
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  color:
                                      const Color(0xFF3D5150).withOpacity(0.5),
                                ),
                                textAlign:
                                  isRTL ? TextAlign.right : TextAlign.left,
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