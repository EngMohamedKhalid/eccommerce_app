import 'package:dartz/dartz.dart';
import 'package:eccommerce_app/features/categories_feature/data/models/category_products.dart';
import 'package:eccommerce_app/features/categories_feature/data/models/product_details.dart';

import '../../../../app/error/failures.dart';
import '../../data/models/categories_model.dart';

abstract class CategoriesRepo{
  Future<Either<Failure, CategoriesModel>>getAllCategories();
  Future<Either<Failure, CategoryProducts>>getCategoryProducts(int id);
  Future<Either<Failure, ProductDetails>>getProductDetails(int id);
}