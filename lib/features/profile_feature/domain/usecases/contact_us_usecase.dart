import 'package:dartz/dartz.dart';

import '../../../../app/error/failures.dart';
import '../../../../app/usecase/usecase.dart';
import '../repo/account_repo.dart';

class ContactUsUseCase implements UseCase<String, ContactUsUseCaseParams> {
  final AccountRepo repository;

  ContactUsUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ContactUsUseCaseParams params) async{
    return await repository.contactUs(params.toMap());
  }
}

class ContactUsUseCaseParams {
  final String name;
  final String phone;
  final String email;
  final String messages;

  ContactUsUseCaseParams(
      {
        required this.name,
        required this.phone,
        required this.email,
        required this.messages,
      });

  Map<String, String> toMap() {
    final map = {
      "name": name,
      "phone": phone,
      "email": email,
      "messages": messages,
    };
    return map;
  }
}
