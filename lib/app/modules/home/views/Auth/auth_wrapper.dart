 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zomm_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:zomm_clone/app/modules/home/views/Auth/login.dart';
import 'package:zomm_clone/app/modules/home/views/Nav%20Bar/nav_bar.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(),
      builder: (controller) {
        if (controller.getUser == null) {
          return LoginScreen();
        } else {
          return BottomNavBar();
        }
      },
    );
  }
}
