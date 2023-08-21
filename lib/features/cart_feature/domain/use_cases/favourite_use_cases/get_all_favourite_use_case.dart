import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/cart_models/get_all_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/get_all_favourites_model.dart';
import 'package:eccommerce_app/features/cart_feature/domain/repo/cart_repo.dart';

class GetAllFavouriteUseCase implements UseCase<GetAllFavouriteModel, NoParams>{
  final CartRepo cartRepo ;

  GetAllFavouriteUseCase({required this.cartRepo});
  @override
  Future<Either<Failure, GetAllFavouriteModel>> call(NoParams params) async {
    return await cartRepo.getAllFavourite();
  }

}