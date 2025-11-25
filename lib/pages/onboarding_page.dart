import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/core/widgets/elevated_button_widget.dart';
import 'package:bar_brons_app/pages/sign_in.dart';
import 'package:bar_brons_app/pages/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            spacing: 18,
            children: [
              SizedBox(
                height: 450.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 50.h,
                      left: 88.w,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        ),
                        child: CircleAvatar(
                          radius: 75.r,
                          backgroundColor: AppColors.background,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 75.h,
                      left: 121.w,
                      child: Image.asset("assets/images/person.png"),
                    ),
                  ],
                ),
              ),
              Text(
                "BarBronsga Xush Kelibsiz ! 👋",
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              Text(
                "Navbatdagi sochingizni kesishni bir necha soniya ichida rejalashtiring. Uchrashuvlarni osonlik bilan bron qiling va boshqaring.",
                style: TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 30.h),
              ElevatedButtonWidget(
                text: "Kirish",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInPage()),
                  );
                },
              ),
              RichText(
                text: TextSpan(
                  text: "Ro'yxatdan o'tmaganmisiz ? ",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                      text: "Hisob yaratish",
                      style: TextStyle(color: AppColors.yellow),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Divider(color: Colors.grey, thickness: 1),
                    ),
                  ),
                  Text(
                    "Yoki",
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Divider(color: Colors.grey, thickness: 1),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Image.asset("assets/images/Facebook.png"),
                  Image.asset("assets/images/Twitter.png"),
                  Image.asset("assets/images/Google.png"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
