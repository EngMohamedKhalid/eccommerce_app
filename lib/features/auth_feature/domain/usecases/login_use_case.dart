import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/auth_feature/data/model/user_model.dart';
import 'package:eccommerce_app/features/auth_feature/domain/repo/auth_repo.dart';

class LogInUseCase implements UseCase<UserModel ,LoginUseCaseParams>{
  final AuthRepo authRepo;

  LogInUseCase({required this.authRepo});
  @override
  Future<Either<Failure, UserModel>> call(params) async {
   return await authRepo.signIn(params.toMap());
  }

}




class LoginUseCaseParams{
  final String email;
  final String password;

  LoginUseCaseParams({required  this.password,required this.email});

  Map<String, dynamic> toMap() {
    final map = {
     "email":email,
     "password":password,
    };
    return map;
  }

}