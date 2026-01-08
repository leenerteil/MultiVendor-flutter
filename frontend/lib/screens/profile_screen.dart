import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart_screen.dart';
import '../models/product.dart'; // Make sure this import is correct

// --- MAIN ENTRY POINT (For testing) ---
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileScreen(),
  ));
}

// ==========================================
// 1. REFINED PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Data Controllers
  final TextEditingController _nameController = TextEditingController(text: "Username");
  final TextEditingController _emailController = TextEditingController(text: "info@diraya.dev");
  final TextEditingController _passwordController = TextEditingController(text: "12345678");

  // Theme Colors
  final Color _primaryDark = const Color(0xFF3D5150);
  final Color _accentCyan = const Color(0xFF22C7B8);
  final Color _bgLight = const Color(0xFFF8FAFC);

  // Mock cart items for testing - ONLY use fields that exist in your Product model
  List<Product> _cartItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some mock data for testing
    _initializeMockCart();
  }

  void _initializeMockCart() {
    // Create mock products using the exact fields from your Product model
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
      Product(
        id: '3',
        name: 'Modern Desk Lamp',
        price: '\$45.50',
        category: 'Home & Garden',
        shop: 'HomeEssentials',
        rating: 4.0,
        color: const Color(0xFF22C7B8),
        icon: Icons.lightbulb,
        isFavorite: false,
        cartQuantity: 2,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Header & Avatar Stack ---
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _primaryDark,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profile",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _bgLight, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: const NetworkImage('https://i.pravatar.cc/300'),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 60),

            // --- Body Content ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    "Welcome back,",
                    style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    _nameController.text,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: _primaryDark,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Improved Inputs
                  _buildProfileField("Email", Icons.email_outlined, _emailController),
                  const SizedBox(height: 16),
                  _buildProfileField("Password", Icons.lock_outline, _passwordController, isPassword: true),

                  const SizedBox(height: 30),

                  // Functional Buttons
                  _buildMenuButton("My Wishlist", Icons.favorite_border, () {}),
                  const SizedBox(height: 12),
                  
                  // UPDATED: My Cart button now navigates to CartScreen with mock data
                  _buildMenuButton("My Cart", Icons.shopping_bag_outlined, () {
                    // Navigate to CartScreen with the required parameters
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          // Pass the cart items (mock data for now)
                          cartItems: List<Product>.from(_cartItems),
                          // Callback for when an item is removed
                          onItemRemoved: () {
                            // This will be called when CartScreen removes an item
                            // For now, just update the UI
                            setState(() {
                              // This is where you would update your real cart state
                              // For mock data, we'll just remove the last item
                              if (_cartItems.isNotEmpty) {
                                _cartItems.removeLast();
                              }
                            });
                          },
                          // Callback for checkout
                          onCheckout: () {
                            // Show checkout success message
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
                                backgroundColor: _primaryDark,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            
                            // Clear cart after checkout
                            setState(() {
                              _cartItems.clear();
                            });
                            
                            // Navigate back after a delay
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

                  // Contact Us -> Navigates to new screen
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ContactUsScreen()),
                        );
                      },
                      icon: Icon(Icons.headset_mic_outlined, color: _primaryDark),
                      label: Text(
                        "Contact Us",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: _primaryDark),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: _primaryDark),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Logout Button
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged Out")));
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: GoogleFonts.poppins(fontSize: 14, color: _primaryDark),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
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

  Widget _buildMenuButton(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: _primaryDark,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: _primaryDark.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }
}

// 2. NEW CONTACT US SCREEN (keep as is)
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  final Color _primaryDark = const Color(0xFF3D5150);
  final Color _accentCyan = const Color(0xFF22C7B8);

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
                      onPressed: () {},
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
      ),
    );
  }
}