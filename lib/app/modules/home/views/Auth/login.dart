import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zomm_clone/app/data/image_path.dart';
import 'package:zomm_clone/app/data/typography.dart';
import 'package:zomm_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:zomm_clone/app/modules/home/views/Widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Start or join a meeting',
            style: CustomTextStyle.kTextSyle24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 38.h),
            child: Image.asset(
              CustomAssets.kLogo,
            ),
          ),
          GetBuilder<AuthController>(
              init: AuthController(),
              builder: (c) {
                return CustomButton(
                    text: 'Google Sign In',
                    onPressed: () async {
                      bool res = await c.signinWithGoogls();
                      if (res == true) {
                        Get.snackbar('Google Sigin Success',
                            'Congrst Sigin With Google');
                      } else {
                        Get.snackbar(
                            'Google Sigin Error', 'no Sigin With Google');
                      }
                    });
              }),
        ],
      ),
    );
  }
}
