import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/network/network_info.dart';
import 'package:eccommerce_app/features/auth_feature/data/data_source/auth_remote_data_source.dart';
import 'package:eccommerce_app/features/auth_feature/data/model/user_model.dart';
import 'package:eccommerce_app/features/auth_feature/domain/repo/auth_repo.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/repo_impl_callhandler.dart';

class AuthRepoImpl extends AuthRepo{
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepoImpl({required this.authRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, UserModel>> signIn(Map<String, dynamic> map)async {
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final result= await authRemoteDataSource.login(map);
      await getIt<CacheService>().setUserToken(token: result.token??"null");
      await getIt<CacheService>().saveUserData(encodedUser: json.encode(result.toJson()));
      return  result;
    });
  }

  @override
  Future<Either<Failure, String>> changePassword(Map<String, dynamic> map)async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      final result = await authRemoteDataSource.changePassword(map);
      return result;
    });
  }

  @override
  Future<Either<Failure, UserModel>> getProfile()async {
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final result = await authRemoteDataSource.getProfile();
      return result;
    });
  }

  @override
  Future<Either<Failure, String>> logout()async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      final result= await authRemoteDataSource.logout();
      await getIt<CacheService>().clear();
      return  result;
    });
  }

  @override
  Future<Either<Failure, UserModel>> register(Map<String, dynamic> map) async{
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final result= await authRemoteDataSource.register(map);
      await getIt<CacheService>().setUserToken(token: result.token??"null");
      await getIt<CacheService>().saveUserData(encodedUser: json.encode(result.toJson()));
      return  result;
    });
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(Map<String, dynamic> map) async{
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final result= await authRemoteDataSource.updateProfile(map);
      return  result;
    });
  }

}