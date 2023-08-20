import 'package:easy_localization/easy_localization.dart';
import 'package:eccommerce_app/features/profile_feature/presentation/screens/personal_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/default_app_bar_widget.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/list_tile_widget.dart';
import '../../../../app/widgets/text_widget.dart';
import '../../../auth_feature/presentation/screens/auth_screen.dart';
import 'contact_us_screen.dart';
import 'language_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackGround,
      appBar: DefaultAppBarWidget(
        notify: false,
        canBack: false,
        actions: true,
        actionsOnPressed: () {
         // navigateTo(const NotificationScreen());
        },
        leading: SizedBox(),
        title: "Profile".tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 43.h),
              child: Row(
                children: [
                  ImageWidget(
                    imageUrl:  getIt<CacheService>().getUserData()?.image??"",
                    width: 64.w,
                    height: 64.h,
                  ),
                  12.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title: getIt<CacheService>().getUserData()?.name??"",
                        titleColor: AppColors.gery455,
                        titleSize: 20.sp,
                        titleFontWeight: FontWeight.w600,
                      ),
                      7.verticalSpace,
                      TextWidget(
                        title: getIt<CacheService>().getUserData()?.phone??"",
                        titleColor: AppColors.hint,
                        titleSize: 16.sp,
                      ),
                    ],
                  )

                ],
              ),
            ),
            23.verticalSpace,
            ///////////////////Personal Information//////////////////
            ListTileWidget(
                onTap: (){
                  navigateTo(const PersonalInfoScreen());
                },
                icon: Icons.person_outline_outlined,
                title: "PersonalInformation".tr(),
            ),
            16.verticalSpace,
            ///////////////////My Order//////////////////
            ListTileWidget(
              onTap: (){
                //todo add navigate here
                //navigateTo(const MyOrdersScreen());
              },
              image: true,
              imageUrl: "assets/icons/box.svg",
              icon: Icons.layers_outlined,
              title: "MyOrders".tr(),
            ),
            16.verticalSpace,
            ///////////////////Shipping Addresses//////////////////
            ListTileWidget(
              onTap: (){
                //todo add navigate here
                //navigateTo(const ShippingAddressScreen());
              },
              icon: Icons.location_on_outlined,
              title: "ShippingAddresses".tr(),
            ),
            16.verticalSpace,
            ///////////////////language//////////////////
            ListTileWidget(
              onTap: (){
                navigateTo(const LanguageScreen());
              },
              icon: Icons.language,
              title: "Languages".tr(),
            ),
            16.verticalSpace,
            ///////////////////Contact us//////////////////
            ListTileWidget(
              onTap: (){
                navigateTo(const ContactUsScreen());
              },
              icon: Icons.sms,
              image: true,
              imageUrl: "assets/icons/sms-tracking.svg",
              title: "ContactUs".tr(),
            ),
            16.verticalSpace,
            ///////////////////log out//////////////////
            ListTileWidget(
              onTap: (){
                globalAlertDialogue(
                  "LogOut".tr(),
                  buttonText2: "yes".tr(),
                  buttonText: "No".tr(),
                  canCancel: true,
                  onOk: () {
                    getIt<CacheService>().clear().then((value) => navigateTo(const AuthScreen(),removeAll: true));

                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                );
              },
              image: true,
              imageUrl: "assets/icons/logout.svg",
              icon: Icons.logout_rounded,
              iconColor: AppColors.red,
              textColor: AppColors.red,
              tralingColor: Colors.white,
              title: "logOut".tr(),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
