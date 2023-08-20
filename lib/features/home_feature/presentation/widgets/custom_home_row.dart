import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/utils/app_colors.dart';
import '../../../../app/widgets/text_widget.dart';

class CustomHomeRow extends StatelessWidget {
  const CustomHomeRow({super.key, required this.catName, this.onTap});
  final String catName;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: catName,
            titleColor: AppColors.black3333,
            titleSize: 22.sp,
            titleFontWeight: FontWeight.bold,
          ),
          InkWell(
            onTap: onTap??(){},
            child: TextWidget(
              title: "SeeAll".tr(),
              titleColor: AppColors.gery455,
              titleSize: 18.sp,
              titleFontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
