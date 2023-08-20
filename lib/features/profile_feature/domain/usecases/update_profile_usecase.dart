import 'package:dartz/dartz.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../../auth_feature/data/model/user_model.dart';
import '../repo/account_repo.dart';

class UpdateProfileUseCase implements UseCase<UserModel, UpdateProfileUseCaseParams> {
  final AccountRepo repository;

  UpdateProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(UpdateProfileUseCaseParams params) async{
    return await repository.updateProfile(params.toMap() as Map<String,String>);
  }
}

class UpdateProfileUseCaseParams {
  final String? name;
  final String? phone;
  final String? email;
  final String? company_name;

  UpdateProfileUseCaseParams(
      {
        this.name,
        this.phone,
        this.email,
        this.company_name,
      });

  Map<String, dynamic> toMap() {
    final map = {
      if(name!=null)"name": name!,
      if(phone!=null)"phone": phone!,
      if(email!=null)"email": email!,
      if(company_name!=null)"company_name": company_name!,
    };
    return map;
  }
}
