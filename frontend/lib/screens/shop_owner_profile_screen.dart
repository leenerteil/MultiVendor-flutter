import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shop_owner_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shopzy/screens/profile_screen.dart'; 
import 'package:shopzy/screens/main_screen.dart'; 
import 'cart_screen.dart'; 
import 'package:shopzy/models/product.dart';
import 'user_orders_screen.dart'; 

class ShopOwnerProfileScreen extends StatefulWidget {
  const ShopOwnerProfileScreen({super.key});

  @override
  State<ShopOwnerProfileScreen> createState() => _ShopOwnerProfileScreenState();
}

class _ShopOwnerProfileScreenState extends State<ShopOwnerProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // User Profile Data - Initialized with Shop Owner details
  UserProfile _userProfile = UserProfile(
    username: "Shop Owner Username",
    phoneNumber: "+86171271186",
    email: "SkinGrin@gmail.com",
    gender: "Female",
    address: "Beirut",
    location: "33.82008, 35.515473",
    password: "Password123",
  );

  bool _isPasswordVisible = false;

  // Theme Colors - Shop Owner Specific
  final Color _primaryDark = const Color(0xFF3D5150);
  final Color _accentCyan = const Color(0xFF1CE2D6);
  final Color _bgLight = const Color(0xFFF8F9FA);

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController;

  // Mock cart items
  List<Product> _cartItems = [];

  // Profile image
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _initializeMockCart();
    _emailController.text = _userProfile.email;
    _passwordController = TextEditingController(text: _userProfile.password);
  }

  void _initializeMockCart() {
    _cartItems = [
      Product(
        id: '1',
        name: 'Wireless Bluetooth Headphones',
        price: '\$89.99',
        category: 'Electronics',
        shop: 'AudioTech',
        rating: 4.2,
        color: const Color(0xFF1CE2D6),
        icon: Icons.headphones,
        isFavorite: false,
        cartQuantity: 1,
      ),
    ];
  }

  // Update profile when returning from ViewProfileScreen
  void _updateProfile(UserProfile updatedProfile) {
    setState(() {
      _userProfile = updatedProfile;
      _emailController.text = updatedProfile.email;
      _passwordController.text = updatedProfile.password;
    });
  }

  // Function to update profile image
  void _updateProfileImage(File? image) {
    setState(() {
      _profileImage = image;
    });
  }

  // Function to get profile image provider
  ImageProvider getProfileImage() {
    if (_profileImage != null) {
      return FileImage(_profileImage!);
    } else {
      return const AssetImage('assets/images/profile_placeholder.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _bgLight,
      drawer: const ShopOwnerDrawer(currentScreen: 'Dashboard'),
      body: Column(
        children: [
          // Styled Header with Shop Owner Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_accentCyan, _primaryDark],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  children: [
                    // App Bar Area
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
                          ),
                        ),
                        Text(
                          'Personal Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 40), 
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Profile Avatar
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 52,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                            child: _profileImage == null
                                ? const Icon(Icons.person, size: 45, color: Colors.white)
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _showImagePicker(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: _accentCyan, width: 2),
                              ),
                              child: Icon(Icons.camera_alt, color: _primaryDark, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _userProfile.username,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Shop Owner',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Body Content - Mirrors User Profile structure
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Email Field
                  _buildProfileField("Email", Icons.email_outlined, _emailController),
                  const SizedBox(height: 16),

                  // Password Field
                  _buildProfileField("Password", Icons.lock_outline, _passwordController, isPassword: true),
                  const SizedBox(height: 24),

                  // View Profile Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewProfileScreen(
                              userProfile: _userProfile,
                              onProfileUpdated: _updateProfile,
                              profileImage: _profileImage,
                              onImageUpdated: _updateProfileImage,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.account_circle_outlined, size: 20, color: Colors.white),
                      label: Text(
                        "View Profile Info",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Functional Buttons - Mirroring User Profile
                  _buildMenuButton("My Wishlist", Icons.favorite_border, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Wishlist is empty',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        backgroundColor: _primaryDark,
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                  _buildMenuButton("My Cart", Icons.shopping_bag_outlined, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          cartItems: List<Product>.from(_cartItems),
                          onItemRemoved: () {
                            setState(() {
                              if (_cartItems.isNotEmpty) {
                                _cartItems.removeLast();
                              }
                            });
                          },
                          onCheckout: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.check_circle, color: Colors.white),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Order placed successfully!',
                                      style: GoogleFonts.poppins(color: Colors.white),
                                    ),
                                  ],
                                ),
                                backgroundColor: _accentCyan,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            setState(() {
                              _cartItems.clear();
                            });
                          },
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 12),

                  // My Orders Button
                  _buildMenuButton("My Orders", Icons.receipt_long_outlined, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserOrdersScreen(),
                      ),
                    );
                  }),
                  const SizedBox(height: 30),

                  // Support & Logout (Standard style)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactUsScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.contact_support_outlined, color: _primaryDark),
                      label: Text(
                        "Contact Support",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _primaryDark,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: _primaryDark.withOpacity(0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "Logout",
                            style: GoogleFonts.poppins(
                              color: _primaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            "Are you sure you want to logout?",
                            style: GoogleFonts.poppins(color: Colors.grey.shade600),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(color: Colors.grey.shade600),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Logged out successfully!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                // Navigate to root or login
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                              ),
                              child: Text(
                                "Logout",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.logout, color: Colors.redAccent),
                    label: Text(
                      "Log Out",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
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

  Widget _buildProfileField(String label, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        readOnly: true,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: _primaryDark),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 13),
          prefixIcon: Icon(icon, color: _accentCyan, size: 20),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.grey,
                    size: 18,
                  ),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildMenuButton(String title, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: _primaryDark, size: 20),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _primaryDark,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: _primaryDark.withOpacity(0.3), size: 14),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showImagePicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Update Profile Photo",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _primaryDark,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPickerOption(
                  icon: Icons.camera_alt_outlined,
                  label: "Camera",
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    final image = await picker.pickImage(source: ImageSource.camera);
                    if (image != null) _updateProfileImage(File(image.path));
                  },
                ),
                _buildPickerOption(
                  icon: Icons.image_outlined,
                  label: "Gallery",
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    final image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) _updateProfileImage(File(image.path));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _accentCyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: _accentCyan, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}