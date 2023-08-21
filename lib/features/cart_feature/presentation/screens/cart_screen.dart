import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/app_fonts.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/widgets/default_app_bar_widget.dart';
import '../widgets/custom_cart_body.dart';
import '../widgets/custom_saved_body.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   DefaultAppBarWidget(
        actions: true,
        canBack: false,
        actionsOnPressed: () {
         // navigateTo(const NotificationScreen());
        },
        title: "Cart".tr(),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  indicatorColor: AppColors.red,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: AppColors.black3333,
                  // indicatorWeight: 12,
                  automaticIndicatorColorAdjustment: false,
                  indicator: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  labelPadding: EdgeInsets.only(top:14.h, bottom: 14.h),
                  labelColor: AppColors.white,
                  tabs: [
                    Text(
                      "CartItems".tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                        fontFamily: AppFonts.semiBold,
                      ),
                    ),
                    Text(
                      "SavedItems".tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: AppFonts.semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: tabController,
              children: const [
                CustomCartBody(),
                CustomSavedBody(),
              ],
            ),
          )


        ],
      ),
    );
  }
}
