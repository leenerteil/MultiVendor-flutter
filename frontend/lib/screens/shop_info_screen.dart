import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopInfoScreen extends StatefulWidget {
  const ShopInfoScreen({super.key});

  @override
  State<ShopInfoScreen> createState() => _ShopInfoScreenState();
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _ownerController = TextEditingController(text: 'SkinGrin');
  final TextEditingController _phoneController = TextEditingController(text: '+96171271186');
  final TextEditingController _descriptionController = TextEditingController(
    text: 'Premium beauty and skincare products with natural ingredients.',
  );
  final TextEditingController _instagramController = TextEditingController(text: 'https://instagram.com/skinGrin');
  final TextEditingController _facebookController = TextEditingController(text: 'https://facebook.com/skinGrin');
  final TextEditingController _tiktokController = TextEditingController(text: 'https://tiktok.com/@skinGrin');
  final TextEditingController _locationController = TextEditingController(text: 'Beirut, Lebanon');
  final TextEditingController _createdAtController = TextEditingController(text: '2024-01-15');
  final TextEditingController _productLimitController = TextEditingController(text: '100');
  final TextEditingController _statusController = TextEditingController(text: 'Active');

  List<String> _selectedCategories = ['Cosmetics', 'SkinCare'];
  final List<String> _availableCategories = [
    'Cosmetics',
    'SkinCare',
    'Fashion',
    'Electronics',
    'Home & Garden',
    'Food & Beverage',
    'Sports',
    'Books',
    'Toys',
    'Health',
  ];

  String _shopStatus = 'Active';
  final List<String> _statusOptions = ['Active', 'Inactive', 'Pending', 'Suspended'];

  @override
  void dispose() {
    _ownerController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _tiktokController.dispose();
    _locationController.dispose();
    _createdAtController.dispose();
    _productLimitController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1CE2D6),
                    Color(0xFF3D5150),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  children: [
                    // Top Bar
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Shop Information',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Form Container
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Basic Information Section
                            _buildSectionHeader('Basic Information'),
                            const SizedBox(height: 16),

                            // Owner and Phone Row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Owner Name',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF3D5150),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _buildTextField(
                                        _ownerController,
                                        'Enter owner name',
                                        icon: Icons.person_outline,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone Number',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF3D5150),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _buildTextField(
                                        _phoneController,
                                        'Enter phone number',
                                        icon: Icons.phone_outlined,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Description
                            Text(
                              'Shop Description',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3D5150),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '(Optional)',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTextAreaField(
                              _descriptionController,
                              'Describe your shop...',
                              icon: Icons.description_outlined,
                              minLines: 4,
                            ),
                            const SizedBox(height: 20),

                            // Categories
                            Text(
                              'Categories',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3D5150),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '(Select one or more categories for your shop)',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildCategorySelector(),
                            const SizedBox(height: 30),

                            // Social Media Section
                            _buildSectionHeader('Social Media'),
                            const SizedBox(height: 16),

                            // Instagram
                            _buildSocialMediaField(
                              _instagramController,
                              'Instagram URL',
                              'https://instagram.com/...',
                              Icons.photo_camera_outlined, 
                              const Color(0xFFE4405F),
                            ),
                            const SizedBox(height: 16),

                            // Facebook
                            _buildSocialMediaField(
                              _facebookController,
                              'Facebook URL',
                              'https://facebook.com/...',
                              Icons.thumb_up_outlined, 
                              const Color(0xFF1877F2),
                            ),
                            const SizedBox(height: 16),

                            // TikTok
                            _buildSocialMediaField(
                              _tiktokController,
                              'TikTok URL',
                              'https://tiktok.com/...',
                              Icons.music_note,
                              const Color(0xFF000000),
                            ),
                            const SizedBox(height: 30),

                            // Location
                            _buildSectionHeader('Location'),
                            const SizedBox(height: 16),

                            Text(
                              'Shop Location',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3D5150),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '(Optional)',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              _locationController,
                              'Enter shop address or location',
                              icon: Icons.location_on_outlined,
                            ),
                            const SizedBox(height: 30),

                            // Shop Images Section
                            _buildSectionHeader('Shop Images'),
                            const SizedBox(height: 16),

                            // Logo and Cover Row
                            Row(
                              children: [
                                Expanded(
                                  child: _buildImageUploader(
                                    title: 'Shop Logo',
                                    subtitle: 'Recommended: 500x500px',
                                    icon: Icons.photo_camera_outlined,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildImageUploader(
                                    title: 'Shop Cover',
                                    subtitle: 'Recommended: 1200x300px',
                                    icon: Icons.photo_library_outlined,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Gallery Images
                            Row(
                              children: [
                                Expanded(
                                  child: _buildImageUploader(
                                    title: 'Gallery Image 1',
                                    subtitle: 'Optional',
                                    icon: Icons.add_photo_alternate_outlined,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildImageUploader(
                                    title: 'Gallery Image 2',
                                    subtitle: 'Optional',
                                    icon: Icons.add_photo_alternate_outlined,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            // Shop Settings Section
                            _buildSectionHeader('Shop Settings'),
                            const SizedBox(height: 16),

                            // Status Dropdown
                            Text(
                              'Shop Status',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3D5150),
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildStatusDropdown(),
                            const SizedBox(height: 16),

                            // Product Limit
                            Text(
                              'Product Limit',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3D5150),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Maximum number of products allowed',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              _productLimitController,
                              'Enter product limit',
                              icon: Icons.inventory_2_outlined,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),

                            // Created At
                            Text(
                              'Shop Created At',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3D5150),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'This cannot be changed',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildReadOnlyField(
                              _createdAtController.text,
                              icon: Icons.calendar_today_outlined,
                            ),
                            const SizedBox(height: 30),

                            // Save Button
                            Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1CE2D6),
                                    Color(0xFF3D5150),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF1CE2D6).withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      _saveShopInfo();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Center(
                                    child: Text(
                                      'Save Shop Information',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1CE2D6),
                Color(0xFF3D5150),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF3D5150),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Icon(
                icon,
                color: const Color(0xFF1CE2D6),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF3D5150),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextAreaField(
    TextEditingController controller,
    String hintText, {
    required IconData icon,
    int minLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF1CE2D6),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    minLines: minLines,
                    maxLines: minLines * 2,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF3D5150),
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaField(
    TextEditingController controller,
    String label,
    String hintText,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3D5150),
                ),
              ),
            ),
            Text(
              '(Optional)',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        _buildTextField(controller, hintText),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableCategories.map((category) {
            final isSelected = _selectedCategories.contains(category);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedCategories.remove(category);
                  } else {
                    _selectedCategories.add(category);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1CE2D6)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1CE2D6)
                        : Colors.grey.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  category,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF3D5150),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildImageUploader({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Image picker action
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFF1CE2D6),
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3D5150),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: _shopStatus,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF1CE2D6)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: InputBorder.none,
            hintText: 'Select status',
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF3D5150),
          ),
          items: _statusOptions.map((String value) {
            Color statusColor;
            switch (value) {
              case 'Active':
                statusColor = Colors.green;
                break;
              case 'Inactive':
                statusColor = Colors.grey;
                break;
              case 'Pending':
                statusColor = Colors.orange;
                break;
              case 'Suspended':
                statusColor = Colors.red;
                break;
              default:
                statusColor = const Color(0xFF3D5150);
            }
            
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(value),
                ],
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _shopStatus = newValue!;
              _statusController.text = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String text, {IconData? icon}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: Colors.grey[500],
              size: 20,
            ),
            const SizedBox(width: 12),
          ],
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _saveShopInfo() {
    // Save logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Shop information saved successfully!',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    
    // Navigate back after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }
}