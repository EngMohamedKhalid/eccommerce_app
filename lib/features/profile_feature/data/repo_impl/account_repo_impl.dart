import 'package:dartz/dartz.dart';
import '../../../../app/error/failures.dart';
import '../../../../app/network/network_info.dart';
import '../../../../app/utils/hanlders/repo_impl_callhandler.dart';
import '../../../auth_feature/data/model/user_model.dart';
import '../../domain/repo/account_repo.dart';
import '../data_source/account_remote_data_source.dart';

class AccountRepoImpl extends AccountRepo{
  final AccountRemoteDataSource accountRemoteDataSource;
  final NetworkInfo networkInfo;
  AccountRepoImpl({required this.accountRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserModel>> getProfile()async {
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      return await accountRemoteDataSource.getProfile();
    });
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(Map<String,String> map)async {
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      return await accountRemoteDataSource.updateProfile(map);
    });
  }
  @override
  Future<Either<Failure, String>> contactUs(Map<String,String> map)async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      return await accountRemoteDataSource.contactUs(map);
    });
  }
  @override
  Future<Either<Failure, String>> changeLanguage(Map<String,String> map)async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      return await accountRemoteDataSource.changeLanguage(map);
    });
  }
  @override
  Future<Either<Failure, String>> updatePassword(Map<String,String> map)async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      return await accountRemoteDataSource.changePassword(map);
    });
  }


}