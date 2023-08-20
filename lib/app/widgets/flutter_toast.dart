import 'package:eccommerce_app/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
Future<bool?> showToast({
  required String msg,
  Color backgroundColor= AppColors.mainColor,
  Color textColor= AppColors.white,
}){
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor:backgroundColor,
      textColor: textColor,
      fontSize: 18.sp
  );
}