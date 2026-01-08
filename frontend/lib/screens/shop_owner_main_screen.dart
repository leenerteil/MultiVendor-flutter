import 'package:flutter/material.dart';
import '../widgets/shop_owner_bottom_nav.dart';
import 'shop_owner_dashboard_screen.dart';
import 'shop_owner_sales_screen.dart';
import 'shop_owner_my_orders_screen.dart';
import 'shop_owner_profile_screen.dart';

class ShopOwnerMainScreen extends StatefulWidget {
  const ShopOwnerMainScreen({super.key});

  @override
  State<ShopOwnerMainScreen> createState() => _ShopOwnerMainScreenState();
}

class _ShopOwnerMainScreenState extends State<ShopOwnerMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ShopOwnerDashboardScreen(),
    const OrdersManagementScreen(),
    const ShopOwnerMyOrdersScreen(),
    const ShopOwnerProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: ShopOwnerBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
