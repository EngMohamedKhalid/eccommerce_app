import 'package:dartz/dartz.dart';
import '../../../../app/error/failures.dart';
import '../../../auth_feature/data/model/user_model.dart';

abstract  class AccountRepo{
  Future<Either<Failure, UserModel>>getProfile();
  Future<Either<Failure, UserModel>>updateProfile(Map<String,String> map);
  Future<Either<Failure, String>>contactUs(Map<String,String> map);
  Future<Either<Failure, String>>changeLanguage(Map<String,String> map);
  Future<Either<Failure, String>>updatePassword(Map<String,String> map);
}