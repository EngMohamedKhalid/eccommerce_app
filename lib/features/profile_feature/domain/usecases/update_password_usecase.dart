import 'package:dartz/dartz.dart';

import '../../../../app/error/failures.dart';
import '../../../../app/usecase/usecase.dart';
import '../repo/account_repo.dart';

class UpdatePasswordUseCase implements UseCase<String, UpdatePasswordUseCaseParams> {
  final AccountRepo repository;

  UpdatePasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UpdatePasswordUseCaseParams params) async{
    return await repository.updatePassword(params.toMap());
  }
}

class UpdatePasswordUseCaseParams {
  final String old_password;
  final String password;
  final String password_confirmation;

  UpdatePasswordUseCaseParams(
      {
        required this.old_password,
        required this.password,
        required this.password_confirmation,
      });

  Map<String, String> toMap() {
    final map = {
      "old_password": old_password,
      "password": password,
      "password_confirmation": password_confirmation,
    };
    return map;
  }
}
