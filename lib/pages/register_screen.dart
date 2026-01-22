import 'dart:io';

import 'package:crown_cuts/core/widgets/location_picker_screen.dart';
import 'package:crown_cuts/pages/login_screen.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_models.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_provider.dart';
import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool obscurePassword = true;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Location data
  double? _latitude;
  double? _longitude;

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
    _nameController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _openLocationPicker() async {
    final result = await LocationPickerScreen.show(
      context,
      initialLatitude: _latitude,
      initialLongitude: _longitude,
    );

    if (result != null) {
      setState(() {
        _latitude = result.latitude;
        _longitude = result.longitude;
        _locationController.text = result.address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<BarberShopAuthProvider>();

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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back,
                              color: BarbershopTheme.ink),
                        ),
                        const SizedBox(width: 4),
                        Text('Create account',
                            style: BarbershopTheme.title()),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: BarbershopTheme.forest,
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
                              Icons.storefront,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text('Register your studio',
                              style: BarbershopTheme.display()),
                          const SizedBox(height: 6),
                          Text('Make your barbershop visible to clients',
                              style: BarbershopTheme.body()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const SizedBox(height: 8),
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
                            label: 'BARBER SHOP NAME',
                            controller: _nameController,
                            hint: 'Enter shop name',
                            icon: Icons.store,
                          ),
                          const SizedBox(height: 16),
                          _buildLocationPicker(),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'USERNAME',
                            controller: _usernameController,
                            hint: 'Choose a username',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 16),
                          _buildPasswordField(),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'PHONE NUMBER',
                            controller: _phoneController,
                            hint: '+998900000000',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'DESCRIPTION',
                            controller: _descriptionController,
                            hint: 'Tell clients about your shop',
                            icon: Icons.description_outlined,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          _buildImagePicker(
                            label: 'SHOP IMAGE',
                            onTap: _pickImage,
                            image: _selectedImage,
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: authProvider.isLoading
                                  ? null
                                  : () async {
                                      final name = _nameController.text.trim();
                                      final location =
                                          _locationController.text.trim();
                                      final password =
                                          _passwordController.text.trim();
                                      final username =
                                          _usernameController.text.trim();
                                      final description =
                                          _descriptionController.text.trim();
                                      final phoneNumber =
                                          _phoneController.text.trim();

                                      if (name.isEmpty ||
                                          location.isEmpty ||
                                          _latitude == null ||
                                          _longitude == null ||
                                          password.isEmpty ||
                                          username.isEmpty ||
                                          description.isEmpty ||
                                          phoneNumber.isEmpty) {
                                        _showMessage(
                                            'Please fill in all required fields.');
                                        return;
                                      }

                                      final request =
                                          BarberShopOwnerSignupRequest(
                                        name: name,
                                        location: location,
                                        latitude: _latitude!,
                                        longitude: _longitude!,
                                        password: password,
                                        username: username,
                                        description: description,
                                        phoneNumber: phoneNumber,
                                      );

                                      final success = await context
                                          .read<BarberShopAuthProvider>()
                                          .signUpOwner(
                                            request: request,
                                            image: _selectedImage,
                                          );

                                      if (!mounted) return;

                                      if (success) {
                                        _showSuccessDialog();
                                      } else {
                                        _showMessage(
                                          context
                                                  .read<BarberShopAuthProvider>()
                                                  .errorMessage ??
                                              'Registration failed. Please try again.',
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BarbershopTheme.forest,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (authProvider.isLoading)
                                    const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  else
                                      Text(
                                        'Register Shop',
                                        style: BarbershopTheme.body(
                                          color: Colors.white,
                                        ).copyWith(fontWeight: FontWeight.w600),
                                      ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward,
                                      color: Colors.white, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',
                            style: BarbershopTheme.body()),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign in',
                            style: BarbershopTheme.body(
                              color: BarbershopTheme.forest,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
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

  Widget _buildLocationPicker() {
    final hasLocation = _latitude != null && _longitude != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LOCATION', style: BarbershopTheme.label()),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _openLocationPicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: BarbershopTheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: BarbershopTheme.line),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: hasLocation
                      ? BarbershopTheme.forest
                      : BarbershopTheme.muted,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _locationController.text.isNotEmpty
                        ? _locationController.text
                        : 'Tap to select location on map',
                    style: BarbershopTheme.body(
                      color: _locationController.text.isNotEmpty
                          ? BarbershopTheme.ink
                          : BarbershopTheme.muted,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasLocation) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: BarbershopTheme.chip,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Lat: ${_latitude!.toStringAsFixed(4)}',
                    style: BarbershopTheme.label(color: BarbershopTheme.forest),
                  ),
                ),
                Container(
                  width: 1,
                  height: 14,
                  color: BarbershopTheme.line,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Lng: ${_longitude!.toStringAsFixed(4)}',
                      style: BarbershopTheme.label(color: BarbershopTheme.forest),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            obscureText: obscurePassword,
            style: BarbershopTheme.body(color: BarbershopTheme.ink),
            decoration: InputDecoration(
              hintText: 'Enter password',
              hintStyle: BarbershopTheme.body(),
              border: InputBorder.none,
              prefixIcon:
                  const Icon(Icons.lock_outline, color: BarbershopTheme.muted),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: BarbershopTheme.muted,
                ),
                onPressed: () =>
                    setState(() => obscurePassword = !obscurePassword),
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
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
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
      builder: (context) => AlertDialog(
        backgroundColor: BarbershopTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            const Icon(Icons.check_circle,
                color: BarbershopTheme.forest, size: 28),
            const SizedBox(width: 12),
            Text('Success', style: BarbershopTheme.title()),
          ],
        ),
        content: Text(
          'Your shop has been registered successfully.',
          style: BarbershopTheme.body(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Text(
              'Go to Login',
              style: BarbershopTheme.body(color: BarbershopTheme.forest)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
