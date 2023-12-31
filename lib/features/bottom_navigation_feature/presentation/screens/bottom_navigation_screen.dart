import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/widgets/image_widget.dart';
import '../presentation_logic_holder/bottom_navigation_cubit.dart';
import '../presentation_logic_holder/bottom_navigation_state.dart';
class BNBScreen extends StatelessWidget {
  const BNBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, BottomNavigationStats>(
        builder: (context, state) {
          var cubit= BottomNavigationCubit.get(context);
          return Scaffold(
            bottomNavigationBar: SizedBox(
              height: 100.h,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: AppColors.mainColor,
                unselectedItemColor: AppColors.gery4,
                selectedFontSize: 17.sp,
                unselectedFontSize: 16.sp,
                onTap:(value) {
                  cubit.changeCurrent(value);
                },
                currentIndex: cubit.currentIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                 BottomNavigationBarItem(
                   icon:ImageWidget(
                       imageUrl: AppAssets.home,
                     width: 30.w,
                     height: 30.h,
                     color: cubit.currentIndex==0?AppColors.mainColor:AppColors.gery4,
                   ),
                   label: "Home".tr()
                 ),
                 BottomNavigationBarItem(
                   icon:ImageWidget(
                     imageUrl: AppAssets.category,
                     width: 30.w,
                     height: 30.h,
                     color: cubit.currentIndex==1?AppColors.mainColor:AppColors.gery4,
                   ),
                   label: "Categories".tr()
                 ),
                 BottomNavigationBarItem(
                   icon:ImageWidget(
                     imageUrl: AppAssets.card,
                     width: 30.w,
                     height: 30.h,
                     color: cubit.currentIndex==2?AppColors.mainColor:AppColors.gery4,
                   ),
                   label: "Cart".tr()
                 ),
                 // BottomNavigationBarItem(
                 //   icon: Icon(
                 //     Icons.person,
                 //     size: 35.sp,
                 //   ),
                 //   label: "Profile".tr()
                 // ),
                ],
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
