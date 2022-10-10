import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zomm_clone/app/data/colors.dart';
import 'package:zomm_clone/app/data/typography.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: CustomTextStyle.kTextStyle17,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.buttonColor,
          minimumSize: Size(
            double.infinity.w,
            50.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: BorderSide(
              color: CustomColors.buttonColor,
            ),
          ),
        ),
      ),
    );
  }
}
