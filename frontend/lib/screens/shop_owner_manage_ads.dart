import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import '../flutter_gen/gen_l10n/app_localizations.dart';

class ManageAdsScreen extends StatefulWidget {
  const ManageAdsScreen({super.key});

  @override
  State<ManageAdsScreen> createState() => _ManageAdsScreenState();
}

class _ManageAdsScreenState extends State<ManageAdsScreen> {
  final TextEditingController _staticDateController = TextEditingController();
  final TextEditingController _dynamicDateController = TextEditingController();
  
  // Static values (managed by Super Admin from backend)
  static const String _staticExpirationDate = '03/27/2026';
  static const String _dynamicExpirationDate = '02/28/2026';
  static const int _adsLimit = 2;
  
  File? _staticAdImage;
  List<File> _dynamicAdImages = [];
  
  final ImagePicker _imagePicker = ImagePicker();
  bool _isDownloading = false;
  
  @override
  void initState() {
    super.initState();
    // Set static dates from backend values
    _staticDateController.text = _staticExpirationDate;
    _dynamicDateController.text = _dynamicExpirationDate;
  }
  
  Future<void> _pickStaticImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );
    
    if (image != null) {
      setState(() {
        _staticAdImage = File(image.path);
      });
    }
  }
  
  Future<void> _pickDynamicImages() async {
    if (_adsLimit <= 0) {
      _showErrorSnackBar(AppLocalizations.of(context)!.adsLimitDisabledByAdmin);
      return;
    }
    
    final List<XFile> images = await _imagePicker.pickMultiImage(
      imageQuality: 85,
      maxWidth: 1200,
    );
    
    setState(() {
      // Limit dynamic images to the static ads limit
      final newImages = images.take(_adsLimit - _dynamicAdImages.length);
      _dynamicAdImages.addAll(newImages.map((image) => File(image.path)));
      if (_dynamicAdImages.length > _adsLimit) {
        _dynamicAdImages = _dynamicAdImages.sublist(0, _adsLimit);
      }
    });
  }
  
  void _removeStaticImage() {
    setState(() {
      _staticAdImage = null;
    });
  }
  
  void _removeDynamicImage(int index) {
    setState(() {
      _dynamicAdImages.removeAt(index);
    });
  }
  
  Future<void> _downloadStaticImage() async {
    if (_staticAdImage == null) {
      _showErrorSnackBar(AppLocalizations.of(context)!.noStaticImageError);
      return;
    }
    
    try {
      // Request storage permission
      final status = await ph.Permission.storage.request();
      
      if (status.isGranted) {
        setState(() {
          _isDownloading = true;
        });
        
        // Get the downloads directory (works on both Android and iOS)
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          // Create a downloads subdirectory
          final downloadsDir = Directory('${directory.path}/Download');
          if (!await downloadsDir.exists()) {
            await downloadsDir.create(recursive: true);
          }
          
          final fileName = 'static_ad_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final destinationPath = '${downloadsDir.path}/$fileName';
          
          // Copy the file to downloads
          await _staticAdImage!.copy(destinationPath);
          
          _showSuccessSnackBar(AppLocalizations.of(context)!.downloadSuccess);
        } else {
          _showErrorSnackBar(AppLocalizations.of(context)!.accessDownloadsDirectoryError);
        }
      } else if (status.isPermanentlyDenied) {
        _showErrorSnackBar(AppLocalizations.of(context)!.enableStoragePermission);
        ph.openAppSettings();
      } else {
        _showErrorSnackBar(AppLocalizations.of(context)!.storagePermissionRequired);
      }
    } catch (e) {
      _showErrorSnackBar(AppLocalizations.of(context)!.downloadError(e.toString()));
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }
  
  void _saveChanges() {
    // Validate dynamic images count matches ads limit
    if (_adsLimit > 0 && _dynamicAdImages.length != _adsLimit) {
      _showErrorSnackBar(AppLocalizations.of(context)!.adsLimitError(_dynamicAdImages.length.toString(), _adsLimit.toString()));
      return;
    }
    
    // Save logic for images would go here
    // Note: Expiration dates and ads limit are managed by Super Admin from backend
    
    _showSuccessSnackBar(AppLocalizations.of(context)!.adsSavedSuccessfully);
  }
  
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  Widget _buildStaticAdImageCard() {
    if (_staticAdImage == null) {
      return GestureDetector(
        onTap: _pickStaticImage,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF1CE2D6).withOpacity(0.5),
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Color(0xFF1CE2D6),
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.addStaticImage,
                  textAlign: TextAlign.center,
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
      );
    }
    
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _staticAdImage!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        color: const Color(0xFF1CE2D6),
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.errorLoadingImage,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: Row(
            children: [
              // Download button
              GestureDetector(
                onTap: _isDownloading ? null : _downloadStaticImage,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _isDownloading ? Colors.grey : Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: _isDownloading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(
                          Icons.download,
                          color: Colors.white,
                          size: 16,
                        ),
                ),
              ),
              const SizedBox(width: 4),
              // Delete button
              GestureDetector(
                onTap: _removeStaticImage,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildDynamicAdImageCard(File image, int index) {
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
                    Icons.broken_image,
                    color: const Color(0xFF1CE2D6),
                    size: 30,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => _removeDynamicImage(index),
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
  }
  
  Widget _buildStaticFormField({
    required String label,
    required String value,
    String? description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3D5150),
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 4),
      
        ],
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF1CE2D6).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: const Color(0xFF1CE2D6),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF3D5150),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  AppLocalizations.of(context)!.setBySuperAdmin,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildAdsLimitField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.adsLimitLabel,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3D5150),
          ),
        ),
        const SizedBox(height: 4),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF1CE2D6).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.numbers,
                color: const Color(0xFF1CE2D6),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$_adsLimit',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF3D5150),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  AppLocalizations.of(context)!.setBySuperAdmin,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF3D5150),
      ),
    );
  }
  
  Widget _buildAdSection({
    required String title,
    required bool isStatic,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3D5150),
            ),
          ),
          const SizedBox(height: 8),
          
          // Divider
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          const SizedBox(height: 16),
          
          // Ads Limit field (only for dynamic ads)
          if (!isStatic) ...[
            _buildAdsLimitField(),
            const SizedBox(height: 16),
          ],
          
          // Expiration Date field
          _buildStaticFormField(
            label: AppLocalizations.of(context)!.expirationDateLabel,
            value: isStatic ? _staticExpirationDate : _dynamicExpirationDate,
            description: isStatic ? AppLocalizations.of(context)!.expirationDateDescription : AppLocalizations.of(context)!.expirationDateDescription,
          ),
          const SizedBox(height: 16),
          
          // Image section header
          isStatic
              ? _buildSectionHeader(AppLocalizations.of(context)!.staticAdImageLabel)
              : _buildSectionHeader(AppLocalizations.of(context)!.dynamicAdImagesLabel(_dynamicAdImages.length.toString(), _adsLimit.toString())),
          const SizedBox(height: 12),
          
          // Images section
          if (isStatic) ...[
            _buildStaticAdImageCard(),
            if (_staticAdImage != null) ...[
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.downloadToSave,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ] else ...[
            // Dynamic images
            if (_dynamicAdImages.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey[300]!,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.photo_library,
                      color: const Color(0xFF1CE2D6),
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.noDynamicAdImages,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.clickAddImagesButton,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ] else ...[
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ..._dynamicAdImages
                      .asMap()
                      .entries
                      .map((entry) => _buildDynamicAdImageCard(entry.value, entry.key))
                      ,
                ],
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.dynamicImagesCount(_dynamicAdImages.length.toString(), _adsLimit.toString()),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: _dynamicAdImages.length == _adsLimit 
                      ? Colors.green 
                      : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // Updated Header with Gradient - Full width like Profile Screen
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
                    // Top Bar - Title Centered
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
                              AppLocalizations.of(context)!.adsManagement,
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
                            Icons.ads_click,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                  ],
                ),  
              ),

            ),
          ),
          // Ads Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Static Ad Plan
                  _buildAdSection(
                    title: AppLocalizations.of(context)!.staticAdPlan,
                    isStatic: true,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Dynamic Ad Plan
                  _buildAdSection(
                    title: AppLocalizations.of(context)!.dynamicAdPlan,
                    isStatic: false,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Add Images Button (for Dynamic Ad Plan only)
                  if (_adsLimit > 0) ...[
                    Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _dynamicAdImages.length >= _adsLimit
                              ? Colors.grey
                              : const Color(0xFF1CE2D6),
                          width: 1.5,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _dynamicAdImages.length >= _adsLimit ? null : _pickDynamicImages,
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                color: _dynamicAdImages.length >= _adsLimit
                                    ? Colors.grey
                                    : const Color(0xFF1CE2D6),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.addImagesToDynamicAdPlan,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _dynamicAdImages.length >= _adsLimit
                                      ? Colors.grey
                                      : const Color(0xFF1CE2D6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _dynamicAdImages.length >= _adsLimit
                          ? AppLocalizations.of(context)!.maxImagesReached(_adsLimit.toString())
                          : AppLocalizations.of(context)!.addUpToImages(_adsLimit.toString()),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: _dynamicAdImages.length >= _adsLimit
                            ? Colors.orange
                            : Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Divider
                  Container(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Save/Cancel Buttons
                  Row(
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
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1CE2D6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveChanges,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1CE2D6),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.saveChanges,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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
  
  @override
  void dispose() {
    _staticDateController.dispose();
    _dynamicDateController.dispose();
    super.dispose();
  }
}