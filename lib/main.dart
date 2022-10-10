import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:zomm_clone/app/modules/home/views/Auth/auth_wrapper.dart';

import 'app/data/themes.dart';
import 'app/modules/home/bindings/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Zoom _clone",
          home: AuthWrapper(),
          initialBinding: InitialBinding(),
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.darkTheme,
        );
      },
    ),
  );
}
