
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/utils/app_colors.dart';
import '../../../../app/widgets/button_widget.dart';
import '../../../../app/widgets/custom_form_field.dart';
import '../../../../app/widgets/default_app_bar_widget.dart';
import '../../domain/usecases/contact_us_usecase.dart';
import '../presentation_logic_holder/cubit/account_cubit.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackGround,
      appBar:  DefaultAppBarWidget(
        canBack: true,
        title: "ContactUs".tr(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 40.h),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomFormField(
                controller: nameController,
                header: "FullName".tr(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icons.person_outline_outlined,
                hint: "EnterFullName".tr(),
              ),
              16.verticalSpace,
              CustomFormField(
                controller: phoneController,
                header: "MobileNumber".tr(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icons.phone_android,
                hint: "EnterMobile".tr(),
              ),
              16.verticalSpace,
              CustomFormField(
                controller: emailController,
                header: "Email".tr(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icons.email_outlined,
                hint: "EnterEmail".tr(),
              ),
              16.verticalSpace,
              CustomFormField(
                controller: messageController,
                header: "Message".tr(),
                filled: true,
                maxLines: 6,
                minLines: 6,
                fillColor: Colors.white,
                hint: "EnterMessage".tr(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          return Container(
            height: 100.h,
            padding: EdgeInsetsDirectional.all(20.sp),
            color: Colors.white,
            child: ButtonWidget(
              loading: state is ContactUsLoading,
              text: "Send".tr(),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  AccountCubit.get(context).contactUs(
                    ContactUsUseCaseParams(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      messages: messageController.text,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
