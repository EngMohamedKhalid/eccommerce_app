import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/services/cache_service.dart';
import '../../../../../app/utils/get_it_injection.dart';
import '../../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../../app/utils/helper.dart';
import '../../../../../app/utils/navigation_helper.dart';
import '../../../../../app/widgets/custom_alert_dialog.dart';
import '../../../domain/usecases/contact_us_usecase.dart';
import '../../../domain/usecases/update_password_usecase.dart';
import '../../../domain/usecases/update_profile_usecase.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  static AccountCubit get(context) => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);
  bool passObscure = true;

  void changeVisible(){
    passObscure = !passObscure;
    emit(AccountVisiblePasswordState(passObscure));
  }
  void contactUs(ContactUsUseCaseParams params) async {
    emit(ContactUsLoading());
    final response = await getIt<ContactUsUseCase>()(params);
    response.fold(
      errorStateHandler,
          (r) {
            goBack();
            globalAlertDialogue(r);
          },
    );
    emit(AccountInitial());
  }

  void updateProfile(UpdateProfileUseCaseParams params) async {
    emit(UpdateProfileLoading());
    final response = await getIt<UpdateProfileUseCase>()(params);
    response.fold(
      errorStateHandler,
          (r) {
        getIt<CacheService>().saveUserData(encodedUser: json.encode(r.toJson()));
      },
    );
    emit(AccountInitial());
  }

  void changePassword(UpdatePasswordUseCaseParams params) async {
    emit(UpdatePasswordLoading());
    final response = await getIt<UpdatePasswordUseCase>()(params);
    response.fold(
      errorStateHandler,
          (r) {
        goBack();
        globalAlertDialogue(r);
      },
    );
    emit(AccountInitial());
  }
}
