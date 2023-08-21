import 'package:easy_localization/easy_localization.dart';
import 'package:eccommerce_app/features/cart_feature/presentation/widgets/custom_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/loading.dart';
import '../presentation_logic_holder/cart_cubit.dart';

class CustomSavedBody extends StatefulWidget {
  const CustomSavedBody({super.key});

  @override
  State<CustomSavedBody> createState() => _CustomSavedBodyState();
}

class _CustomSavedBodyState extends State<CustomSavedBody> {
  @override
  void initState() {
    super.initState();
    CartCubit.get().getAllFavourite();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit = CartCubit.get();
        return state is CartLoading? const Loading():
        ListView.builder(
          padding:EdgeInsets.all(16.sp) ,
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.getAllFavouriteModel?.favourites.length??0,
          itemBuilder: (context, index) {
            return CustomCartItem(
              deleteOnPressed: () {
                globalAlertDialogue(
                  "Delete".tr(),
                  buttonText2: "yes".tr(),
                  buttonText: "No".tr(),
                  canCancel: true,
                  onOk: () {
                   cubit.addOrRemoveFavourite(
                       id: cubit.getAllFavouriteModel?.favourites[index].productDetails?.id?.toInt()??0,
                   );
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                );
                },
              minusOnPressed: () {
                // if((cubit.favouriteItems?.favourite[index].quantity?.toInt()??1)>1){
                //   cubit.updateFavouriteQuantity("${(cubit.favouriteItems?.favourite[index].quantity?.toInt()??1)-1}",
                //       cubit.favouriteItems!.favourite[index].id.toString());
                // }
              },
              addOnPressed: () {
                // if((cubit.favouriteItems?.favourite[index].quantity?.toInt()??1)<
                //     (cubit.favouriteItems?.favourite[index].product?.quantity?.toInt()??1)){
                //   cubit.updateFavouriteQuantity("${(cubit.favouriteItems?.favourite[index].quantity?.toInt()??1)+1}",
                //       cubit.favouriteItems!.favourite[index].id.toString());
                // }
              },
              saveOnPressed: ()async {
                await cubit.addToCart(id: cubit.getAllFavouriteModel?.favourites[index].productDetails?.id?.toInt()??0,);
               //  await CartCubit.get().addOrRemoveCart(
               //    id: cubit.getAllFavouriteModel?.favourites[index].productDetails?.id?.toInt()??0,
               //  );
               // await cubit.addOrRemoveFavourite(
               //      id: cubit.getAllFavouriteModel?.favourites[index].productDetails?.id?.toInt()??0,
               //  );
                },
              countNum: 5,
              title:  cubit.getAllFavouriteModel?.favourites[index].productDetails?.name??"",
              imageName: cubit.getAllFavouriteModel?.favourites[index].productDetails?.image??"",
              price: cubit.getAllFavouriteModel?.favourites[index].productDetails?.price.toString()??"",
              //piecesNum:cubit.favouriteItems?.favourite[index].product?.quantity?.toInt()??0,
            );
          },
        );
      },
    );
  }
}
