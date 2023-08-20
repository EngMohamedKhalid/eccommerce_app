import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/add_or_delete_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/get_all_cart_model.dart';

import '../../../../app/error/failures.dart';

abstract class CartRepo{
  Future <Either<Failure,GetAllCartModel>> getAllCart();
  Future <Either<Failure,AddOrDeleteToCartModel>> addOrDeleteCart(Map<String,dynamic> map);
}