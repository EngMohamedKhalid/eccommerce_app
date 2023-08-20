import 'package:eccommerce_app/app/utils/consts.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/add_or_delete_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/get_all_cart_model.dart';

import '../../../../app/network/network_manager.dart';
import '../../../../app/utils/hanlders/remote_data_source_handler.dart';

abstract class CartRemoteDataSource {
  Future <GetAllCartModel> getAllCart() ;
  Future <AddOrDeleteToCartModel> addOrDeleteCart(Map <String,dynamic > map);
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
}