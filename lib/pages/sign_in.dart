import 'package:bar_brons_app/core/router/role_based_router.dart';
import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/core/widgets/elevated_button_widget.dart';
import 'package:bar_brons_app/core/widgets/text_field_widget.dart';
import 'package:bar_brons_app/role/barbershop/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/enum/user_role.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  UserRole _selectedRole = UserRole.BARBERSHOP;
  final List<UserRole> _signInRoles = [
    UserRole.BARBERSHOP,
    UserRole.HAIRDRESSERS,
  ];

  late AnimationController _textAnimationController;
  late Animation<double> _largeTextScaleAnimation;

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _largeTextScaleAnimation = Tween<double>(
      begin: 1.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeOutBack,
    ));
    _textAnimationController.forward();
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      _showMessage("Iltimos, barcha maydonlarni to'ldiring");
      return;
    }
    setState(() => _isLoading = true);
    final result = await _authService.signIn(
      _userController.text.trim(),
      _passwordController.text.trim(),
      expectedRole: _selectedRole,
    );

    setState(() => _isLoading = false);

    if (result["success"]) {
      final role = result["role"];
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoleBasedRouter.getHomePageForRole(role),
        ),
      );
    } else {
      _showMessage(result["message"]);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.orange),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.appBarTheme.foregroundColor;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: EdgeInsets.only(top: 12.h, right: 16.w, left: 16.w),
          child: SingleChildScrollView(
            child: Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120.h),
                AnimatedBuilder(
                  animation: _textAnimationController,
                  builder: (context, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Large "S"
                        Transform.scale(
                          scale: _largeTextScaleAnimation.value,
                          child: Text(
                            "S",
                            style: TextStyle(
                              fontFamily: "Comic",
                              fontSize: 70,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        ),

                        // Rest of "TYLE"
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "TYLE",
                            style: TextStyle(
                              fontFamily: "Comic",
                              fontSize: 45,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // "UP" in circle
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.yellow,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.yellow.withValues(alpha: 0.4),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "UP",
                                style: TextStyle(
                                  fontFamily: "Comic",
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Business",
                      style: TextStyle(
                        fontFamily: "Comic",
                        fontSize: 35.sp,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Center(
                  child: TabBar(
                    isScrollable: true,
                    labelColor: AppColors.yellow,
                    unselectedLabelColor: textColor,
                    indicatorColor: AppColors.yellow,
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onTap: (index) {
                      setState(() => _selectedRole = _signInRoles[index]);
                    },
                    tabs: const [
                      Tab(text: "Barbershops"),
                      Tab(text: "Barbers"),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Foydalanuvchi nomi",
                  style: TextStyle(color: textColor, fontSize: 15),
                ),

                TextFieldWidget(controller: _userController),

                SizedBox(height: 1.h),
                Text("Parol", style: TextStyle(color: textColor, fontSize: 15)),

                TextFieldWidget(
                  controller: _passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 30.h),

                // MyCustomCheckbox(
                //   text: RichText(
                //     text: TextSpan(
                //       text: "Eslab qolish",
                //       style: TextStyle(color: textColor),
                //     ),
                //   ),
                // ),
                ElevatedButtonWidget(onPressed: _handleSignIn, height: 55),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // RichText(
                    //   text: TextSpan(
                    //     text: "Ro'yxatdan o'tmaganmisiz ? ",
                    //     style: TextStyle(color: textColor),
                    //     children: [
                    //       TextSpan(
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () {
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) => const SignUpPage(),
                    //               ),
                    //             );
                    //           },
                    //         text: "Hisob yaratish",
                    //         style: const TextStyle(color: AppColors.yellow),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
