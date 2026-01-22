import 'package:crown_cuts/pages/login_screen.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_provider.dart';
import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String _imageBaseUrl = 'https://hucker.uz/barber';

  String _getFullImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    return '$_imageBaseUrl$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<BarberShopAuthProvider>();
    final account = authProvider.account;

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
            top: -30,
            right: -20,
            child: _blurCircle(BarbershopTheme.accent.withValues(alpha: 0.22)),
          ),
          Positioned(
            bottom: -50,
            left: -30,
            child: _blurCircle(BarbershopTheme.sea.withValues(alpha: 0.18)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
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
                      Text('Profile', style: BarbershopTheme.title()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: BarbershopTheme.surface,
                            border: Border.all(
                                color: BarbershopTheme.accent, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: account?.imagePath.isNotEmpty == true
                                ? Image.network(
                                    _getFullImageUrl(account!.imagePath),
                                    fit: BoxFit.cover,
                                    width: 110,
                                    height: 110,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.store,
                                          size: 46, color: BarbershopTheme.ink);
                                    },
                                  )
                                : const Icon(Icons.store,
                                    size: 46, color: BarbershopTheme.ink),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(account?.name ?? 'Shop Name',
                            style: BarbershopTheme.display()),
                        const SizedBox(height: 4),
                        Text('@${account?.username ?? 'username'}',
                            style: BarbershopTheme.body()),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: BarbershopTheme.chip,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            account?.role ?? 'Owner',
                            style: BarbershopTheme.body(
                              color: BarbershopTheme.ink,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          label: 'Rating',
                          value: account?.averageRating.isNotEmpty == true
                              ? '${account!.averageRating} / 5'
                              : 'No ratings',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _statCard(
                          label: 'Barbers',
                          value: '${account?.barbers.length ?? 0}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _infoCard(
                    title: 'Location',
                    value: account?.location ?? 'Not set',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 12),
                  _infoCard(
                    title: 'Phone',
                    value: account?.phoneNumber ?? 'Not set',
                    icon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 12),
                  _infoCard(
                    title: 'Status',
                    value: account?.status ?? 'Active',
                    icon: Icons.verified_outlined,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () async {
                        await authProvider.logout();
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
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
                          const Icon(Icons.logout, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Log out',
                            style: BarbershopTheme.body(color: Colors.white)
                                .copyWith(fontWeight: FontWeight.w600),
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
    );
  }

  Widget _statCard({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: BarbershopTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: BarbershopTheme.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: BarbershopTheme.label()),
          const SizedBox(height: 8),
          Text(value, style: BarbershopTheme.title()),
        ],
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BarbershopTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: BarbershopTheme.line),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: BarbershopTheme.chip,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: BarbershopTheme.ink, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: BarbershopTheme.label()),
                const SizedBox(height: 2),
                Text(value, style: BarbershopTheme.body()),
              ],
            ),
          ),
        ],
      ),
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
}
