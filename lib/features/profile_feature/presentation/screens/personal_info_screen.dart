
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/cache_service.dart';
import '../../../../app/services/image_picker_service/image_picker_service.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/app_fonts.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/custom_form_field.dart';
import '../../../../app/widgets/default_app_bar_widget.dart';
import '../../../../app/widgets/loading.dart';
import '../../../../app/widgets/text_button_widget.dart';
import '../../../../app/widgets/text_widget.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../presentation_logic_holder/cubit/account_cubit.dart';
import '../widgets/custom_edit_button.dart';
import '../widgets/custom_sheet_profile.dart';
import 'change_pass_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  XFile? userImage;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text=getIt<CacheService>().getUserData()?.name??"";
    phoneController.text=getIt<CacheService>().getUserData()?.phone??"";
    emailController.text=getIt<CacheService>().getUserData()?.email??"";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: DefaultAppBarWidget(
          canBack: true,
          title: "PersonalInformation".tr(),
        ),
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            return state is UpdateProfileLoading?Loading():
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // دا حل تاني شوفه
                        userImage==null?
                        Container(
                          width: 160.w,
                          height: 160.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image:
                                  // userImage!=null
                                  //     ?
                                  // FileImage(File(userImage!.path))
                                  // :
                                  // ابقي بص علي دا كده شوفني عامله صح ولا غلط
                                //  userImage==null?
                                  NetworkImage(
                                    getIt<CacheService>().getUserData()?.image??"",
                                  )
                                      //:
                                 // FileImage(File(userImage!.path)) as ImageProvider,
                              ),
                          ),
                        ):CircleAvatar(
                          radius: 80.r,
                          backgroundImage: FileImage(File(userImage!.path)),
                        ),
                        Positioned(
                          right: 10.w,
                          bottom: 10.h,
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration:const BoxDecoration(
                                shape: BoxShape.circle,
                                color:  Color(0xFF455A64)
                            ),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          )
                                        ),
                                        //height: 200.h,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 20.h
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextWidget(
                                                title: "chosePicture".tr(),
                                                titleAlign: TextAlign.center,
                                                titleSize: 20.sp,
                                               titleFontWeight: FontWeight.w600,
                                              fontFamily: AppFonts.regular,
                                              titleColor: Colors.black,
                                            ),
                                            20.verticalSpace,
                                            Row(
                                              mainAxisAlignment : MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                    onPressed:() async{
                                                      await ImagePickerService.getImage(imageSource: ImageSource.camera).then((value) {
                                                        userImage = value;
                                                      });
                                                      Navigator.pop(context);
                                                      setState(() {

                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Colors.black,
                                                      size:25.sp ,
                                                    ),
                                                ),
                                                IconButton(
                                                    onPressed:()async {
                                                      await ImagePickerService.getImage(imageSource: ImageSource.gallery).then((value) {
                                                        userImage = value;
                                                      });
                                                      Navigator.pop(context);
                                                      setState(() {

                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.photo_library_rounded,
                                                      color: Colors.black,
                                                      size:25.sp ,
                                                    ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                );
                              },
                              // onPressed: () {
                              //   globalAlertDialogue(
                              //     "chosePicture".tr(),
                              //     buttonText2: "gallery".tr(),
                              //     buttonText: "cam".tr(),
                              //     canCancel: true,
                              //     onOk: () async{
                              //       await ImagePickerService.getImage(imageSource: ImageSource.gallery).then((value) {
                              //       userImage = value;
                              //      });
                              //      Navigator.pop(context);
                              //      setState(() {
                              //
                              //      });
                              //     },
                              //     onCancel: ()async {
                              //       await   ImagePickerService.getImage(imageSource: ImageSource.camera).then((value){
                              //         return userImage = value;
                              //     });
                              //       Navigator.pop(context);
                              //     },
                              //   );
                              // },
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    40.verticalSpace,
                    CustomFormField(
                      controller: nameController,
                      header: "FullName".tr(),
                      filled: true,
                      suffixIconWidget:CustomEditButton(
                        onPressed: () {
                          showSheet(context: context, controller: nameController,
                              onSave: (){
                                goBack();
                                if(nameController.text.isNotEmpty){
                                  AccountCubit.get(context).updateProfile(UpdateProfileUseCaseParams(
                                      name: nameController.text
                                  ));
                                }
                              }
                          );
                        },
                      ),
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
                      suffixIconWidget:CustomEditButton(
                        onPressed: () {
                          showSheet(context: context, controller: phoneController,
                              onSave: (){
                                goBack();
                                if(phoneController.text.isNotEmpty){
                                  AccountCubit.get(context).updateProfile(UpdateProfileUseCaseParams(
                                      phone: phoneController.text
                                  ));
                                }
                              }
                          );
                        },
                      ),
                      hint: "EnterMobile".tr(),
                    ),
                    16.verticalSpace,
                    CustomFormField(
                      controller: emailController,
                      header: "Email".tr(),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIconWidget:CustomEditButton(
                        onPressed: () {
                          showSheet(context: context, controller: emailController,
                              onSave: (){
                                goBack();
                                if(emailController.text.isNotEmpty){
                                  AccountCubit.get(context).updateProfile(UpdateProfileUseCaseParams(
                                      email: emailController.text
                                  ));
                                }
                              });
                        },
                      ),
                      prefixIcon: Icons.email_outlined,
                      hint: "EnterEmail".tr(),
                    ),
                    32.verticalSpace,
                    Row(
                      children: [
                        CustomTextButton(
                          onPressed: () {
                            navigateTo(const ChangePassScreen());
                          },
                          title: "ChangePassword".tr(),
                          titleColor: AppColors.gery455,
                          titleSize: 19.sp,
                          titleFontWeight: FontWeight.w600,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18.sp,
                          color: AppColors.gery455,
                        )
                      ],
                    ),
                    32.verticalSpace,
                    Row(
                      children: [
                        CustomTextButton(
                          //TODO implement delete account
                          onPressed: () {},
                          title: "DeleteAccount".tr(),
                          titleColor: AppColors.red,
                          titleSize: 19.sp,
                          titleFontWeight: FontWeight.w600,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18.sp,
                          color: AppColors.red,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
