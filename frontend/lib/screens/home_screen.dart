import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';
import 'login_screen.dart';
import '../widgets/shop_owner_drawer.dart';
import 'dart:async';

class Product {
  final String id;
  final String name;
  final String price;
  final String category;
  final Color color;
  final IconData icon;
  bool isFavorite;
  int cartQuantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.color,
    required this.icon,
    this.isFavorite = false,
    this.cartQuantity = 0,
  });
}

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
      color: const Color(0xFF1CE2D6),
      icon: Icons.headphones,
    ),
    Product(
      id: '2',
      name: 'Smart Watch',
      price: '\$129.99',
      category: 'Electronics',
      color: const Color(0xFF3D5150),
      icon: Icons.watch,
    ),
    Product(
      id: '3',
      name: 'Designer Perfume',
      price: '\$49.99',
      category: 'Cosmetics',
      color: const Color(0xFF1CE2D6),
      icon: Icons.spa,
    ),
    Product(
      id: '4',
      name: 'Fashion Sunglasses',
      price: '\$34.99',
      category: 'Accessories',
      color: const Color(0xFF3D5150),
      icon: Icons.dark_mode,
    ),
    Product(
      id: '5',
      name: 'Gaming Console',
      price: '\$299.99',
      category: 'Electronics',
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: widget.isShopOwner ? const ShopOwnerDrawer(currentScreen: 'Home') : null,
      body: _buildHomeContent(),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: Colors.white, size: 24),
                                    onPressed: () {},
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
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
                                          minWidth: 20,
                                          minHeight: 20,
                                        ),
                                        child: Text(
                                          '$_favoriteCount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
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
                                        size: 24),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 40,
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
                                          minWidth: 20,
                                          minHeight: 20,
                                        ),
                                        child: Text(
                                          '$_cartCount',
                                          style: const TextStyle(
                                            color: Colors.white,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Search Bar
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
                          )
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
                                  contentPadding: const EdgeInsets.only(bottom: 10),
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

          // Dynamic Hero Image Carousel
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 210,
                  child: Builder(
                    builder: (context) {
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
                        child: Container(
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
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.sponsored,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  item['subtitle'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['title'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.shopNow,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: item['color'] as Color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                    }
                  )
                ),
                const SizedBox(height: 12),
                Row( 
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
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 10 Static Ads Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Builder(
              builder: (context) {
                final staticAds = _getStaticAds(context);
                return Column(
                  children: [
                    // Row 1: Ads 1-2
                    Row(
                      children: [
                        Expanded(
                          child: _buildStaticAd(staticAds[0]),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStaticAd(staticAds[1]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Row 2: Ads 3-4
                    Row(
                      children: [
                        Expanded(
                          child: _buildStaticAd(staticAds[2]),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStaticAd(staticAds[3]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Row 3: Ads 5-6
                    Row(
                      children: [
                        Expanded(
                          child: _buildStaticAd(staticAds[4]),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStaticAd(staticAds[5]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Row 4: Ads 7-8
                    Row(
                      children: [
                        Expanded(
                          child: _buildStaticAd(staticAds[6]),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStaticAd(staticAds[7]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Row 5: Ads 9-10
                    Row(
                      children: [
                        Expanded(
                          child: _buildStaticAd(staticAds[8]),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStaticAd(staticAds[9]),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // Products Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                   AppLocalizations.of(context)!.popularProducts,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF3D5150),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                  ),
                  child: Row(
                    children: [
                      Text(
                         AppLocalizations.of(context)!.showAll,
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
            ),
          ),

          const SizedBox(height: 12),

          // Products List
          SizedBox(
            height: 220,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return SizedBox(
                  width: 150,
                  child: _buildProductItem(product),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                   AppLocalizations.of(context)!.categories,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF3D5150),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                  ),
                  child: Row(
                    children: [
                      Text(
                         AppLocalizations.of(context)!.viewAll,
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
            ),
          ),

          const SizedBox(height: 15),

          // Categories Grid
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              itemCount: 5,
              itemBuilder: (context, index) {
                final l10n = AppLocalizations.of(context)!;
                List<Map<String, dynamic>> categories = [
                  {
                    'title': l10n.electronics,
                    'icon': Icons.electrical_services
                  },
                  {'title': l10n.accessories, 'icon': Icons.watch},
                  {'title': l10n.cosmetics, 'icon': Icons.spa},
                  {'title': l10n.groceries, 'icon': Icons.shopping_cart},
                  {'title': l10n.fashion, 'icon': Icons.shopping_bag},
                ];
                return SizedBox(
                  width: 80,
                  child: _buildCategoryItem(
                      categories[index]['title'] as String,
                      categories[index]['icon'] as IconData),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // Featured Shops Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.featuredShops,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF3D5150),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.viewAll,
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
                ),
                const SizedBox(height: 15),
                // Featured Shops Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildShopItem(
                        'Skin & Grin',
                        Icons.face_retouching_natural,
                        const Color(0xFF1CE2D6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildShopItem(
                        'Hanan Boutique',
                        Icons.shopping_bag,
                        const Color(0xFF3D5150),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Best Sellers Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.bestSellers,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF3D5150),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.seeAll,
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
                ),
                const SizedBox(height: 15),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return _buildBestSellerItem(product);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStaticAd(Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,
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
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  ad['icon'] as IconData,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ad['subtitle'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
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
                        fontSize: 14,
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

  Widget _buildCategoryItem(String title, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
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
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
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

  Widget _buildShopItem(String title, IconData icon, Color bgColor) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 145,
        padding: const EdgeInsets.all(12),
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
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
                  fontSize: 10,
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

  Widget _buildProductItem(Product product) {
    return GestureDetector(
      onTap: () {},
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
            // Product Image with Favorite Button
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 100,
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
                      size: 40,
                    ),
                  ),
                ),
                // Favorite Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(product),
                    child: Container(
                      width: 30,
                      height: 30,
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
                        size: 16,
                      ),
                    ),
                  ),
                ),
                // Cart Quantity Badge
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
            // Product Info
            Padding(
              padding: const EdgeInsets.all(10),
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
                      fontSize: 12,
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
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1CE2D6),
                        ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildBestSellerItem(Product product) {
    return GestureDetector(
      onTap: () {},
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
            // Product Image with Favorite Button
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 90,
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
                      size: 36,
                    ),
                  ),
                ),
                // Favorite Button
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
                // Cart Quantity Badge
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
            // Product Info
            Padding(
              padding: const EdgeInsets.all(10),
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
                      fontSize: 12,
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
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1CE2D6),
                        ),
                      ),
                      // Add to Cart Button
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