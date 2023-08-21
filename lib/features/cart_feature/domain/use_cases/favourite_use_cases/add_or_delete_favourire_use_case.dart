import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/cart_models/get_all_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/add_or_delete_favourite_model.dart';
import 'package:eccommerce_app/features/cart_feature/domain/repo/cart_repo.dart';

import '../../../data/models/cart_models/add_or_delete_cart_model.dart';

class AddOrDeleteFavouriteUseCase implements UseCase<AddOrDeleteToFavouriteModel, AddOrDeleteFavouriteUseCaseParams>{
  final CartRepo cartRepo ;

  AddOrDeleteFavouriteUseCase({required this.cartRepo});
  @override
  Future<Either<Failure, AddOrDeleteToFavouriteModel>> call(params) async {
    return await cartRepo.addOrDeleteFavourite(params.toMap());
  }

}

class AddOrDeleteFavouriteUseCaseParams {
  final num productId;

  AddOrDeleteFavouriteUseCaseParams(
      {
        required this.productId,
      });

  Map<String, dynamic> toMap() {
    final map = {
      "product_id": productId,
    };
    return map;
  }
}

