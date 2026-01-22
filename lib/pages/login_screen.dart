import 'package:crown_cuts/main_screen.dart';
import 'package:crown_cuts/pages/register_screen.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_provider.dart';
import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isOwner = true;
  bool obscurePassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            right: -20,
            child: _blurCircle(BarbershopTheme.accent.withValues(alpha: 0.22)),
          ),
          Positioned(
            bottom: -60,
            left: -30,
            child: _blurCircle(BarbershopTheme.sea.withValues(alpha: 0.18)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
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
                        Icons.content_cut_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text('Bar Brons', style: BarbershopTheme.display()),
                        const SizedBox(height: 6),
                        Text('Business console',
                            style: BarbershopTheme.body()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
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
                        Text('Sign in', style: BarbershopTheme.title()),
                        const SizedBox(height: 16),
                        _buildRoleToggle(),
                        const SizedBox(height: 20),
                        _buildInput(
                          label: 'USERNAME',
                          controller: _usernameController,
                          icon: Icons.person,
                          hintText: 'Enter username',
                        ),
                        const SizedBox(height: 16),
                        _buildPasswordInput(),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot password?',
                            style: BarbershopTheme.body(
                              color: BarbershopTheme.accentDeep,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () async {
                                    if (!isOwner) {
                                      _showMessage(
                                          'Barber sign-in is not available yet.');
                                      return;
                                    }

                                    final username =
                                        _usernameController.text.trim();
                                    final password =
                                        _passwordController.text.trim();

                                    if (username.isEmpty || password.isEmpty) {
                                      _showMessage(
                                          'Please enter username and password.');
                                      return;
                                    }

                                    final success = await context
                                        .read<BarberShopAuthProvider>()
                                        .signInOwner(
                                          username: username,
                                          password: password,
                                        );

                                    if (!mounted) return;

                                    if (success) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreen(),
                                        ),
                                      );
                                    } else {
                                      _showMessage(
                                        context
                                                .read<BarberShopAuthProvider>()
                                                .errorMessage ??
                                            'Login failed. Please try again.',
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
                                    'Enter Dashboard',
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
                  Visibility(
                    visible: isOwner,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New here? ', style: BarbershopTheme.body()),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Register shop',
                            style: BarbershopTheme.body(
                              color: BarbershopTheme.forest,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
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

  Widget _buildRoleToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: BarbershopTheme.chip,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isOwner = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isOwner ? BarbershopTheme.forest : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'Owner',
                  textAlign: TextAlign.center,
                  style: BarbershopTheme.body(
                    color: isOwner ? Colors.white : BarbershopTheme.muted,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isOwner = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !isOwner ? BarbershopTheme.forest : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'Barber',
                  textAlign: TextAlign.center,
                  style: BarbershopTheme.body(
                    color: !isOwner ? Colors.white : BarbershopTheme.muted,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
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
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: BarbershopTheme.body(),
              prefixIcon: Icon(icon, color: BarbershopTheme.muted),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordInput() {
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
              border: InputBorder.none,
              hintText: 'Enter password',
              hintStyle: BarbershopTheme.body(),
              prefixIcon: const Icon(Icons.lock_outline,
                  color: BarbershopTheme.muted),
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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
