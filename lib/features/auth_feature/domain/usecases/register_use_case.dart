import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/auth_feature/data/model/user_model.dart';
import 'package:eccommerce_app/features/auth_feature/domain/repo/auth_repo.dart';

class RegisterUseCase implements UseCase<UserModel ,RegisterUseCaseParams>{
  final AuthRepo authRepo;

  RegisterUseCase({required this.authRepo});
  @override
  Future<Either<Failure, UserModel>> call(params) async {
    return await authRepo.register(params.toMap());
  }

}




class RegisterUseCaseParams{
  final String name;
  final String phone;
  final String password;
  final String email;

  RegisterUseCaseParams({required this.name ,required this.phone,required  this.password,required this.email});

  Map<String, dynamic> toMap() {
    final map = {
      "name":name,
      "phone":phone,
      "password":password,
      "email":email,
    };
    return map;
  }

}