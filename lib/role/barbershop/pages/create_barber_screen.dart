import 'dart:io';

import 'package:crown_cuts/role/barbershop/barbers/logic/barber_create_models.dart';
import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_provider.dart';
import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateBarberScreen extends StatefulWidget {
  const CreateBarberScreen({super.key});

  @override
  State<CreateBarberScreen> createState() => _CreateBarberScreenState();
}

class _CreateBarberScreenState extends State<CreateBarberScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _obscurePassword = true;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BarbersProvider>();

    return Scaffold(
      backgroundColor: BarbershopTheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: BarbershopTheme.heroGradient,
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: -30,
            child: _blurCircle(BarbershopTheme.accent.withValues(alpha: 0.22)),
          ),
          Positioned(
            bottom: -50,
            left: -20,
            child: _blurCircle(BarbershopTheme.sea.withValues(alpha: 0.18)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: BarbershopTheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: BarbershopTheme.line),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: BarbershopTheme.ink,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('Add New Barber', style: BarbershopTheme.title()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Icon and title
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  BarbershopTheme.sea.withValues(alpha: 0.9),
                                  BarbershopTheme.forest,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 18,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person_add,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text('New Team Member',
                              style: BarbershopTheme.display()),
                          const SizedBox(height: 6),
                          Text('Add a barber to your team',
                              style: BarbershopTheme.body()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Form card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: BarbershopTheme.surface,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: BarbershopTheme.line),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField(
                            label: 'FULL NAME',
                            controller: _fullNameController,
                            hint: 'Enter barber full name',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'USERNAME',
                            controller: _usernameController,
                            hint: 'Choose a username',
                            icon: Icons.alternate_email,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'PHONE NUMBER',
                            controller: _phoneController,
                            hint: '+998900000000',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          _buildPasswordField(),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'BIO',
                            controller: _bioController,
                            hint: 'Tell about this barber',
                            icon: Icons.description_outlined,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          _buildImagePicker(
                            label: 'PROFILE IMAGE',
                            onTap: _pickImage,
                            image: _selectedImage,
                          ),
                          const SizedBox(height: 24),

                          // Submit button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: provider.isLoading ? null : _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BarbershopTheme.forest,
                                disabledBackgroundColor:
                                    BarbershopTheme.forest.withValues(alpha: 0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: provider.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Add Barber',
                                          style: BarbershopTheme.body(
                                            color: Colors.white,
                                          ).copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.add,
                                            color: Colors.white, size: 20),
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
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    final fullName = _fullNameController.text.trim();
    final username = _usernameController.text.trim();
    final phoneNumber = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final bio = _bioController.text.trim();

    // Validation
    if (fullName.isEmpty) {
      _showMessage('Please enter full name');
      return;
    }
    if (username.isEmpty) {
      _showMessage('Please enter username');
      return;
    }
    if (phoneNumber.isEmpty) {
      _showMessage('Please enter phone number');
      return;
    }
    if (password.isEmpty) {
      _showMessage('Please enter password');
      return;
    }
    if (password.length < 6) {
      _showMessage('Password must be at least 6 characters');
      return;
    }

    final request = BarberCreateRequest(
      fullName: fullName,
      phoneNumber: phoneNumber,
      password: password,
      username: username,
      bio: bio,
    );

    final success = await context.read<BarbersProvider>().createBarber(
          request: request,
          image: _selectedImage,
        );

    if (!mounted) return;

    if (success) {
      _showSuccessDialog();
    } else {
      _showMessage(
        context.read<BarbersProvider>().errorMessage ??
            'Failed to create barber. Please try again.',
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: BarbershopTheme.label()),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: BarbershopTheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: BarbershopTheme.line),
          ),
          child: TextField(
            controller: controller,
            style: BarbershopTheme.body(color: BarbershopTheme.ink),
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: BarbershopTheme.body(),
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: BarbershopTheme.muted),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PASSWORD', style: BarbershopTheme.label()),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: BarbershopTheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: BarbershopTheme.line),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: BarbershopTheme.body(color: BarbershopTheme.ink),
            decoration: InputDecoration(
              hintText: 'Create password for barber',
              hintStyle: BarbershopTheme.body(),
              border: InputBorder.none,
              prefixIcon:
                  const Icon(Icons.lock_outline, color: BarbershopTheme.muted),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: BarbershopTheme.muted,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker({
    required String label,
    required VoidCallback onTap,
    required File? image,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: BarbershopTheme.label()),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: BarbershopTheme.chip,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: BarbershopTheme.line),
            ),
            child: image != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedImage = null),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 44,
                        color: BarbershopTheme.muted,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to select image',
                        style: BarbershopTheme.body(),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '(Optional)',
                        style: BarbershopTheme.label(),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _blurCircle(Color color) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: BarbershopTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BarbershopTheme.forest.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check_circle,
                  color: BarbershopTheme.forest, size: 24),
            ),
            const SizedBox(width: 12),
            Text('Success', style: BarbershopTheme.title()),
          ],
        ),
        content: Text(
          'Barber has been added to your team successfully.',
          style: BarbershopTheme.body(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context, true); // Return to barbers screen with refresh flag
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: BarbershopTheme.forest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Done',
                style: BarbershopTheme.body(color: Colors.white)
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BarbershopTheme.ink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}