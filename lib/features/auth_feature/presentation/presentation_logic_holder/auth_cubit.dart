import 'dart:io';
import 'package:eccommerce_app/features/auth_feature/domain/usecases/login_use_case.dart';
import 'package:eccommerce_app/features/auth_feature/domain/usecases/register_use_case.dart';
import 'package:eccommerce_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/error/failures.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/utils/navigation_helper.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/flutter_toast.dart';
import '../../data/model/user_model.dart';
import '../screens/new_pass_screen.dart';
import '../screens/otp_screen.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);
  //sign in
  final loginPasswordController = TextEditingController();
  final loginEmailController = TextEditingController();
  UserModel ? userModel;
  //sign up
  final signUpFullNameController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpEmailController = TextEditingController();

  bool passObscure = true;

  void changeVisible(){
    passObscure = !passObscure;
    emit(AuthVisiblePasswordState(passObscure));
  }


  void login()async{
    emit(LoadingState());
    final res = await getIt<LogInUseCase>()(
      LoginUseCaseParams(
          email: loginEmailController.text,
          password: loginPasswordController.text,

      )
    );
    res.fold(
            errorStateHandler,
            (r) {
              userModel = r;
              print(userModel?.token);
              print("+========================");
              print(userModel?.name);
              print(userModel?.email);
              print(userModel?.id);
              showToast(msg: "From Sign In", backgroundColor: AppColors.mainColor, textColor: Colors.white).then((value){});
              navigateTo(HomeScreen());
            },
    );
    emit(AuthInitial());
  }


  void register()async{
    emit(LoadingState());
    final res = await getIt<RegisterUseCase>()(
     RegisterUseCaseParams(
         name: signUpFullNameController.text,
         phone: signUpPhoneController.text,
         password: signUpPasswordController.text,
         email: signUpEmailController.text,
     )
    );
    res.fold(
            errorStateHandler,
            (r) {
              userModel = r;
              print(userModel?.token);
              print("+========================");
              print(userModel?.name);
              print(userModel?.email);
              print(userModel?.id);
              showToast(msg: "From Sign Up", backgroundColor: AppColors.mainColor, textColor: Colors.white).then((value){});
              navigateTo(HomeScreen());
            },
    );
    emit(AuthInitial());
  }


}
