import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/app/error/failures.dart';
import 'package:eccommerce_app/features/categories_feature/data/models/categories_model.dart';
import 'package:eccommerce_app/features/categories_feature/data/models/category_products.dart';
import 'package:eccommerce_app/features/categories_feature/data/models/product_details.dart';
import 'package:eccommerce_app/features/categories_feature/domain/repo/categories_repo.dart';

import '../../../../app/network/network_info.dart';
import '../../../../app/utils/hanlders/repo_impl_callhandler.dart';
import '../data_sources/categories_remote_data_source.dart';

class CategoriesRepoImpl extends CategoriesRepo{
  final CategoriesRemoteDataSource categoriesRemoteDataSource;
  final NetworkInfo networkInfo;

  CategoriesRepoImpl({required this.categoriesRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, CategoriesModel>> getAllCategories()async {
    return await RepoImplCallHandler<CategoriesModel>(networkInfo)(() async {
      return await categoriesRemoteDataSource.getAllCategories();
    });
  }

  @override
  Future<Either<Failure, CategoryProducts>> getCategoryProducts(int id)async {
    return await RepoImplCallHandler<CategoryProducts>(networkInfo)(() async {
      return await categoriesRemoteDataSource.getCategoryProducts(catId: id);
    });
  }

  @override
  Future<Either<Failure, ProductDetails>> getProductDetails(int id)async {
    return await RepoImplCallHandler<ProductDetails>(networkInfo)(() async {
      return await categoriesRemoteDataSource.getProductDetails(productId: id);
    });
  }
  
}