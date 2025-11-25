import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/core/widgets/elevated_button_widget.dart';
import 'package:bar_brons_app/core/widgets/my_custom_check_box_widget.dart';
import 'package:bar_brons_app/core/widgets/text_field_widget.dart';
import 'package:bar_brons_app/pages/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(top: 12.h, right: 16.w, left: 16.w),
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/barBronsLogo.png",
                  width: 150.w,
                  height: 150.h,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ro'yxatdan o'tish",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 120.h),
            Text(
              "Foydalanuvchi nomi",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),

            TextFieldWidget(controller: _userController),

            SizedBox(height: 1.h),
            Text("Parol", style: TextStyle(color: Colors.white, fontSize: 15)),

            TextFieldWidget(controller: _passwordController),
            MyCustomCheckbox(
              text: RichText(text: TextSpan(text: "Eslab qolish")),
            ),
            ElevatedButtonWidget(onPressed: () {}, height: 55),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Ro'yxatdan o'tmaganmisiz ? ",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                        text: "Hisob yaratish",
                        style: TextStyle(color: AppColors.yellow),
                      ),
                    ],
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
