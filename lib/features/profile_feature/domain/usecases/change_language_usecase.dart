import 'package:dartz/dartz.dart';

import '../../../../app/error/failures.dart';
import '../../../../app/usecase/usecase.dart';
import '../repo/account_repo.dart';

class ChangeLanguageUseCase implements UseCase<String, ChangeLanguageUseCaseParams> {
  final AccountRepo repository;

  ChangeLanguageUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ChangeLanguageUseCaseParams params) async{
    return await repository.changeLanguage(params.toMap());
  }

}
class ChangeLanguageUseCaseParams {
  final String lang;

  ChangeLanguageUseCaseParams(
      {
        required this.lang,
      });

  Map<String, String> toMap() {
    final map = {
      "lang": lang,
    };
    return map;
  }
}
