import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/app/utils/helper.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/add_or_delete_favourite_model.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/get_all_favourites_model.dart';
import 'package:eccommerce_app/features/cart_feature/domain/use_cases/cart_use_cases/add_or_delete_cart_use_case.dart';
import 'package:eccommerce_app/features/cart_feature/domain/use_cases/cart_use_cases/get_all_cart_use_case.dart';
import 'package:eccommerce_app/features/cart_feature/domain/use_cases/favourite_use_cases/add_or_delete_favourire_use_case.dart';
import 'package:eccommerce_app/features/cart_feature/domain/use_cases/favourite_use_cases/get_all_favourite_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../app/utils/navigation_helper.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/flutter_toast.dart';
import '../../data/models/cart_models/add_or_delete_cart_model.dart';
import '../../data/models/cart_models/get_all_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);
  GetAllCartModel ? getAllCartModel ;
  GetAllFavouriteModel ? getAllFavouriteModel ;
  AddOrDeleteToFavouriteModel ? addOrDeleteToFavouriteModel ;
  AddOrDeleteToCartModel ? addOrDeleteToCartModel ;

  void getAllCart()async {
    emit(CartLoading());
    final res = await getIt<GetAllCartUseCase>()(NoParams());
    res.fold(
            errorStateHandler,
            (r) {
              getAllCartModel = r;
              print(getAllCartModel?.total??"");
              print(getAllCartModel?.subTotal??"");
              print(getAllCartModel?.carts.length??"");
            },
    );
    emit(CartInitial());
  }

  void getAllFavourite()async {
    emit(CartLoading());
    final res = await getIt<GetAllFavouriteUseCase>()(NoParams());
    res.fold(
            errorStateHandler,
            (r) {
              getAllFavouriteModel = r;
            },
    );
    emit(CartInitial());
  }

  Future<void> addOrRemoveCart({required int id, })async {
    emit(CartLoading());
    final res = await getIt<AddOrDeleteCartUseCase>()(
      AddOrDeleteCartUseCaseParams(productId: id)
    );
    res.fold(
      errorStateHandler,
          (r) {
        addOrDeleteToCartModel = r;
      },
    );
    getAllCart();
  }

  Future<void> addOrRemoveFavourite({required int id,})async {
    emit(CartLoading());
    final res = await getIt<AddOrDeleteFavouriteUseCase>()(
      AddOrDeleteFavouriteUseCaseParams(productId: id)
    );
    res.fold(
      errorStateHandler,
          (r) {
        addOrDeleteToFavouriteModel = r;
      },
    );
    //emit(CartInitial());
    getAllFavourite();
  }

  Future <void> addToCart({required int id})async{
    emit(CartLoading());
    final res = await getIt<AddOrDeleteCartUseCase>()(
        AddOrDeleteCartUseCaseParams(productId: id)
    );
    res.fold(
      errorStateHandler,
          (r) {
        addOrDeleteToCartModel = r;

      },
    );
    final resp = await getIt<AddOrDeleteFavouriteUseCase>()(
        AddOrDeleteFavouriteUseCaseParams(productId: id)
    );
    resp.fold(
      errorStateHandler,
          (r) {
        addOrDeleteToFavouriteModel = r;
      },
    );
    getAllFavourite();
  }
  Future <void> addToFavourite({required int id})async{
    emit(CartLoading());
    final res = await getIt<AddOrDeleteFavouriteUseCase>()(
        AddOrDeleteFavouriteUseCaseParams(productId: id)
    );
    res.fold(
      errorStateHandler,
          (r) {
        addOrDeleteToFavouriteModel = r;
      },
    );
    final resp = await getIt<AddOrDeleteCartUseCase>()(
        AddOrDeleteCartUseCaseParams(productId: id)
    );
    resp.fold(
      errorStateHandler,
          (r) {
        addOrDeleteToCartModel = r;
      },
    );
    getAllCart();
  }

}
