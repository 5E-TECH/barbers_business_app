import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/core/widgets/elevated_button_widget.dart';
import 'package:bar_brons_app/core/widgets/my_custom_check_box_widget.dart';
import 'package:bar_brons_app/core/widgets/text_field_widget.dart';
import 'package:bar_brons_app/pages/sign_in.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(top: 12.h, right: 16.w,left: 16.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 5,
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
              Text("Ism", style: TextStyle(color: Colors.white, fontSize: 15)),
              TextFieldWidget(controller: _nameController),
              SizedBox(height: 1.h),
              Text(
                "Familiya",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
          
              TextFieldWidget(controller: _lastnameController),
              SizedBox(height: 1.h),
          
              Text(
                "Faydalanuvchi nomi",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
          
              TextFieldWidget(controller: _userNameController),
              SizedBox(height: 1.h),
          
              Text(
                "Telefon raqam",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
          
              TextFieldWidget(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 1.h),
          
              Text("Parol", style: TextStyle(color: Colors.white, fontSize: 15)),
          
              TextFieldWidget(controller: _passwordController, isPassword: true),
              MyCustomCheckbox(),
              ElevatedButtonWidget(
                onPressed: () {},
                text: "Ro'yxatdan o'tish",
                height: 40,
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Hisobingiz bormi ? ",
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInPage(),
                                ),
                              );
                            },
                          text: "Kirish",
                          style: TextStyle(color: AppColors.yellow),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h,),
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
              SizedBox(height: 5.h,),
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
