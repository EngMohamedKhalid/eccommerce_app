import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/cart_models/get_all_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/add_or_delete_favourite_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/get_all_favourites_model.dart';

import '../../../../app/error/failures.dart';
import '../../data/models/cart_models/add_or_delete_cart_model.dart';

abstract class CartRepo{
  Future <Either<Failure,GetAllCartModel>> getAllCart();
  Future <Either<Failure,GetAllFavouriteModel>> getAllFavourite();
  Future <Either<Failure,AddOrDeleteToCartModel>> addOrDeleteCart(Map<String,dynamic> map);
  Future <Either<Failure,AddOrDeleteToFavouriteModel>> addOrDeleteFavourite(Map<String,dynamic> map);
}