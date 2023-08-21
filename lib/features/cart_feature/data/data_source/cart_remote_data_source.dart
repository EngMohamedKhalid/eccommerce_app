import 'package:eccommerce_app/app/utils/consts.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/cart_models/get_all_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/add_or_delete_favourite_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/get_all_favourites_model.dart';

import '../../../../app/network/network_manager.dart';
import '../../../../app/utils/hanlders/remote_data_source_handler.dart';
import '../models/cart_models/add_or_delete_cart_model.dart';

abstract class CartRemoteDataSource {
  Future <GetAllCartModel> getAllCart() ;
  Future <GetAllFavouriteModel> getAllFavourite() ;
  Future <AddOrDeleteToCartModel> addOrDeleteCart(Map <String,dynamic > map);
  Future <AddOrDeleteToFavouriteModel> addOrDeleteFavourite(Map <String,dynamic > map);
}



class CartRemoteDataSourceImpl implements CartRemoteDataSource{

  final NetworkManager networkManager;

  CartRemoteDataSourceImpl({required this.networkManager});

  @override
  Future<AddOrDeleteToCartModel> addOrDeleteCart(Map<String, dynamic> map)async {
    final res = await networkManager.requestWithFormData(
      endPoint: kAddOrRemoveCart,
      body: map,
        method: RequestMethod.post
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return AddOrDeleteToCartModel.fromJson(data.data??{});

  }

  @override
  Future<GetAllCartModel> getAllCart() async{
    final res = await networkManager.requestWithFormData(
      endPoint: kGetCart,
      method: RequestMethod.get
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return GetAllCartModel.fromJson(data.data??{});
  }

  @override
  Future<AddOrDeleteToFavouriteModel> addOrDeleteFavourite(Map<String, dynamic> map) async {
    final res = await networkManager.requestWithFormData(
        endPoint: kFavourites,
        body: map,
        method: RequestMethod.post
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return AddOrDeleteToFavouriteModel.fromJson(data.data??{});
  }

  @override
  Future<GetAllFavouriteModel> getAllFavourite()async {
    final res = await networkManager.requestWithFormData(
        endPoint: kFavourites,
        method: RequestMethod.get
    );
    final data =  await RemoteDataSourceCallHandler().handleFormData(res);
    return GetAllFavouriteModel.fromJson(data.data??{});
  }
}