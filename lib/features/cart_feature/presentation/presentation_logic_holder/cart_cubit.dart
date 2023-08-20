import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eccommerce_app/app/usecase/usecase.dart';
import 'package:eccommerce_app/features/cart_feature/data/models/add_or_delete_cart_model.dart';
import 'package:eccommerce_app/features/cart_feature/domain/use_cases/add_or_delete_cart_use_case.dart';
import 'package:eccommerce_app/features/cart_feature/domain/use_cases/get_all_cart_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../app/utils/navigation_helper.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/flutter_toast.dart';
import '../../data/models/get_all_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);
  GetAllCartModel ? getAllCartModel ;
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

  Future<void> addOrRemoveCart({required int id})async {
    emit(CartLoading());
    final res = await getIt<AddOrDeleteCartUseCase>()(
      AddOrDeleteCartUseCaseParams(productId: id)
    );
    res.fold(
      errorStateHandler,
          (r) {
        addOrDeleteToCartModel = r;
        // if(addOrDeleteToCartModel?.productDetails?.inCart==true){
        //   globalAlertDialogue(
        //     "This Product is Already In Cart,Do You Want To Remove it ?",
        //     buttonText2: "yes".tr(),
        //     buttonText: "No".tr(),
        //     canCancel: true,
        //     onOk: () {
        //       //cubit.removeCartItem(cubit.cartItems!.carItems[index].id.toString());
        //       Navigator.pop(getIt<NavHelper>().navigatorKey.currentState!.context);
        //     },
        //     onCancel: () {
        //       Navigator.pop(getIt<NavHelper>().navigatorKey.currentState!.context);
        //     },
        //   );
        // }else{
          showToast(msg: "Added Successfully To Cart",);
        //}
      },
    );
    emit(CartInitial());
  }

}
