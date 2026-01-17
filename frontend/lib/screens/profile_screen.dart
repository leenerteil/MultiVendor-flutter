import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'cart_screen.dart';
import '../models/product.dart';
import 'user_orders_screen.dart';

// --- MAIN ENTRY POINT (For testing) ---
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileScreen(),
  ));
}

// ==========================================
// 1. USER PROFILE MODEL
// ==========================================
class UserProfile {
  String username;
  String phoneNumber;
  String email;
  String gender;
  String address;
  String location;
  String password;

  UserProfile({
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.address,
    required this.location,
    required this.password,
  });
}

// ==========================================
// 2. UPDATED PROFILE SCREEN (Matches ProductsScreen Theme)
// ==========================================
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User Profile Data
  UserProfile _userProfile = UserProfile(
    username: "Skin&Grin",
    phoneNumber: "+86171271186",
    email: "SkinGrin@gmail.com",
    gender: "Female",
    address: "Beirut",
    location: "33.82008, 35.515473",
    password: "Password123",
  );

  bool _isPasswordVisible = false;

  // Theme Colors - Matching ProductsScreen
  final Color _primaryDark = const Color(0xFF3D5150);
  final Color _accentCyan = const Color(0xFF1CE2D6);
  final Color _bgLight = Colors.white;

  // Controllers for email and password
  final TextEditingController _emailController = TextEditingController(text: "SkinGrin@gmail.com");
  late TextEditingController _passwordController;

  // Mock cart items for testing
  List<Product> _cartItems = [];

  // Profile image
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _initializeMockCart();
    // Initialize controllers with user data
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
      Product(
        id: '2',
        name: 'Smart Fitness Watch',
        price: '\$199.99',
        category: 'Electronics',
        shop: 'FitGear',
        rating: 4.5,
        color: const Color(0xFF3D5150),
        icon: Icons.watch,
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
      // Return a placeholder icon or color
      return const AssetImage('assets/images/profile_placeholder.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: Column(
        children: [
          // Dark Header Section - Matching ProductsScreen
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
                    // App Bar with Logo and Title
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),

                    // Profile Avatar
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 56,
                            backgroundColor: _accentCyan.withOpacity(0.2),
                            backgroundImage: getProfileImage(),
                            child: _profileImage == null
                                ? const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Color(0xFF1CE2D6),
                                  )
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
                                color: _accentCyan,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _userProfile.username,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Body Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // --- Email Field ---
                    _buildProfileField("Email", Icons.email_outlined, _emailController),
                    const SizedBox(height: 16),

                    // --- Password Field ---
                    _buildProfileField("Password", Icons.lock_outline, _passwordController, isPassword: true),
                    const SizedBox(height: 30),

                    // --- View Profile Button ---
                    SizedBox(
                      width: double.infinity,
                      height: 50,
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
                        icon: Icon(Icons.account_circle_outlined, size: 20, color: _accentCyan),
                        label: Text(
                          "View Profile Info",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // --- Functional Buttons ---
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

                    // My Cart Button
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
                              Future.delayed(const Duration(seconds: 1), () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
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
                    const SizedBox(height: 12),

                    // Contact Us Button
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
                          "Contact Us",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _primaryDark,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: _primaryDark),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Logout Button
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
                                  // Navigate to login screen or home
                                  Navigator.pop(context);
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
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        readOnly: true,
        style: GoogleFonts.poppins(fontSize: 14, color: _primaryDark),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
          prefixIcon: Icon(icon, color: _primaryDark),
          suffixIcon: isPassword
              ? IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          filled: false,
          isDense: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildMenuButton(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: _primaryDark, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _primaryDark,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: _primaryDark.withOpacity(0.5), size: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _showImagePicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose Profile Photo",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _primaryDark,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          setState(() {
                            _profileImage = File(image.path);
                          });
                        }
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _accentCyan.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.camera_alt, color: _accentCyan, size: 30),
                      ),
                    ),
                    Text("Camera", style: GoogleFonts.poppins(color: _primaryDark)),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            _profileImage = File(image.path);
                          });
                        }
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _accentCyan.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.photo_library, color: _accentCyan, size: 30),
                      ),
                    ),
                    Text("Gallery", style: GoogleFonts.poppins(color: _primaryDark)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. VIEW PROFILE SCREEN (with Google Maps Integration)
// ==========================================
class ViewProfileScreen extends StatefulWidget {
  final UserProfile userProfile;
  final Function(UserProfile) onProfileUpdated;
  final File? profileImage;
  final Function(File?) onImageUpdated;

  const ViewProfileScreen({
    super.key,
    required this.userProfile,
    required this.onProfileUpdated,
    required this.profileImage,
    required this.onImageUpdated,
  });

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _locationController;
  late TextEditingController _passwordController;
  late String _selectedGender;

  bool _isEditing = false;
  bool _isPasswordVisible = false;
  File? _tempProfileImage;
  GoogleMapController? _mapController;
  LatLng? _currentLocation;

  final Color _primaryDark = const Color(0xFF3D5150);
  final Color _accentCyan = const Color(0xFF1CE2D6);

  final List<String> _genders = ['Female', 'Male'];

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.userProfile.username);
    _phoneController = TextEditingController(text: widget.userProfile.phoneNumber);
    _emailController = TextEditingController(text: widget.userProfile.email);
    _addressController = TextEditingController(text: widget.userProfile.address);
    _locationController = TextEditingController(text: widget.userProfile.location);
    _passwordController = TextEditingController(text: widget.userProfile.password);
    _selectedGender = widget.userProfile.gender;
    _tempProfileImage = widget.profileImage;
    
    // Parse location
    _parseLocation(widget.userProfile.location);
  }

  void _parseLocation(String location) {
    try {
      final parts = location.split(',');
      if (parts.length == 2) {
        final lat = double.parse(parts[0].trim());
        final lng = double.parse(parts[1].trim());
        setState(() {
          _currentLocation = LatLng(lat, lng);
        });
      }
    } catch (e) {
      // Default to Beirut if parsing fails
      setState(() {
        _currentLocation = const LatLng(33.8938, 35.5018);
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Reset to original values if canceling
        _usernameController.text = widget.userProfile.username;
        _phoneController.text = widget.userProfile.phoneNumber;
        _emailController.text = widget.userProfile.email;
        _addressController.text = widget.userProfile.address;
        _locationController.text = widget.userProfile.location;
        _passwordController.text = widget.userProfile.password;
        _selectedGender = widget.userProfile.gender;
        _tempProfileImage = widget.profileImage;
        _parseLocation(widget.userProfile.location);
      }
    });
  }

  void _saveProfile() {
    final updatedProfile = UserProfile(
      username: _usernameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      gender: _selectedGender,
      address: _addressController.text.trim(),
      location: _locationController.text.trim(),
      password: _passwordController.text.trim(),
    );
    
    widget.onProfileUpdated(updatedProfile);
    if (_tempProfileImage != null) {
      widget.onImageUpdated(_tempProfileImage);
    }
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Profile updated successfully!',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: _accentCyan,
        duration: const Duration(seconds: 2),
      ),
    );
    
    // Exit edit mode
    setState(() {
      _isEditing = false;
    });
  }

  void _openMapForLocation() async {
    final String latLng = _locationController.text;
    final Uri googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latLng");
    
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open Google Maps")),
        );
      }
    }
  }

  void _showFullscreenMap() {
    if (_currentLocation == null) return;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullscreenMapScreen(
          location: _currentLocation!,
          locationName: _addressController.text,
          onLocationSelected: (LatLng newLocation) {
            setState(() {
              _currentLocation = newLocation;
              _locationController.text = "${newLocation.latitude}, ${newLocation.longitude}";
            });
          },
          isEditable: _isEditing,
        ),
      ),
    );
  }

  Widget _buildMapPreview(String location) {
    if (_currentLocation == null) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined, size: 40, color: Colors.grey.shade400),
              const SizedBox(height: 10),
              Text(
                "Map Preview",
                style: GoogleFonts.poppins(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 50, color: Colors.grey.shade400),
                const SizedBox(height: 10),
                Text(
                  "Map Preview",
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Coordinates: ${_locationController.text}",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Overlay buttons
          Positioned(
            top: 8,
            right: 8,
            child: Column(
              children: [
                // Fullscreen button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.fullscreen, color: Colors.black87),
                    onPressed: _showFullscreenMap,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ),
                const SizedBox(height: 8),
                // Open in Google Maps button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.map, color: Colors.blue),
                    onPressed: _openMapForLocation,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool hasAction = false, bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: _primaryDark,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            constraints: const BoxConstraints(minHeight: 45),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isPassword 
                        ? (_isPasswordVisible ? value : "••••••••") 
                        : value,
                    style: GoogleFonts.poppins(
                      color: _primaryDark,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (isPassword)
                  IconButton(
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                if (hasAction && _isEditing)
                  Icon(Icons.edit, color: _accentCyan, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller, {bool isPassword = false, bool isLocation = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: _primaryDark,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            obscureText: isPassword && !_isPasswordVisible,
            style: GoogleFonts.poppins(
              color: _primaryDark,
              fontSize: 14,
            ),
            readOnly: isLocation,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: _accentCyan),
              ),
              suffixIcon: isLocation
                  ? IconButton(
                      onPressed: _openMapForLocation,
                      icon: Icon(Icons.map, color: _accentCyan),
                    )
                  : isPassword
                      ? IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        )
                      : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _tempProfileImage = File(image.path);
      });
    }
  }

  // Function to get profile image provider for ViewProfileScreen
  ImageProvider getProfileImage() {
    if (_tempProfileImage != null) {
      return FileImage(_tempProfileImage!);
    } else if (widget.profileImage != null) {
      return FileImage(widget.profileImage!);
    } else {
      return const AssetImage('assets/images/profile_placeholder.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: _primaryDark),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          _isEditing ? "Edit Profile" : "Profile Info",
          style: GoogleFonts.poppins(
            color: _primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: Icon(Icons.edit, color: _primaryDark),
              onPressed: _toggleEditMode,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture Section
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 56,
                    backgroundColor: _accentCyan.withOpacity(0.2),
                    backgroundImage: getProfileImage(),
                    child: (_tempProfileImage == null && widget.profileImage == null)
                        ? const Icon(
                            Icons.person,
                            size: 40,
                            color: Color(0xFF1CE2D6),
                          )
                        : null,
                  ),
                ),
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickProfileImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _accentCyan,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _isEditing ? "Tap to change photo" : widget.userProfile.username,
              style: GoogleFonts.poppins(
                color: _isEditing ? Colors.grey.shade600 : _primaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),

            // Profile Information
            if (_isEditing)
              Column(
                children: [
                  _buildEditableField("Username *", _usernameController),
                  _buildEditableField("Phone Number", _phoneController),
                  _buildEditableField("Email *", _emailController),
                  
                  // Gender Dropdown
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: GoogleFonts.poppins(
                            color: _primaryDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedGender,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                              style: GoogleFonts.poppins(
                                color: _primaryDark,
                                fontSize: 14,
                              ),
                              items: _genders.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedGender = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  _buildEditableField("Address", _addressController),
                  _buildEditableField("Location (Google Maps)", _locationController, isLocation: true),
                  _buildEditableField("Password", _passwordController, isPassword: true),
                  
                  // Location submit info
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _accentCyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _accentCyan.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: _accentCyan, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Submit location: ${_locationController.text}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: _primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  // Map Preview
                  _buildMapPreview(_locationController.text),
                ],
              )
            else
              Column(
                children: [
                  _buildInfoRow("Username *", _usernameController.text),
                  _buildInfoRow("Phone Number", _phoneController.text),
                  _buildInfoRow("Email *", _emailController.text),
                  _buildInfoRow("Gender", _selectedGender),
                  _buildInfoRow("Address", _addressController.text),
                  _buildInfoRow("Location (Google Maps)", _locationController.text),
                  _buildInfoRow("Password", _passwordController.text, isPassword: true),
                  
                  // Location submit info
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 20),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _accentCyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _accentCyan.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: _accentCyan, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Submit location: ${_locationController.text}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: _primaryDark,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Coordinates saved from Google Maps",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Map Preview
                  _buildMapPreview(_locationController.text),
                ],
              ),

            const SizedBox(height: 40),

            // Action Buttons
            if (_isEditing)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: _toggleEditMode,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentCyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Save Changes",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. FULLSCREEN MAP SCREEN (Placeholder version without Google Maps)
// ==========================================
class FullscreenMapScreen extends StatefulWidget {
  final LatLng location;
  final String locationName;
  final Function(LatLng) onLocationSelected;
  final bool isEditable;

  const FullscreenMapScreen({
    super.key,
    required this.location,
    required this.locationName,
    required this.onLocationSelected,
    required this.isEditable,
  });

  @override
  State<FullscreenMapScreen> createState() => _FullscreenMapScreenState();
}

class _FullscreenMapScreenState extends State<FullscreenMapScreen> {
  LatLng? _selectedLocation;

  final Color _primaryDark = const Color(0xFF3D5150);
  final Color _accentCyan = const Color(0xFF1CE2D6);

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: _primaryDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Map Location",
          style: GoogleFonts.poppins(color: _primaryDark, fontWeight: FontWeight.bold),
        ),
        actions: widget.isEditable ? [
          IconButton(
            icon: Icon(Icons.save, color: _accentCyan),
            onPressed: () {
              if (_selectedLocation != null) {
                widget.onLocationSelected(_selectedLocation!);
                Navigator.pop(context);
              }
            },
          ),
        ] : null,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Google Maps Placeholder",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Location: ${widget.locationName}",
                      style: GoogleFonts.poppins(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Coordinates: ${widget.location.latitude.toStringAsFixed(5)}, ${widget.location.longitude.toStringAsFixed(5)}",
                      style: GoogleFonts.poppins(color: _accentCyan),
                    ),
                  ],
                ),
              ),
            ),
            
            if (widget.isEditable)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Edit Location",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: _primaryDark,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Lat: ${_selectedLocation?.latitude.toStringAsFixed(5)}",
                            style: GoogleFonts.poppins(color: Colors.grey.shade600),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Lng: ${_selectedLocation?.longitude.toStringAsFixed(5)}",
                            style: GoogleFonts.poppins(color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Simulate location update
                          if (_selectedLocation != null) {
                            widget.onLocationSelected(_selectedLocation!);
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentCyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Save Location",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
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

// ==========================================
// 5. CONTACT US SCREEN (Updated to match theme)
// ==========================================
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  final Color _primaryDark = const Color(0xFF3D5150);
  final Color _accentCyan = const Color(0xFF1CE2D6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: _primaryDark),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Contact Us",
          style: GoogleFonts.poppins(color: _primaryDark, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Intro Text ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "You may drop us a line, give us a call or send an email. Choose what suits you best.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 30),

            // --- Contact Info Cards ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(child: _buildInfoCard(Icons.phone_in_talk, "Phone", "+961 71 503 235")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfoCard(Icons.email_outlined, "Email", "info@diraya.dev")),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // --- Social Media ---
            Center(
              child: Column(
                children: [
                  Text("Follow Us", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: _primaryDark)),
                  const SizedBox(height: 4),
                  Text("Stay connected with us on social media", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Icons.facebook),
                      const SizedBox(width: 15),
                      _buildSocialIcon(Icons.camera_alt), 
                      const SizedBox(width: 15),
                      _buildSocialIcon(Icons.link), 
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- Form Section ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Get In Touch With Us!", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: _primaryDark)),
                  Text("Fill out the form below to send us a message.", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 20),
                  
                  _buildFormInput("Name"),
                  const SizedBox(height: 12),
                  _buildFormInput("Email"),
                  const SizedBox(height: 12),
                  _buildFormInput("Message", maxLines: 4),
                  
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Message sent successfully!',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            backgroundColor: _accentCyan,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryDark,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("SEND MESSAGE", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 30),
                  
                  // --- Map Placeholder ---
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.map, size: 50, color: Colors.grey[400]),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              color: Colors.white,
                              child: const Icon(Icons.fullscreen, size: 20),
                            ),
                          ),
                          Text(
                            "Location Map Placeholder",
                            style: GoogleFonts.poppins(color: Colors.grey[600], fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: _accentCyan, size: 28),
          const SizedBox(height: 10),
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: _primaryDark)),
          const SizedBox(height: 4),
          Text(
            content,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: _primaryDark,
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _buildFormInput(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _accentCyan),
        ),
      ),
    );
  }
}