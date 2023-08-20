import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/app_fonts.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_button_widget.dart';
import '../../../../app/widgets/text_widget.dart';
import '../../../profile_feature/presentation/widgets/custom_edit_button.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({super.key, this.title, this.imageName, this.price, this.colorName, this.countNum=1, this.piecesNum=50, this.deleteOnPressed, this.saveOnPressed, this.addOnPressed, this.minusOnPressed, this.isCart=false});
  final String?title;
  final String?imageName;
  final String?price;
  final String?colorName;
  final bool isCart;
  final int? countNum;
  final int? piecesNum;
  final VoidCallback ? deleteOnPressed;
  final VoidCallback ? saveOnPressed;
  final VoidCallback ? addOnPressed;
  final VoidCallback ? minusOnPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin:const EdgeInsets.only(bottom: 16,),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(
            imageUrl:imageName?? AppAssets.catItem,
            width: 70.w,
            height: 70.h,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextWidget(
                        title:title?? "Lorem ipsum dolor sit am econse...",
                        fontFamily: AppFonts.semiBold,
                        titleSize: 14.sp,
                        titleAlign: TextAlign.start,
                        titleColor: AppColors.black3333,
                      ),
                    ),
                    8.horizontalSpace,
                    CustomEditButton(
                      onPressed:deleteOnPressed?? () {},
                      icon: Icons.delete,
                      iconColor: AppColors.red,
                      backColor: const Color(0xffFDEEEE),
                      size: 32.w,
                      iconSize: 22.sp,
                    )
                  ],
                ),
                TextWidget(
                  title:"${"Color".tr()} : ${colorName??'White'}",
                  titleFontWeight: FontWeight.w600,
                  titleSize: 15.sp,
                  titleAlign: TextAlign.start,
                  titleColor: AppColors.black3333,

                ),
                14.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ////button
                    Container(
                      width: 24.w,
                      height: 24.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.gery455
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed:minusOnPressed?? () {},
                        icon: Icon(
                          Icons.remove,
                          size: 22.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    TextWidget(
                      title: countNum?.toString() ?? "1",
                      fontFamily: AppFonts.semiBold,
                      titleSize: 14.sp,
                      titleColor: Color(0xffEB5757),

                    ),
                    8.horizontalSpace,
                    Container(
                      width: 24.w,
                      height: 24.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.gery455
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: addOnPressed??() {},
                        icon: Icon(
                          Icons.add,
                          size: 22.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    30.horizontalSpace,
                    Container(
                      width: 56.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.gery455.withOpacity(.1)
                      ),
                      child: TextWidget(
                        title:piecesNum?.toString()?? "50",
                        fontFamily: AppFonts.bold,
                        titleSize: 16.sp,
                        titleColor: AppColors.black3333,

                      ),
                    ),
                    8.horizontalSpace,
                    TextWidget(
                      title: "Pieces".tr(),
                      titleFontWeight: FontWeight.w600,
                      titleSize: 16.sp,
                      titleColor: AppColors.black3333,

                    ),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title:price?? "50.00 EGP",
                      fontFamily: AppFonts.bold,
                      titleSize: 16.sp,
                      titleColor: AppColors.black3333,

                    ),
                    CustomTextButton(
                      onPressed: saveOnPressed?? () {},
                      title:isCart? "SaveLater".tr():"MoveToCart".tr(),
                      textDecoration: TextDecoration.underline,
                      titleColor: AppColors.gery455,
                      titleSize: 14.sp,
                      titleFontWeight: FontWeight.w600,
                    )
                  ],
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
}
