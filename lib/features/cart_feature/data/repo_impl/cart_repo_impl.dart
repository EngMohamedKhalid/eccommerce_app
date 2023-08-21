import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/cart_models/get_all_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/add_or_delete_favourite_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/get_all_favourites_model.dart';
import 'package:eccommerce_app/features/cart_feature/domain/repo/cart_repo.dart';

import '../../../../app/network/network_info.dart';
import '../../../../app/utils/hanlders/repo_impl_callhandler.dart';
import '../data_source/cart_remote_data_source.dart';
import '../models/cart_models/add_or_delete_cart_model.dart';

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

  @override
  Future<Either<Failure, AddOrDeleteToFavouriteModel>> addOrDeleteFavourite(Map<String, dynamic> map)async {
    return await RepoImplCallHandler<AddOrDeleteToFavouriteModel>(networkInfo)(() async {
      return await cartRemoteDataSource.addOrDeleteFavourite(map);
    });
  }

  @override
  Future<Either<Failure, GetAllFavouriteModel>> getAllFavourite() async{
    return await RepoImplCallHandler<GetAllFavouriteModel>(networkInfo)(() async {
      return await cartRemoteDataSource.getAllFavourite();
    });
  }
  
}