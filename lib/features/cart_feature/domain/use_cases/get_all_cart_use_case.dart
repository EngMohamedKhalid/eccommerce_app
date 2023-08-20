import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/get_all_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/domain/repo/cart_repo.dart';

class GetAllCartUseCase implements UseCase<GetAllCartModel, NoParams>{
  final CartRepo cartRepo ;

  GetAllCartUseCase({required this.cartRepo});
  @override
  Future<Either<Failure, GetAllCartModel>> call(NoParams params) async {
    return await cartRepo.getAllCart();
  }

}