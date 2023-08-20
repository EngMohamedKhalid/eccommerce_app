import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/add_or_delete_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/get_all_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/domain/repo/cart_repo.dart';

import '../../../../app/network/network_info.dart';
import '../../../../app/utils/hanlders/repo_impl_callhandler.dart';
import '../data_source/cart_remote_data_source.dart';

class CartRepoImpl extends CartRepo{
  final CartRemoteDataSource cartRemoteDataSource;
  final NetworkInfo networkInfo;

  CartRepoImpl({required this.cartRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, AddOrDeleteToCartModel>> addOrDeleteCart(Map<String, dynamic> map) async{
    return await RepoImplCallHandler<AddOrDeleteToCartModel>(networkInfo)(() async {
      return await cartRemoteDataSource.addOrDeleteCart(map);
    });
  }

  @override
  Future<Either<Failure, GetAllCartModel>> getAllCart()async {
    return await RepoImplCallHandler<GetAllCartModel>(networkInfo)(() async {
      return await cartRemoteDataSource.getAllCart();
    });
  }
  
}