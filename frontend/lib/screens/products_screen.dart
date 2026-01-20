import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_detail_screen.dart';
import '../models/product.dart';
import '../widgets/shop_owner_drawer.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/rtl_helper.dart'; 

class ProductsScreen extends StatefulWidget {
  final bool isShopOwner;
  final bool showBackButton;
  const ProductsScreen({super.key, this.isShopOwner = false, this.showBackButton = false});

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

  // Mock Products Data - using keys for localization
  final List<Product> _products = [
    // ... (keep your existing product list unchanged)
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

  // Filter Options using keys - updated to match your ARB file
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
      case 'electronics':
        return AppLocalizations.of(context)!.electronics;
      case 'fashion':
        return AppLocalizations.of(context)!.fashion;
      case 'homeGarden':
        return AppLocalizations.of(context)!.homeGarden;
      case 'sports':
        return AppLocalizations.of(context)!.sports;
      case 'groceries':
        return AppLocalizations.of(context)!.groceries;
      case 'beauty':
        return AppLocalizations.of(context)!.beauty;
      case 'books':
        return AppLocalizations.of(context)!.books;
      default:
        return key;
    }
  }

  String _getLocalizedBrandName(String brand) {
    if (brand == 'all') {
      return AppLocalizations.of(context)!.allBrands;
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
          _getLocalizedCategoryName(product.category).toLowerCase().contains(_searchQuery.toLowerCase());

      return categoryMatch && brandMatch && priceMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: widget.isShopOwner ? ShopOwnerDrawer(
        currentScreen: AppLocalizations.of(context)!.products,
      ) : null,
      body: Column(
        children: [
          // Dark Header Section
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF3D5150),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  children: [
                    // App Bar with Logo and Icons
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Menu Icon and Logo Row
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
                                const SizedBox(width: 8),
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
                                const SizedBox(width: 8),
                              ],
                              // Logo Image
                              Image.asset(
                                'assets/images/shopzy_logo.png',
                                height: 80,
                                width: 80,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          // Icons with badges
                          Row(
                            children: [
                              // Favorite Icon with Badge
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.favorite_border,
                                        color: Colors.white, size: 22),
                                    onPressed: () {},
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                  ),
                                  if (_favoriteCount > 0)
                                    Positioned(
                                      right: -2,
                                      top: -2,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF1CE2D6),
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 18,
                                          minHeight: 18,
                                        ),
                                        child: Text(
                                          '$_favoriteCount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 4),
                              // Cart Icon with Badge
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                        size: 22),
                                    onPressed: () {},
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                  ),
                                  if (_cartCount > 0)
                                    Positioned(
                                      right: -2,
                                      top: -2,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF1CE2D6),
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 18,
                                          minHeight: 18,
                                        ),
                                        child: Text(
                                          '$_cartCount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Page Title
                    Row(
                      children: [
                        Icon(
                          Icons.grid_view_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.products,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    
                    // FIXED: Subtitle with proper RTL alignment
                    Container(
                      width: double.infinity,
                      alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: isRTL 
                          ? const EdgeInsets.only(left: 108, right: 0) 
                          : const EdgeInsets.only(right: 108, left: 0),
                        child: Text(
                          AppLocalizations.of(context)!.discoverProductsSubtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: isRTL ? TextAlign.right : TextAlign.left,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),

                    // Search Bar
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          children: [
                            const Icon(Icons.search,
                                color: Color(0xFF3D5150), size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF3D5150),
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!.searchHint,
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: const Color(0xFF9E9E9E),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 8),
                                ),
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
          ),

          // Filters Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Filter Row
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterDropdown(
                        value: _selectedCategory,
                        items: _categoryKeys,
                        isCategory: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildFilterDropdown(
                        value: _selectedBrand,
                        items: _brands,
                        isCategory: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Price Range
                Row(
                  children: [
                    Expanded(
                      child: _buildPriceInput(
                        AppLocalizations.of(context)!.minPrice,
                        _minPrice,
                        (value) {
                          setState(() {
                            _minPrice = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildPriceInput(
                        AppLocalizations.of(context)!.maxPrice,
                        _maxPrice,
                        (value) {
                          setState(() {
                            _maxPrice = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Results Count - FIXED RTL alignment
                const SizedBox(height: 10),
                Align(
                  alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.productsFound(filteredProducts.length),
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF3D5150).withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  ),
                ),
              ],
            ),
          ),

          // Products Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 50,
                          color: const Color(0xFF3D5150).withOpacity(0.3),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _searchQuery.isEmpty
                              ? AppLocalizations.of(context)!.noProductsAvailable
                              : AppLocalizations.of(context)!.noProductsFound,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: const Color(0xFF3D5150),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          AppLocalizations.of(context)!.adjustFiltersHint,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF3D5150).withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
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
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required bool isCategory,
  }) {
    String getDisplayText(String item) {
      if (isCategory) {
        if (item == 'all') {
          return AppLocalizations.of(context)!.allCategories;
        }
        return _getLocalizedCategoryName(item);
      } else {
        return _getLocalizedBrandName(item);
      }
    }

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down_rounded, size: 20),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              getDisplayText(value),
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF3D5150),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            if (value != null) {
              if (isCategory) {
                _selectedCategory = value;
              } else {
                _selectedBrand = value;
              }
            }
          });
        },
      ),
    );
  }

  Widget _buildPriceInput(
      String label, double value, ValueChanged<double> onChanged) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          decoration: InputDecoration(
            hintText: label,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(bottom: 8),
            hintStyle: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF3D5150).withOpacity(0.6),
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: (text) {
            if (text.isNotEmpty) {
              final parsedValue = double.tryParse(text);
              if (parsedValue != null) {
                onChanged(parsedValue);
              }
            }
          },
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF3D5150),
          ),
        ),
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
                // Brand Name Badge - FIXED RTL positioning
                Positioned(
                  top: 6,
                  left: isRTL ? null : 6,
                  right: isRTL ? 6 : null,
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
                                    color: const Color(0xFF3D5150).withOpacity(0.6),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: isRTL ? TextAlign.right : TextAlign.left,
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
                          crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.price,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1CE2D6),
                              ),
                              textAlign: isRTL ? TextAlign.right : TextAlign.left,
                            ),
                            if (product.cartQuantity > 0)
                              Text(
                                AppLocalizations.of(context)!.inCartCount(product.cartQuantity),
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  color: const Color(0xFF3D5150).withOpacity(0.5),
                                ),
                                textAlign: isRTL ? TextAlign.right : TextAlign.left,
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