import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/home_screen.dart';
import '../screens/shops_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/products_screen.dart';
import '../screens/shop_owner_main_screen.dart';

class ShopOwnerDrawer extends StatelessWidget {
  final String? currentScreen;
  const ShopOwnerDrawer({super.key, this.currentScreen});

  @override
  Widget build(BuildContext context) {
    final Color primaryDark = const Color(0xFF3D5150);
    final Color accentCyan = const Color(0xFF1CE2D6);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [accentCyan, primaryDark],
              ),
            ),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(Icons.store_rounded, color: Colors.white, size: 35),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Browse as User',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.home_outlined,
                  title: 'Home',
                  isSelected: currentScreen == 'Home',
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    if (currentScreen != 'Home') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(isShopOwner: true)));
                    }
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.storefront_outlined,
                  title: 'Shops',
                  isSelected: currentScreen == 'Shops',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentScreen != 'Shops') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopsScreen(isShopOwner: true)));
                    }
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.grid_view_outlined,
                  title: 'Categories',
                  isSelected: currentScreen == 'Categories',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentScreen != 'Categories') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesScreen(isShopOwner: true)));
                    }
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.shopping_bag_outlined,
                  title: 'Products',
                  isSelected: currentScreen == 'Products',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentScreen != 'Products') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsScreen(isShopOwner: true)));
                    }
                  },
                ),
                const Divider(height: 32, thickness: 1, indent: 20, endIndent: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Management',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                      letterSpacing: 1,
                    ),
                  ),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.dashboard_outlined,
                  title: 'Back to Dashboard',
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    // Return to root dashboard screen
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const ShopOwnerMainScreen()),
                      (route) => false,
                    );
                  },
                  isSelected: currentScreen == 'Dashboard',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'v1.0.0',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    final Color primaryDark = const Color(0xFF3D5150);
    final Color accentCyan = const Color(0xFF1CE2D6);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? accentCyan : primaryDark.withOpacity(0.7),
        size: 24,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? accentCyan : primaryDark,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      selected: isSelected,
      selectedTileColor: accentCyan.withOpacity(0.05),
    );
  }
}
