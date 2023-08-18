import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/auth_feature/data/model/user_model.dart';
import 'package:eccommerce_app/features/auth_feature/domain/repo/auth_repo.dart';

class LogOutUseCase implements UseCase<String,NoParams>{
  final AuthRepo authRepo;

  LogOutUseCase({required this.authRepo});

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return authRepo.logout();
  }

}