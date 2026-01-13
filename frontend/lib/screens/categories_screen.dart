import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shop_owner_drawer.dart';

class CategoriesScreen extends StatefulWidget {
  final bool isShopOwner;
  const CategoriesScreen({super.key, this.isShopOwner = false});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, dynamic>> _allCategories = [
    {
      'name': 'Electronics',
      'icon': Icons.devices,
      'color': Color(0xFF1CE2D6),
      'items': '324 items'
    },
    {
      'name': 'Fashion',
      'icon': Icons.shopping_bag,
      'color': Color(0xFF3D5150),
      'items': '512 items'
    },
    {
      'name': 'Home & Garden',
      'icon': Icons.home,
      'color': Color(0xFF1CE2D6),
      'items': '287 items'
    },
    {
      'name': 'Beauty',
      'icon': Icons.spa,
      'color': Color(0xFF3D5150),
      'items': '198 items'
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_baseball,
      'color': Color(0xFF1CE2D6),
      'items': '156 items'
    },
    {
      'name': 'Books',
      'icon': Icons.menu_book,
      'color': Color(0xFF3D5150),
      'items': '89 items'
    },
    {
      'name': 'Toys',
      'icon': Icons.toys,
      'color': Color(0xFF1CE2D6),
      'items': '76 items'
    },
    {
      'name': 'Automotive',
      'icon': Icons.directions_car,
      'color': Color(0xFF3D5150),
      'items': '54 items'
    },
    {
      'name': 'Groceries',
      'icon': Icons.local_grocery_store,
      'color': Color(0xFF1CE2D6),
      'items': '432 items'
    },
    {
      'name': 'Health',
      'icon': Icons.health_and_safety,
      'color': Color(0xFF3D5150),
      'items': '167 items'
    },
    {
      'name': 'Jewelry',
      'icon': Icons.diamond,
      'color': Color(0xFF1CE2D6),
      'items': '92 items'
    },
    {
      'name': 'Pets',
      'icon': Icons.pets,
      'color': Color(0xFF3D5150),
      'items': '65 items'
    },
  ];

  List<Map<String, dynamic>> _filteredCategories = [];
  String _searchQuery = '';
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCategories = _allCategories;
  }

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (!_showSearchBar) {
        _searchController.clear();
        _searchQuery = '';
        _filteredCategories = _allCategories;
      }
    });
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredCategories = _allCategories;
      } else {
        _filteredCategories = _allCategories.where((category) {
          final categoryName = category['name'] as String;
          return categoryName.toLowerCase().contains(_searchQuery);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _filteredCategories = _allCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: widget.isShopOwner ? const ShopOwnerDrawer(currentScreen: 'Categories') : null,
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity, // Ensures header takes full width
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Search Icon Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              const SizedBox(width: 12),
                            ],
                            const Icon(
                              Icons.category_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Categories',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: _toggleSearchBar,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _showSearchBar ? Icons.close : Icons.search,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Search Bar (shown when toggled)
                    if (_showSearchBar)
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(bottom: 12),
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
                                  controller: _searchController,
                                  onChanged: _filterCategories,
                                  autofocus: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xFF3D5150),
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search categories...',
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
                                  onTap: _clearSearch,
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

                    // Subtitle and Categories Count (NOW VERTICAL)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Browse products by category',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10), // Spacing between text and pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.grid_view,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${_filteredCategories.length} categories',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Categories Grid or Empty State
          Expanded(
            child: _filteredCategories.isEmpty
                ? _buildEmptyState()
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: _filteredCategories.length,
                      itemBuilder: (context, index) {
                        final category = _filteredCategories[index];
                        final Color bgColor = category['color'] as Color;

                        return _buildCategoryCard(
                          name: category['name'] as String,
                          icon: category['icon'] as IconData,
                          color: bgColor,
                          itemCount: category['items'] as String,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required String name,
    required IconData icon,
    required Color color,
    required String itemCount,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle category tap
        print('Selected category: $name');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),

            // Category Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3D5150),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),

            // Item Count
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                itemCount,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isEmpty
                ? Icons.category_outlined
                : Icons.search_off_rounded,
            size: 60,
            color: const Color(0xFF3D5150).withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? 'No categories available'
                : 'No categories found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3D5150),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              _searchQuery.isEmpty
                  ? 'Categories will appear here'
                  : 'No results for "$_searchQuery"',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF3D5150).withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_searchQuery.isNotEmpty)
            TextButton(
              onPressed: _clearSearch,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF1CE2D6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(
                'Clear search',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}