
import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/auth_feature/data/model/user_model.dart';
import 'package:eccommerce_app/features/auth_feature/domain/repo/auth_repo.dart';

class UpdateProfileUseCase implements UseCase<UserModel , UpdateProfileUseCaseParams>{
  final AuthRepo authRepo ;
  UpdateProfileUseCase({required this.authRepo});
  @override
  Future<Either<Failure, UserModel>> call(UpdateProfileUseCaseParams params) {
    return authRepo.updateProfile(params.toMap());
  }

}
class UpdateProfileUseCaseParams{
  final String name;
  final String phone;
  final String email;
  final String password;
  final String image;

  UpdateProfileUseCaseParams(
      {required this.name,required  this.phone,required  this.email, required this.password,required  this.image});


  Map<String ,dynamic> toMap(){
    final map={
      "name":name,
      "phone":phone,
      "email":email,
      "password":password,
      "image":image,
    };
    return map;
}
}