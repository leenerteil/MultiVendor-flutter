import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shop_owner_drawer.dart';
import '../widgets/custom_screen_header.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesScreen extends StatefulWidget {
  final bool isShopOwner;
  final bool showBackButton;
  const CategoriesScreen({super.key, this.isShopOwner = false, this.showBackButton = false});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchBar = false;
  String _searchQuery = '';
  final List<Map<String, dynamic>> _allCategories = [
    {
      'name': 'electronics',
      'icon': Icons.devices,
      'color': Color(0xFF1CE2D6),
      'items': '324 items'
    },
    {
      'name': 'fashion',
      'icon': Icons.shopping_bag,
      'color': Color(0xFF3D5150),
      'items': '512 items'
    },
    {
      'name': 'homeGarden',
      'icon': Icons.home,
      'color': Color(0xFF1CE2D6),
      'items': '287 items'
    },
    {
      'name': 'beauty',
      'icon': Icons.spa,
      'color': Color(0xFF3D5150),
      'items': '198 items'
    },
    {
      'name': 'sports',
      'icon': Icons.sports_baseball,
      'color': Color(0xFF1CE2D6),
      'items': '156 items'
    },
    {
      'name': 'books',
      'icon': Icons.menu_book,
      'color': Color(0xFF3D5150),
      'items': '89 items'
    },
    {
      'name': 'toys',
      'icon': Icons.toys,
      'color': Color(0xFF1CE2D6),
      'items': '76 items'
    },
    {
      'name': 'automotive',
      'icon': Icons.directions_car,
      'color': Color(0xFF3D5150),
      'items': '54 items'
    },
    {
      'name': 'groceries',
      'icon': Icons.local_grocery_store,
      'color': Color(0xFF1CE2D6),
      'items': '432 items'
    },
    {
      'name': 'health',
      'icon': Icons.health_and_safety,
      'color': Color(0xFF3D5150),
      'items': '167 items'
    },
    {
      'name': 'jewelry',
      'icon': Icons.diamond,
      'color': Color(0xFF1CE2D6),
      'items': '92 items'
    },
    {
      'name': 'pets',
      'icon': Icons.pets,
      'color': Color(0xFF3D5150),
      'items': '65 items'
    },
  ];

  List<Map<String, dynamic>> _filteredCategories = [];

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
          final categoryKey = category['name'] as String;
          final categoryName = _getLocalizedCategoryName(categoryKey);
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

  String _getLocalizedCategoryName(String key) {
    switch (key) {
      case 'electronics':
        return AppLocalizations.of(context)!.electronics;
      case 'fashion':
        return AppLocalizations.of(context)!.fashion;
      case 'homeGarden':
        return AppLocalizations.of(context)!.homeGarden;
      case 'beauty':
        return AppLocalizations.of(context)!.beauty;
      case 'sports':
        return AppLocalizations.of(context)!.sports;
      case 'books':
        return AppLocalizations.of(context)!.books;
      case 'toys':
        return AppLocalizations.of(context)!.toys;
      case 'automotive':
        return AppLocalizations.of(context)!.automotive;
      case 'groceries':
        return AppLocalizations.of(context)!.groceries;
      case 'health':
        return AppLocalizations.of(context)!.health;
      case 'jewelry':
        return AppLocalizations.of(context)!.jewelry;
      case 'pets':
        return AppLocalizations.of(context)!.pets;
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
        currentScreen: AppLocalizations.of(context)!.categories,
      ) : null,
      body: Column(
        children: [
          // Header Section
          CustomScreenHeader(
            isShopOwner: widget.isShopOwner,
            showBackButton: widget.showBackButton,
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
                                AppLocalizations.of(context)!.categories,
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
                          AppLocalizations.of(context)!.browseByCategory,
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
                                  controller: _searchController,
                                  onChanged: _filterCategories,
                                  autofocus: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xFF3D5150),
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of(context)!.searchCategoriesHint,
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
                        const SizedBox(height: 10), 
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
                                AppLocalizations.of(context)!.categoriesCount(_filteredCategories.length),
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
                _getLocalizedCategoryName(name),
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
                ? AppLocalizations.of(context)!.noCategoriesAvailable
                : AppLocalizations.of(context)!.noCategoriesFound,
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
                  ? AppLocalizations.of(context)!.categoriesWillAppearHere
                  : AppLocalizations.of(context)!.noResultsFor(_searchQuery),
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
                AppLocalizations.of(context)!.clearSearch,
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
