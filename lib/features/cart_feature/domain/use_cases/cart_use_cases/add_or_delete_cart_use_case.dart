import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/cart_models/get_all_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/domain/repo/cart_repo.dart';

import '../../../data/models/cart_models/add_or_delete_cart_model.dart';

class AddOrDeleteCartUseCase implements UseCase<AddOrDeleteToCartModel, AddOrDeleteCartUseCaseParams>{
  final CartRepo cartRepo ;

  AddOrDeleteCartUseCase({required this.cartRepo});
  @override
  Future<Either<Failure, AddOrDeleteToCartModel>> call(params) async {
    return await cartRepo.addOrDeleteCart(params.toMap());
  }

}

class AddOrDeleteCartUseCaseParams {
  final num productId;

  AddOrDeleteCartUseCaseParams(
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

