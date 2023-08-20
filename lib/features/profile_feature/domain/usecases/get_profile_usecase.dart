import 'package:dartz/dartz.dart';

import '../../../../app/error/failures.dart';
import '../../../../app/usecase/usecase.dart';
import '../../../auth_feature/data/model/user_model.dart';
import '../repo/account_repo.dart';

class GetProfileUseCase implements UseCase<UserModel, NoParams> {
  final AccountRepo repository;

  GetProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async{
    return await repository.getProfile();
  }
}

