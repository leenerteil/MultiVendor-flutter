import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/shop_owner_drawer.dart';
import 'categories_screen.dart';
import '../widgets/custom_screen_header.dart';
import 'products_screen.dart';
import 'shops_screen.dart';
import 'product_detail_screen.dart';
import '../models/product.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final bool isShopOwner;
  const HomeScreen({super.key, this.isShopOwner = false});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentCarouselIndex = 0;
  late Timer _carouselTimer;
  late PageController _pageController;
  int _cartCount = 0;
  int _favoriteCount = 0;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchBar = false;
  String _searchQuery = '';

  List<Map<String, dynamic>> _getCarouselItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'color': const Color(0xFF1CE2D6),
        'title': l10n.summerCollection,
        'subtitle': l10n.discount50,
        'icon': Icons.local_offer,
      },
      {
        'color': const Color(0xFF3D5150),
        'title': l10n.newArrivals,
        'subtitle': l10n.checkNow,
        'icon': Icons.new_releases,
      },
      {
        'color': const Color(0xFF1CE2D6),
        'title': l10n.exclusiveDeals,
        'subtitle': l10n.limitedTime,
        'icon': Icons.star,
      },
    ];
  }

  List<Map<String, dynamic>> _getStaticAds(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'color': const Color(0xFFFF6B9D),
        'title': l10n.beautySale,
        'subtitle': l10n.upTo70Off,
        'icon': Icons.face_retouching_natural,
      },
      {
        'color': const Color(0xFF4ECDC4),
        'title': l10n.techDeals,
        'subtitle': l10n.latestGadgets,
        'icon': Icons.devices,
      },
      {
        'color': const Color(0xFFFFD166),
        'title': l10n.homeDecor,
        'subtitle': l10n.modernFurniture,
        'icon': Icons.home,
      },
      {
        'color': const Color(0xFF06D6A0),
        'title': l10n.fitnessGear,
        'subtitle': l10n.stayActive,
        'icon': Icons.fitness_center,
      },
      {
        'color': const Color(0xFF118AB2),
        'title': l10n.bookFair,
        'subtitle': l10n.bestSellers,
        'icon': Icons.menu_book,
      },
      {
        'color': const Color(0xFFEF476F),
        'title': l10n.fashionWeek,
        'subtitle': l10n.trendyStyles,
        'icon': Icons.style,
      },
      {
        'color': const Color(0xFF7209B7),
        'title': l10n.gamingZone,
        'subtitle': l10n.newConsoles,
        'icon': Icons.videogame_asset,
      },
      {
        'color': const Color(0xFFF8961E),
        'title': l10n.kitchenware,
        'subtitle': l10n.premiumCookware,
        'icon': Icons.kitchen,
      },
      {
        'color': const Color(0xFF073B4C),
        'title': l10n.smartWatches,
        'subtitle': l10n.healthTracking,
        'icon': Icons.watch,
      },
      {
        'color': const Color(0xFF8338EC),
        'title': l10n.audioGear,
        'subtitle': l10n.premiumSound,
        'icon': Icons.headphones,
      },
    ];
  }

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Wireless Headphones',
      price: '\$79.99',
      category: 'Electronics',
      shop: 'Tech Store',
      rating: 4.5,
      color: const Color(0xFF1CE2D6),
      icon: Icons.headphones,
    ),
    Product(
      id: '2',
      name: 'Smart Watch',
      price: '\$129.99',
      category: 'Electronics',
      shop: 'Tech Store',
      rating: 4.3,
      color: const Color(0xFF3D5150),
      icon: Icons.watch,
    ),
    Product(
      id: '3',
      name: 'Designer Perfume',
      price: '\$49.99',
      category: 'Cosmetics',
      shop: 'Beauty Shop',
      rating: 4.7,
      color: const Color(0xFF1CE2D6),
      icon: Icons.spa,
    ),
    Product(
      id: '4',
      name: 'Fashion Sunglasses',
      price: '\$34.99',
      category: 'Accessories',
      shop: 'Fashion Hub',
      rating: 4.2,
      color: const Color(0xFF3D5150),
      icon: Icons.dark_mode,
    ),
    Product(
      id: '5',
      name: 'Gaming Console',
      price: '\$299.99',
      category: 'Electronics',
      shop: 'Tech Store',
      rating: 4.8,
      color: const Color(0xFF1CE2D6),
      icon: Icons.videogame_asset,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.95);
    _startCarouselTimer();
  }

  @override
  void dispose() {
    _carouselTimer.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _startCarouselTimer() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        final carouselLength = _getCarouselItems(context).length;
        int nextIndex = (_currentCarouselIndex + 1) % carouselLength;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (!_showSearchBar) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  void _filterContent(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
    });
  }

  void _toggleFavorite(Product product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
      if (product.isFavorite) {
        _favoriteCount++;
      } else {
        _favoriteCount--;
      }
      _showSnackBar(product.isFavorite
          ? '${product.name} added to favorites'
          : '${product.name} removed from favorites');
    });
  }

  void _addToCart(Product product) {
    setState(() {
      product.cartQuantity++;
      _cartCount++;
      _showSnackBar('${product.name} added to cart');
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: widget.isShopOwner
          ? const ShopOwnerDrawer(currentScreen: 'Home')
          : null,
      body: Column(
        children: [
          CustomScreenHeader(
            isShopOwner: widget.isShopOwner,
            favoriteCount: _favoriteCount,
            cartCount: _cartCount,
            onSearchTap: _toggleSearchBar,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_showSearchBar)
                  Container(
                    height: 36,
                    margin: const EdgeInsets.only(top: 12, bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: Color(0xFF3D5150), size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: _filterContent,
                              autofocus: true,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFF3D5150),
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    AppLocalizations.of(context)!.searchHint,
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF9E9E9E),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(bottom: 12),
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            GestureDetector(
                              onTap: _clearSearch,
                              child: const Icon(
                                Icons.clear,
                                color: Color(0xFF3D5150),
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: _buildHomeContent(screenWidth),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(double screenWidth) {
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 900;
    final isLargeScreen = screenWidth >= 900;

    final horizontalPadding = isSmallScreen ? 16.0 : (isMediumScreen ? 24.0 : 32.0);
    final carouselHeight = isSmallScreen ? 180.0 : (isMediumScreen ? 210.0 : 240.0);
    final adHeight = isSmallScreen ? 90.0 : 100.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Carousel
        Padding(
          padding: EdgeInsets.fromLTRB(horizontalPadding, 20, horizontalPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: carouselHeight,
                child: Builder(builder: (context) {
                  final carouselItems = _getCarouselItems(context);
                  return PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    },
                    itemCount: carouselItems.length,
                    itemBuilder: (context, index) {
                      final item = carouselItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: _buildCarouselCard(item, isSmallScreen),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 12),
              _buildCarouselIndicators(),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Static Ads Grid - Responsive
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: _buildStaticAdsGrid(isSmallScreen, isMediumScreen, isLargeScreen, adHeight),
        ),

        const SizedBox(height: 30),

        // Popular Products Section
        _buildSectionHeader(
          AppLocalizations.of(context)!.popularProducts,
          AppLocalizations.of(context)!.showAll,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(
                isShopOwner: widget.isShopOwner,
                showBackButton: true,
              ),
            ),
          ),
          horizontalPadding,
        ),

        const SizedBox(height: 12),

        _buildProductsList(isSmallScreen, horizontalPadding),

        const SizedBox(height: 30),

        // Categories Section
        _buildSectionHeader(
          AppLocalizations.of(context)!.categories,
          AppLocalizations.of(context)!.viewAll,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoriesScreen(
                isShopOwner: widget.isShopOwner,
                showBackButton: true,
              ),
            ),
          ),
          horizontalPadding,
        ),

        const SizedBox(height: 15),

        _buildCategoriesList(isSmallScreen, horizontalPadding),

        const SizedBox(height: 30),

        // Featured Shops Section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeaderInline(
                AppLocalizations.of(context)!.featuredShops,
                AppLocalizations.of(context)!.viewAll,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopsScreen(
                      isShopOwner: widget.isShopOwner,
                      showBackButton: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildFeaturedShops(isSmallScreen, isMediumScreen),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Best Sellers Section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeaderInline(
                AppLocalizations.of(context)!.bestSellers,
                AppLocalizations.of(context)!.seeAll,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(
                      isShopOwner: widget.isShopOwner,
                      showBackButton: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildBestSellersGrid(isSmallScreen, isMediumScreen, isLargeScreen),
            ],
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildCarouselCard(Map<String, dynamic> item, bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            item['color'] as Color,
            (item['color'] as Color).withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                AppLocalizations.of(context)!.sponsored,
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 11 : 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 8 : 12),
            Text(
              item['subtitle'] as String,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['title'] as String,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 18 : 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.1,
              ),
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(
                      isShopOwner: widget.isShopOwner,
                      showBackButton: true,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 20 : 24,
                  vertical: isSmallScreen ? 10 : 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 2,
              ),
              child: Text(
                AppLocalizations.of(context)!.shopNow,
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w700,
                  color: item['color'] as Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _getCarouselItems(context).length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentCarouselIndex == index ? 32 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentCarouselIndex == index
                ? const Color(0xFF3D5150)
                : const Color(0xFF3D5150).withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildStaticAdsGrid(
    bool isSmallScreen,
    bool isMediumScreen,
    bool isLargeScreen,
    double adHeight,
  ) {
    final staticAds = _getStaticAds(context);
    
    // Calculate columns based on screen size
    int columns = isLargeScreen ? 3 : 2;
    
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: isLargeScreen ? 2.5 : (isMediumScreen ? 2.2 : 1.8),
      ),
      itemCount: staticAds.length,
      itemBuilder: (context, index) {
        return _buildStaticAd(staticAds[index], isSmallScreen);
      },
    );
  }

  Widget _buildStaticAd(Map<String, dynamic> ad, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ad['color'] as Color,
              (ad['color'] as Color).withOpacity(0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: (ad['color'] as Color).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
          child: Row(
            children: [
              Container(
                width: isSmallScreen ? 36 : 40,
                height: isSmallScreen ? 36 : 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  ad['icon'] as IconData,
                  color: Colors.white,
                  size: isSmallScreen ? 20 : 22,
                ),
              ),
              SizedBox(width: isSmallScreen ? 10 : 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ad['subtitle'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 10 : 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ad['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 12 : 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  Widget _buildSectionHeader(
    String title,
    String actionText,
    VoidCallback onTap,
    double horizontalPadding,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: _buildSectionHeaderInline(title, actionText, onTap),
    );
  }

  Widget _buildSectionHeaderInline(
    String title,
    String actionText,
    VoidCallback onTap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF3D5150),
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
          ),
          child: Row(
            children: [
              Text(
                actionText,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1CE2D6),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF1CE2D6),
                size: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductsList(bool isSmallScreen, double horizontalPadding) {
    return SizedBox(
      height: isSmallScreen ? 200 : 220,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return SizedBox(
            width: isSmallScreen ? 140 : 150,
            child: _buildProductItem(product, isSmallScreen),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesList(bool isSmallScreen, double horizontalPadding) {
    final l10n = AppLocalizations.of(context)!;
    List<Map<String, dynamic>> categories = [
      {'title': l10n.electronics, 'icon': Icons.electrical_services},
      {'title': l10n.accessories, 'icon': Icons.watch},
      {'title': l10n.cosmetics, 'icon': Icons.spa},
      {'title': l10n.groceries, 'icon': Icons.shopping_cart},
      {'title': l10n.fashion, 'icon': Icons.shopping_bag},
    ];

    return SizedBox(
      height: isSmallScreen ? 110 : 120,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: isSmallScreen ? 70 : 80,
            child: _buildCategoryItem(
              categories[index]['title'] as String,
              categories[index]['icon'] as IconData,
              isSmallScreen,
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedShops(bool isSmallScreen, bool isMediumScreen) {
    return Row(
      children: [
        Expanded(
          child: _buildShopItem(
            'Skin & Grin',
            Icons.face_retouching_natural,
            const Color(0xFF1CE2D6),
            isSmallScreen,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildShopItem(
            'Hanan Boutique',
            Icons.shopping_bag,
            const Color(0xFF3D5150),
            isSmallScreen,
          ),
        ),
      ],
    );
  }

  Widget _buildBestSellersGrid(
  bool isSmallScreen,
  bool isMediumScreen,
  bool isLargeScreen,
) {
  int columns = isLargeScreen ? 4 : (isMediumScreen ? 3 : 2);
  
  return GridView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: columns,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: isSmallScreen ? 0.85 : 0.90,
    ),
    itemCount: 4,
    itemBuilder: (context, index) {
      final product = _products[index];
      return _buildBestSellerItem(product, isSmallScreen);
    },
  );
}

  Widget _buildCategoryItem(String title, IconData icon, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: isSmallScreen ? 56 : 60,
            height: isSmallScreen ? 56 : 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1CE2D6).withOpacity(0.1),
                  const Color(0xFF3D5150).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFF1CE2D6).withOpacity(0.3),
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF3D5150),
              size: isSmallScreen ? 26 : 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isSmallScreen ? 10 : 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3D5150),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildShopItem(
    String title,
    IconData icon,
    Color bgColor,
    bool isSmallScreen,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: isSmallScreen ? 130 : 145,
        padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isSmallScreen ? 36 : 40,
              height: isSmallScreen ? 36 : 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: isSmallScreen ? 18 : 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 11 : 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF3D5150),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: bgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                AppLocalizations.of(context)!.visitShop,
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 9 : 10,
                  fontWeight: FontWeight.w600,
                  color: bgColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
              onAddToCart: () {
                setState(() {
                  _cartCount++;
                });
              },
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: isSmallScreen ? 90 : 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: product.color.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      product.icon,
                      color: product.color,
                      size: isSmallScreen ? 36 : 40,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(product),
                    child: Container(
                      width: isSmallScreen ? 26 : 30,
                      height: isSmallScreen ? 26 : 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
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
                        size: isSmallScreen ? 14 : 16,
                      ),
                    ),
                  ),
                ),
                if (product.cartQuantity > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1CE2D6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${product.cartQuantity}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1CE2D6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: isSmallScreen ? 11 : 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3D5150),
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price,
                        style: GoogleFonts.poppins(
                          fontSize: isSmallScreen ? 13 : 14,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1CE2D6),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _addToCart(product),
                        child: Container(
                          width: isSmallScreen ? 28 : 32,
                          height: isSmallScreen ? 28 : 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3D5150),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.white,
                            size: isSmallScreen ? 14 : 16,
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
    );
  }

Widget _buildBestSellerItem(Product product, bool isSmallScreen) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            product: product,
            onAddToCart: () {
              setState(() {
                _cartCount++;
              });
            },
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: isSmallScreen ? 100 : 110,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: product.color.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Icon(
                    product.icon,
                    color: product.color,
                    size: isSmallScreen ? 40 : 44,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
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
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
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
                      size: 14,
                    ),
                  ),
                ),
              ),
              if (product.cartQuantity > 0)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1CE2D6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${product.cartQuantity}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1CE2D6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  style: GoogleFonts.poppins(
                    fontSize: isSmallScreen ? 12 : 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3D5150),
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        product.price,
                        style: GoogleFonts.poppins(
                          fontSize: isSmallScreen ? 13 : 14,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1CE2D6),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _addToCart(product),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3D5150),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          size: 14,
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
  );
}
}