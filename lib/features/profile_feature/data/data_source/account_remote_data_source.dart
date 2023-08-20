
import '../../../../app/network/network_manager.dart';
import '../../../../app/utils/consts.dart';
import '../../../../app/utils/hanlders/remote_data_source_handler.dart';
import '../../../auth_feature/data/model/user_model.dart';

abstract class AccountRemoteDataSource {
  /// Calls the [Get] {profile} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getProfile();

   /// Calls the [PUT] {update-profile} endpoint.
   ///
   /// Throws a [ServerException] for all error codes.
   Future<UserModel> updateProfile(Map<String, String> map);

   /// Calls the [POST] {contact-us} endpoint.
   ///
   /// Throws a [ServerException] for all error codes.
   Future<String> contactUs(Map<String, String> map);

  /// Calls the [PATCH] {change-lang?lang=en} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> changeLanguage(Map<String, String> map);

  /// Calls the [PATCH] {update-passward} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> changePassword(Map<String, String> map);

}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final NetworkManager networkManager;

  AccountRemoteDataSourceImpl({required this.networkManager});

  @override
  Future<UserModel> getProfile() async {
    final res = await networkManager.requestWithFormData(
      endPoint: kProfile,
      method: RequestMethod.get,
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return UserModel.fromMap(data.data);
  }

  @override
  Future<UserModel> updateProfile(Map<String, String> map) async {
    final res = await networkManager.requestWithFormData(
      endPoint: kUpdateProfile,
      method: RequestMethod.put,
      body: map
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return UserModel.fromMap(data.data['user']);
  }
// todo add keys here
  @override
  Future<String> contactUs(Map<String, String> map) async {
    final res = await networkManager.requestWithFormData(
      endPoint: "kContactUs",
      body: map,
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return data.msg??"";
  }

  @override
  Future<String> changeLanguage(Map<String, String> map) async {
    final res = await networkManager.requestWithFormData(
      endPoint: "kChangeLanguage",
      queryParameters: map,
      method: RequestMethod.patch
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return data.msg??"";
  }

  @override
  Future<String> changePassword(Map<String, String> map) async {
    final res = await networkManager.requestWithFormData(
        endPoint: "kUpdatePassword",
        body: map,
        method: RequestMethod.patch
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return data.msg??"";
  }

}