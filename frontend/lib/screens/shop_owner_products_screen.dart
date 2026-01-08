import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';
  String _selectedCategory = 'All Categories';

  List<Map<String, dynamic>> _products = [
    {
      'name': 'Facial Cleansing',
      'description': 'Gentle facial cleanser for all skin types',
      'categories': ['Cosmetics'],
      'price': '13',
      'salePrice': '10',
      'stock': 0,
      'status': 'Active',
      'quantity': 5,
      'brand': 'Febra',
      'images': [],
      'weights': ['500g'],
    },
    {
      'name': 'Passion Orchid Perfume',
      'description': 'Premium floral fragrance',
      'categories': ['Cosmetics', 'Fashion'],
      'price': '29',
      'salePrice': '25',
      'stock': 9,
      'status': 'Active',
      'quantity': 10,
      'brand': 'Febra',
      'images': [],
      'weights': ['1000g', '500g'],
    },
    {
      'name': 'Shampoo',
      'description': 'Natural hair care shampoo',
      'categories': ['Cosmetics'],
      'price': '10',
      'salePrice': '8',
      'stock': 5,
      'status': 'Active',
      'quantity': 15,
      'brand': 'Febra',
      'images': [],
      'weights': ['500g', '200g'],
    },
    {
      'name': 'Splash',
      'description': 'Refreshing body splash',
      'categories': ['Cosmetics'],
      'price': '8',
      'salePrice': '6',
      'stock': 3,
      'status': 'Active',
      'quantity': 8,
      'brand': 'Febra',
      'images': [],
      'weights': ['200g'],
    },
    {
      'name': 'Moisturizing Cream',
      'description': '24-hour hydration cream',
      'categories': ['SkinCare', 'Cosmetics'],
      'price': '25',
      'salePrice': '20',
      'stock': 12,
      'status': 'Active',
      'quantity': 20,
      'brand': 'Febra',
      'images': [],
      'weights': ['1000g', '500g', '200g'],
    },
    {
      'name': 'Sunscreen SPF 50',
      'description': 'Broad spectrum protection',
      'categories': ['SkinCare'],
      'price': '18',
      'salePrice': '15',
      'stock': 7,
      'status': 'Inactive',
      'quantity': 12,
      'brand': 'Febra',
      'images': [],
      'weights': ['500g'],
    },
  ];

  // Available brands for dropdown
  final List<String> _availableBrands = ['Febra', 'L\'Oréal', 'Nivea', 'Neutrogena', 'Dove', 'Custom Brand'];
  final List<String> _defaultWeights = ['1000g', '500g', '200g'];
  final List<String> _availableCategories = ['Cosmetics', 'SkinCare', 'Fashion', 'Electronics', 'Books'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((product) {
      final matchesSearch = _searchController.text.isEmpty ||
          product['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      
      final matchesStatus = _selectedStatus == 'All' ||
          product['status'] == _selectedStatus ||
          (_selectedStatus == 'Out of Stock' && product['stock'] == 0);
      
      final matchesCategory = _selectedCategory == 'All Categories' ||
          (product['categories'] as List<String>).contains(_selectedCategory);
      
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  void _toggleProductStatus(int index) {
    setState(() {
      final product = _filteredProducts[index];
      final originalIndex = _products.indexWhere((p) => p['name'] == product['name']);
      
      if (originalIndex != -1) {
        _products[originalIndex]['status'] = 
            _products[originalIndex]['status'] == 'Active' ? 'Inactive' : 'Active';
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Product status updated!',
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
  }

  void _deleteProduct(int index) {
    final product = _filteredProducts[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.warning,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Delete Product',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${product['name']}"? This action cannot be undone.',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _products.removeWhere((p) => p['name'] == product['name']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product['name']} deleted successfully'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildProductFormDialog(
        title: 'Add Product',
        isEditing: false,
        onProductSaved: () {
          // This callback will trigger a rebuild when a product is saved
          setState(() {});
        },
      ),
    );
  }

  void _showEditProductDialog(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => _buildProductFormDialog(
        title: 'Edit Product',
        isEditing: true,
        product: product,
        onProductSaved: () {
          // This callback will trigger a rebuild when a product is saved
          setState(() {});
        },
      ),
    );
  }

  Widget _buildProductFormDialog({
    required String title,
    required bool isEditing,
    Map<String, dynamic>? product,
    required VoidCallback onProductSaved,
  }) {
    final _productNameController = TextEditingController(text: product?['name'] ?? '');
    final _descriptionController = TextEditingController(text: product?['description'] ?? '');
    final _priceController = TextEditingController(text: product?['price'] ?? '');
    final _salePriceController = TextEditingController(text: product?['salePrice'] ?? '');
    final _quantityController = TextEditingController(text: product?['quantity'].toString() ?? '');
    final _brandController = TextEditingController(text: product?['brand'] ?? '');
    final _customBrandController = TextEditingController(text: product?['brand'] != null && !_availableBrands.contains(product!['brand']) ? product['brand'] : '');
    final _newWeightController = TextEditingController();
    
    // Handle brand selection - if product has a custom brand not in list, show as "Custom Brand"
    String _selectedBrand = product?['brand'] ?? 'Febra';
    bool _showCustomBrandField = product?['brand'] != null && !_availableBrands.contains(product!['brand']);
    if (_showCustomBrandField) {
      _selectedBrand = 'Custom Brand';
    }
    
    List<String> _selectedCategories = product?['categories'] != null 
        ? List<String>.from(product!['categories']) 
        : ['Cosmetics'];
    List<String> _selectedWeights = product?['weights'] != null 
        ? List<String>.from(product!['weights']) 
        : ['500g'];
    List<File> _productImages = product?['images'] != null ? List<File>.from(product!['images']) : [];

    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1CE2D6),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name (Required)
                          _buildFormField(
                            label: 'Product Name *',
                            controller: _productNameController,
                            icon: Icons.edit,
                            isRequired: true,
                          ),
                          const SizedBox(height: 16),

                          // Description (Optional)
                          _buildFormField(
                            label: 'Description',
                            controller: _descriptionController,
                            icon: Icons.description,
                            maxLines: 3,
                            isOptional: true,
                          ),
                          const SizedBox(height: 16),

                          // Price (Required) and Sale Price (Optional) Row
                          Row(
                            children: [
                              Expanded(
                                child: _buildFormField(
                                  label: 'Price *',
                                  controller: _priceController,
                                  icon: Icons.attach_money,
                                  isRequired: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildFormField(
                                  label: 'Sale Price',
                                  controller: _salePriceController,
                                  icon: Icons.attach_money,
                                  isOptional: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Quantity (Required)
                          _buildFormField(
                            label: 'Quantity *',
                            controller: _quantityController,
                            icon: Icons.inventory_2,
                            isRequired: true,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),

                          // Categories (Multiple Selection)
                          Text(
                            'Categories *',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF3D5150),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF1CE2D6).withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _availableCategories.map((category) {
                                  final isSelected = _selectedCategories.contains(category);
                                  return ChoiceChip(
                                    label: Text(category, 
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: isSelected ? Colors.white : const Color(0xFF3D5150),
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setStateDialog(() {
                                        if (selected) {
                                          _selectedCategories.add(category);
                                        } else {
                                          _selectedCategories.remove(category);
                                        }
                                      });
                                    },
                                    selectedColor: const Color(0xFF1CE2D6),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        color: isSelected 
                                            ? const Color(0xFF1CE2D6) 
                                            : Colors.grey.withOpacity(0.3),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          if (_selectedCategories.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'At least one category is required',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),

                          // Brand (Optional with dropdown + custom)
                          Text(
                            'Brand',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF3D5150),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF1CE2D6).withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedBrand,
                                      isExpanded: true,
                                      items: _availableBrands.map((String brand) {
                                        return DropdownMenuItem<String>(
                                          value: brand,
                                          child: Text(
                                            brand,
                                            style: GoogleFonts.poppins(fontSize: 14),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setStateDialog(() {
                                          _selectedBrand = value!;
                                          _showCustomBrandField = value == 'Custom Brand';
                                          if (!_showCustomBrandField) {
                                            _brandController.text = value;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                if (_showCustomBrandField)
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: TextField(
                                      controller: _customBrandController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter custom brand name',
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: const Color(0xFF1CE2D6).withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        _brandController.text = value;
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Product Images (1-3 images, at least 1 required)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Product Images *',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                              Text(
                                '${_productImages.length}/3',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: _productImages.length >= 3 
                                      ? Colors.red 
                                      : const Color(0xFF1CE2D6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add 1-3 images',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              // Existing Images
                              ..._productImages.asMap().entries.map((entry) {
                                final index = entry.key;
                                final image = entry.value;
                                return Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Center(
                                              child: Icon(
                                                Icons.image,
                                                color: const Color(0xFF1CE2D6),
                                                size: 40,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: GestureDetector(
                                          onTap: () {
                                            setStateDialog(() {
                                              _productImages.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              
                              // Add Image Button (if less than 3 images)
                              if (_productImages.length < 3)
                                GestureDetector(
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 85,
                                    );
                                    if (image != null) {
                                      setStateDialog(() {
                                        _productImages.add(File(image.path));
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8F9FA),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xFF1CE2D6).withOpacity(0.5),
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add_photo_alternate_outlined,
                                          color: Color(0xFF1CE2D6),
                                          size: 32,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Add',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: const Color(0xFF1CE2D6),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          // Image validation message
                          if (_productImages.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'At least one image is required',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),

                          // Product Attributes - Weight (Optional)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Weight (Optional)',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                              // Add new weight button
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        'Add New Weight',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      content: TextField(
                                        controller: _newWeightController,
                                        decoration: InputDecoration(
                                          hintText: 'e.g., 250g',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_newWeightController.text.isNotEmpty) {
                                              setStateDialog(() {
                                                _selectedWeights.add(_newWeightController.text);
                                                _newWeightController.clear();
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF1CE2D6),
                                          ),
                                          child: const Text('Add'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1CE2D6),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Add New',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              // Default weights
                              ..._defaultWeights.map((weight) {
                                final isSelected = _selectedWeights.contains(weight);
                                return FilterChip(
                                  label: Text(weight, style: GoogleFonts.poppins(fontSize: 13)),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setStateDialog(() {
                                      if (selected) {
                                        _selectedWeights.add(weight);
                                      } else {
                                        _selectedWeights.remove(weight);
                                      }
                                    });
                                  },
                                  selectedColor: const Color(0xFF1CE2D6).withOpacity(0.2),
                                  backgroundColor: Colors.white,
                                  labelStyle: GoogleFonts.poppins(
                                    color: isSelected ? const Color(0xFF1CE2D6) : const Color(0xFF3D5150),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: isSelected 
                                          ? const Color(0xFF1CE2D6) 
                                          : Colors.grey.withOpacity(0.3),
                                    ),
                                  ),
                                  checkmarkColor: const Color(0xFF1CE2D6),
                                );
                              }).toList(),
                              // Custom added weights
                              ..._selectedWeights.where((weight) => !_defaultWeights.contains(weight)).map((weight) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3D5150).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: const Color(0xFF3D5150).withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        weight,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: const Color(0xFF3D5150),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () {
                                          setStateDialog(() {
                                            _selectedWeights.remove(weight);
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),

                // Footer Buttons
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFF1CE2D6),
                              width: 1.5,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1CE2D6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate required fields
                            if (_productNameController.text.isEmpty ||
                                _priceController.text.isEmpty ||
                                _quantityController.text.isEmpty ||
                                _selectedCategories.isEmpty ||
                                _productImages.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please fill all required fields (*)',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            // Get the final brand value
                            String finalBrand;
                            if (_showCustomBrandField) {
                              finalBrand = _customBrandController.text.isNotEmpty 
                                  ? _customBrandController.text 
                                  : 'Custom Brand';
                            } else {
                              finalBrand = _selectedBrand;
                            }

                            final newProduct = {
                              'name': _productNameController.text,
                              'description': _descriptionController.text,
                              'categories': List<String>.from(_selectedCategories),
                              'price': _priceController.text,
                              'salePrice': _salePriceController.text.isNotEmpty ? _salePriceController.text : null,
                              'stock': int.tryParse(_quantityController.text) ?? 0,
                              'status': isEditing ? (product?['status'] ?? 'Active') : 'Active',
                              'quantity': int.tryParse(_quantityController.text) ?? 0,
                              'brand': finalBrand,
                              'images': _productImages,
                              'weights': _selectedWeights,
                            };

                            // Update the product list
                            if (isEditing && product != null) {
                              final index = _products.indexWhere((p) => p['name'] == product['name']);
                              if (index != -1) {
                                _products[index] = newProduct;
                              }
                            } else {
                              _products.add(newProduct);
                            }

                            Navigator.pop(context);
                            
                            // Call the callback to trigger a rebuild in the main widget
                            onProductSaved();
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isEditing ? 'Product updated successfully!' : 'Product added successfully!',
                                ),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1CE2D6),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            isEditing ? 'Update Product' : 'Add Product',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
      },
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    bool isRequired = false,
    bool isOptional = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3D5150),
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              Text(
                '*',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF1CE2D6).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              prefixIcon: Icon(icon, color: const Color(0xFF1CE2D6), size: 20),
              hintText: label.replaceAll(' *', ''),
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        ),
      ],
    );
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
                              'Manage Products',
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
                            Icons.inventory_2_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Add Product Button
                    Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _showAddProductDialog,
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFF1CE2D6),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Add New Product',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1CE2D6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search and Filters Section
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
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
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Icon(
                            Icons.search,
                            color: const Color(0xFF1CE2D6),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: GoogleFonts.poppins(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Search products by name...',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Filter Dropdowns
                  Row(
                    children: [
                      Expanded(
                        child: _buildFilterDropdown(
                          value: _selectedStatus,
                          items: ['All', 'Active', 'Inactive', 'Out of Stock'],
                          icon: Icons.filter_list,
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFilterDropdown(
                          value: _selectedCategory,
                          items: [
                            'All Categories',
                            'Cosmetics',
                            'SkinCare',
                            'Fashion',
                            'Electronics'
                          ],
                          icon: Icons.category,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Products Grid
            Expanded(
              child: _filteredProducts.isEmpty
                  ? Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFF1CE2D6),
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'No products found',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF3D5150),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Try adjusting your filters or add a new product',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.58, 
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        return _buildProductCard(_filteredProducts[index], index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(
              icon,
              color: const Color(0xFF1CE2D6),
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF1CE2D6),
                  size: 20,
                ),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF3D5150),
                  fontWeight: FontWeight.w500,
                ),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    final bool isOutOfStock = product['stock'] == 0;
    final bool isLowStock = product['stock'] > 0 && product['stock'] <= 3;
    final bool isInactive = product['status'] == 'Inactive';
    final bool hasImages = product['images'] != null && product['images'].isNotEmpty;
    final List<String> categories = List<String>.from(product['categories']);
    final String categoryText = categories.length > 1 
        ? '${categories[0]} +${categories.length - 1}' 
        : categories[0];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isInactive
              ? Colors.grey.withOpacity(0.3)
              : Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 115, 
            width: double.infinity,
            decoration: BoxDecoration(
              color: isInactive
                  ? Colors.grey[200]
                  : const Color(0xFFF8F9FA),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // Product Image
                if (hasImages)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.file(
                      product['images'][0],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
                
                // Status Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: product['status'] == 'Active'
                          ? Colors.green
                          : Colors.grey[600],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product['status'],
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Inactive Overlay
                if (isInactive)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'INACTIVE',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Product Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top section: Name, description, category
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        product['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isInactive
                              ? Colors.grey[600]
                              : const Color(0xFF3D5150),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      
                      // Description
                      Text(
                        product['description'],
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: isInactive
                              ? Colors.grey[500]
                              : Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // Category Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isInactive
                              ? Colors.grey[200]
                              : const Color(0xFF1CE2D6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.label,
                              size: 10,
                              color: isInactive
                                  ? Colors.grey[500]
                                  : const Color(0xFF1CE2D6),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                categoryText,
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: isInactive
                                      ? Colors.grey[500]
                                      : const Color(0xFF1CE2D6),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Bottom section: Price, stock, and buttons
                  Column(
                    children: [
                      // Price and Stock Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '\$${product['price']}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: isInactive
                                          ? Colors.grey[600]
                                          : const Color(0xFF1CE2D6),
                                    ),
                                  ),
                                ),
                                if (product['salePrice'] != null && product['salePrice'].isNotEmpty)
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '\$${product['salePrice']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isOutOfStock
                                  ? Colors.red.withOpacity(0.1)
                                  : isLowStock
                                      ? Colors.orange.withOpacity(0.1)
                                      : Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.inventory_2,
                                  size: 10,
                                  color: isOutOfStock
                                      ? Colors.red
                                      : isLowStock
                                          ? Colors.orange
                                          : Colors.green,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${product['stock']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isOutOfStock
                                        ? Colors.red
                                        : isLowStock
                                            ? Colors.orange
                                            : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      // Action Buttons
                      SizedBox(
                        height: 32,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildActionButton(
                                icon: Icons.edit,
                                label: 'Edit',
                                color: isInactive
                                    ? Colors.grey
                                    : const Color(0xFF1CE2D6),
                                onTap: () {
                                  _showEditProductDialog(product);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildActionButton(
                                icon: isInactive ? Icons.check : Icons.close,
                                label: isInactive ? 'Activate' : 'Deactivate',
                                color: isInactive ? Colors.green : Colors.orange,
                                onTap: () => _toggleProductStatus(index),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildDeleteButton(
                              onTap: () => _deleteProduct(index),
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
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 14,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.red.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          size: 16,
        ),
      ),
    );
  }
}